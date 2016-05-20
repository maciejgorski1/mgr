//
//  SettingsViewController.swift
//  SmogApp
//
//  Created by Myrenkar on 28.02.2016.
//  Copyright © 2016 moo. All rights reserved.
//

import UIKit
import SwiftyJSON
import SCLAlertView

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var alerts = [String: String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        
        if Reachability.isConnectedToNetwork() == true {
            prepareData { (isFinished) in
                self.tableView.reloadData()
                self.removeAllOverlays()
            }
            
        } else {
            
            SCLAlertView().showError("Brak internetu ", subTitle: "Upewnij się, że masz połączenie z internetem")
            
        }
        
    }
    
    func prepareData(callback: (isFinished: Bool) -> Void)
    { self.showWaitOverlay()
        for index in 1 ... 23 {
            RequestManager.citiesWithHandler(index, completionHandler: { (response) -> Void in
                if response.result.isSuccess{
                    let json = JSON(data: (response.data! as NSData))
                    let dataToParse = json["dane"]
                    let cityData = dataToParse["city"]
                    let city = cityData["ci_citydesc"].string!
                    let messageData = dataToParse["message"]
                    var message = ""
                    if !messageData.isEmpty {
                        
                        let type = messageData["type"].double!
                        message = messageData["message"].string!
                        if message != "" {
                            
                            if self.alerts[city] == nil {
                                self.alerts[city] = message
                            }
                            
                        }
                        
                    }
                    if index == 23 {
                        callback(isFinished: true)
                    }
                }
                
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alerts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("alertCell", forIndexPath: indexPath) as! AlertTableViewCell
        let sortedAllerts = self.alerts.keys.sort()
        let alertIndex = [sortedAllerts[indexPath.row]].first!
        let messagesArray = self.alerts[alertIndex]
        
        cell.cityLabel.text = alertIndex
        cell.textlabel.text = messagesArray
        return cell
    }
}
