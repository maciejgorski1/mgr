//
//  InformationVC.swift
//  SmogApp
//
//  Created by Myrenkar on 28.02.2016.
//  Copyright © 2016 moo. All rights reserved.
//

import UIKit

class InformationVC: UIViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var myWebView: UIWebView!
    /*
     // Only override drawRect: if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func drawRect(rect: CGRect) {
     // Drawing code
     }
     */

    override func viewDidLoad() {
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }

        let myURL = NSBundle.mainBundle().URLForResource("co", withExtension: "html")

        // let myWebView: UIWebView = UIWebView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height))
        let requestObj = NSURLRequest(URL: myURL!)
        myWebView.loadRequest(requestObj)
        // Set the WebApp URL in this line
//        myWebView.loadRequest(NSURLRequest(URL: NSURL(string: "http://monitoring.krakow.pios.gov.pl/opis-monitorowanych-substancji#_page_1")!))
//        myWebView.loadHTMLString(<#T##string: String##String#>, baseURL: <#T##NSURL?#>)
        self.view.addSubview(myWebView)
    }

}
