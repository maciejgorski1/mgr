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
    @IBOutlet weak var coButton: UIButton!
    @IBOutlet weak var so2Button: UIButton!
    @IBOutlet weak var pm10Button: UIButton!
    @IBOutlet weak var noxButton: UIButton!
    @IBOutlet weak var benzenButton: UIButton!
    @IBOutlet weak var ozonButton: UIButton!

    
    
    @IBAction func coButtonClicked(sender: AnyObject) {
    }
    
    @IBAction func so2ButtonClicked(sender: AnyObject) {
    }

    @IBAction func pm10ButtonClicked(sender: AnyObject) {
    }
    @IBAction func noxButtonClicked(sender: AnyObject) {
    }
    @IBAction func benzenButtonClicked(sender: AnyObject) {
    }
    
    @IBAction func ozonButtonClicked(sender: AnyObject) {
    }
    
    
    
    
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
