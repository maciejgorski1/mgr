//
//  GalleryViewController.swift
//  SmogApp
//
//  Created by Myrenkar on 28.02.2016.
//  Copyright © 2016 moo. All rights reserved.
//

import UIKit
import RealmSwift
import TNImageSliderViewController

class GalleryViewController: UIViewController {
    @IBOutlet weak var menuButton: UIBarButtonItem!
    var images: [UIImage] = []
    let imageNames = ["Add.png"]
    var imageSliderVC: TNImageSliderViewController!
    override func viewDidLoad() {
        super.viewDidLoad()

        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        getImageFromLocalStorage { (isFinished) -> Void in
            self.imageSliderVC.images = self.images
            var options = TNImageSliderViewOptions()
            options.pageControlHidden = false
            options.scrollDirection = .Horizontal
            options.pageControlCurrentIndicatorTintColor = UIColor.yellowColor()
            options.autoSlideIntervalInSeconds = 2
            options.shouldStartFromBeginning = true
            options.imageContentMode = .ScaleAspectFit

            self.imageSliderVC.options = options
        }

    }

    override func viewWillAppear(animated: Bool) {

    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("[ViewController] Prepare for segue")

        if (segue.identifier == "seg_imageSlider") {

            imageSliderVC = segue.destinationViewController as! TNImageSliderViewController

        }

    }

    private func getImageFromLocalStorage(callback: (isFinished: Bool) -> Void) {
        let fileManager = NSFileManager.defaultManager()

        var dataFile: String?
        let filePath = "/"
        let dirPaths = NSSearchPathForDirectoriesInDomains(
                .DocumentDirectory, .UserDomainMask, true)

        let docsDir = dirPaths[0] ?? ""
        dataFile = (docsDir.stringByAppendingString(filePath))

        if let directoryUrls = try? fileManager.contentsOfDirectoryAtPath(dataFile!) {
            for (_, value) in directoryUrls.enumerate() {
                let imageDir = "\(docsDir)/\(value)"
                images.append(UIImage(contentsOfFile: imageDir)!)
            }
            callback(isFinished: true)
        }

    }

}
