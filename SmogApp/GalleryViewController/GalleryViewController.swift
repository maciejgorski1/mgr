//
//  GalleryViewController.swift
//  SmogApp
//
//  Created by Myrenkar on 28.02.2016.
//  Copyright © 2016 moo. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftPhotoGallery
import NYTPhotoViewer

class GalleryViewController: UIViewController, SwiftPhotoGalleryDataSource, SwiftPhotoGalleryDelegate {
    @IBOutlet weak var menuButton: UIBarButtonItem!
    var images = []
    let imageNames = ["Add.png"]

    override func viewDidLoad() {
        super.viewDidLoad()

        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }

    }
    override func viewWillAppear(animated: Bool) {
        // getImageFromLocalStorage()
    }
    override func viewDidAppear(animated: Bool) {

        let gallery = SwiftPhotoGallery(delegate: self, dataSource: self)
        presentViewController(gallery, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfImagesInGallery(gallery: SwiftPhotoGallery) -> Int {
        return imageNames.count
    }

    func imageInGallery(gallery: SwiftPhotoGallery, forIndex: Int) -> UIImage? {

        return UIImage(named: String(imageNames[forIndex]))
    }

    func galleryDidTapToClose(gallery: SwiftPhotoGallery) {
        dismissViewControllerAnimated(true, completion: nil)

    }

    private func getImageFromLocalStorage() {
        let fileManager = NSFileManager.defaultManager()

        var dataFile: String?
        let filePath = "/"
        let dirPaths = NSSearchPathForDirectoriesInDomains(
                .DocumentDirectory, .UserDomainMask, true)

        let docsDir = dirPaths[0] ?? ""
        dataFile = (docsDir.stringByAppendingString(filePath))

        if let directoryUrls = try? fileManager.contentsOfDirectoryAtPath(dataFile!) {
            for (_, value) in directoryUrls.enumerate() {
                images.arrayByAddingObject(UIImage(contentsOfFile: "\(dataFile)\(value)")!)
            }
        }

    }

}
