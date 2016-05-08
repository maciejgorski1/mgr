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

    var myURL = NSBundle.mainBundle().URLForResource("co", withExtension: "html")

    override func viewDidLoad() {
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }

        self.coButton.layer.cornerRadius = self.coButton.frame.height / 2
        self.coButton.layer.masksToBounds = true

        let requestObj = NSURLRequest(URL: myURL!)
        myWebView.loadRequest(requestObj)
        self.view.addSubview(myWebView)
        
        setUpAppeareance()
    }
    func setUpAppeareance(){
        self.coButton.layer.cornerRadius = self.coButton.frame.height / 2
        self.coButton.layer.masksToBounds = true
        
        self.so2Button.layer.cornerRadius = self.so2Button.frame.height / 2
        self.so2Button.layer.masksToBounds = true
        
        self.pm10Button.layer.cornerRadius = self.pm10Button.frame.height / 2
        self.pm10Button.layer.masksToBounds = true
        
        self.noxButton.layer.cornerRadius = self.noxButton.frame.height / 2
        self.noxButton.layer.masksToBounds = true
        
        self.benzenButton.layer.cornerRadius = self.benzenButton.frame.height / 2
        self.benzenButton.layer.masksToBounds = true
        
        self.ozonButton.layer.cornerRadius = self.ozonButton.frame.height / 2
        self.ozonButton.layer.masksToBounds = true
    }
    
    

    @IBAction func coButtonClicked(sender: AnyObject) {
        myURL = NSBundle.mainBundle().URLForResource("co", withExtension: "html")
        let requestObj = NSURLRequest(URL: myURL!)
        myWebView.loadRequest(requestObj)
    }

    @IBAction func so2ButtonClicked(sender: AnyObject) {
        myURL = NSBundle.mainBundle().URLForResource("so2", withExtension: "html")
        let requestObj = NSURLRequest(URL: myURL!)
        myWebView.loadRequest(requestObj)
    }

    @IBAction func pm10ButtonClicked(sender: AnyObject) {
        myURL = NSBundle.mainBundle().URLForResource("pm10", withExtension: "html")
        let requestObj = NSURLRequest(URL: myURL!)
        myWebView.loadRequest(requestObj)
    }
    @IBAction func noxButtonClicked(sender: AnyObject) {
        myURL = NSBundle.mainBundle().URLForResource("nox", withExtension: "html")
        let requestObj = NSURLRequest(URL: myURL!)
        myWebView.loadRequest(requestObj)
    }
    @IBAction func benzenButtonClicked(sender: AnyObject) {
        myURL = NSBundle.mainBundle().URLForResource("benzen", withExtension: "html")
        let requestObj = NSURLRequest(URL: myURL!)
        myWebView.loadRequest(requestObj)
    }

    @IBAction func ozonButtonClicked(sender: AnyObject) {
        myURL = NSBundle.mainBundle().URLForResource("ozon", withExtension: "html")
        let requestObj = NSURLRequest(URL: myURL!)
        myWebView.loadRequest(requestObj)
    }

}
