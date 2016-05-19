//
//  TypesTableViewController.swift
//  SmogApp
//
//  Created by Myrenkar on 24.03.2016.
//  Copyright © 2016 moo. All rights reserved.
//

import UIKit

protocol TypesTableViewControllerDelegate: class {
    func typesController(controller: TypesTableViewController, didSelectTypes types: [String])
}

class TypesTableViewController: UITableViewController {

    var possibleTypesDictionary = [String: String]()
    var selectedTypes: [String]!
    weak var delegate: TypesTableViewControllerDelegate!
    var selectedKey = ""

    func getLanguageDictionary () -> Dictionary<String, String> {

        if possibleTypesDictionary.isEmpty {
            possibleTypesDictionary = ["pm10": "Pył zawieszony PM10", "pm2.5": "Pył zawieszony PM2.5", "no2": "Dwutlenek azotu (NO2)", "so2": "Dwutlenek siarki (SO2)", "co": "Tlenek węgla (CO)", "o3": "Ozon (O3)"]
        }
        return possibleTypesDictionary

    }

    override func viewDidLoad() {

        super.viewDidLoad()
        tableView.backgroundView = UIImageView(image: UIImage(named: "logopogo"))
        let defaults = NSUserDefaults.standardUserDefaults()
        debugPrint(defaults.stringForKey(PollutionChosen.Pollution)!)
        getLanguageDictionary()

    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return possibleTypesDictionary.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TypeCell", forIndexPath: indexPath)

        let type = Array(self.possibleTypesDictionary.values)[indexPath.row]
        let key = Array(self.possibleTypesDictionary.keys)[indexPath.row]
        cell.textLabel?.text = type

        let identifier = NSUserDefaults.standardUserDefaults().objectForKey(PollutionChosen.Pollution) as! String // getCurrentLanguage()
        //

        if identifier == key {
            cell.accessoryType = .Checkmark
            tableView.selectRowAtIndexPath(indexPath, animated: false, scrollPosition: UITableViewScrollPosition.Bottom)
        } else {
            cell.accessoryType = .None
        }
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            cell.accessoryType = .Checkmark
            let key = Array(self.possibleTypesDictionary.keys)[indexPath.row]
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setValue(key, forKey: PollutionChosen.Pollution)
            selectedKey = key
        }

        self.dismissViewControllerAnimated(false, completion: nil)
    }
    // MARK: - Table view delegate
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            cell.accessoryType = .None
        }
    }
    @IBAction func donePressed(sender: AnyObject) {

        self.performSegueWithIdentifier("showFilteredData", sender: self)
    }
}
