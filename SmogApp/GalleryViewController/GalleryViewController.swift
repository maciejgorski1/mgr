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

class GalleryViewController: UIViewController, SwiftPhotoGalleryDataSource, SwiftPhotoGalleryDelegate {
    @IBOutlet weak var menuButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        let gallery = SwiftPhotoGallery(delegate: self, dataSource: self)
        
        presentViewController(gallery, animated: true, completion: nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfImagesInGallery(gallery:SwiftPhotoGallery) -> Int {
        return imageNames.count
    }
    
    func imageInGallery(gallery:SwiftPhotoGallery, forIndex:Int) -> UIImage? {
        
        return UIImage(named: imageNames[forIndex])
    }

    private func getImageFromLocalStorage(imageID : NSString, callback: (image: UIImage?) -> Void) {
        
        let imageName = "\(imageID).png"
        let fileManager = NSFileManager.defaultManager()
        
        var docsDir: String?
        var dataFile: String?
        let filePath = "/" + imageName
        let dirPaths = NSSearchPathForDirectoriesInDomains(
            .DocumentDirectory, .UserDomainMask, true)
        
        docsDir = dirPaths[0] as? String
        dataFile = (docsDir?.stringByAppendingString(filePath))!
        
        if fileManager.fileExistsAtPath(dataFile!) {
            callback(image: UIImage(contentsOfFile: dataFile!))
        }
        else {
            callback(image: nil)
        }
    }
    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}
