//
//  GalleryViewController.swift
//  SmogApp
//
//  Created by Myrenkar on 28.02.2016.
//  Copyright © 2016 moo. All rights reserved.
//

import UIKit
import Agrume

class GalleryViewController: UICollectionViewController {
    @IBOutlet weak var menuButton: UIBarButtonItem!
    private let identifier = "Cell"
    var images: [UIImage] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        getImageFromLocalStorage { (isFinished) -> Void in
        }

        let layout = collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: CGRectGetWidth(view.bounds), height: CGRectGetHeight(view.bounds))
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath) as! DemoCell
        cell.imageView.image = images[indexPath.row]
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let agrume = Agrume(images: images, startIndex: indexPath.row, backgroundBlurStyle: .Light)
        agrume.didScroll = {
            [unowned self] index in
            self.collectionView?.scrollToItemAtIndexPath(NSIndexPath(forRow: index, inSection: 0),
                atScrollPosition: [],
                animated: false)
        }
        agrume.showFrom(self)
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
