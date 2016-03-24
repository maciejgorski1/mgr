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

    let possibleTypesDictionary = ["pm10": "pył PM10", "pm2.5": "pył PM2.5", "no2": "Dwutlenek azotu", "nox": "Tlenki azotu", "no": "Tlenek azotu"]
    var selectedTypes: [String]!
    weak var delegate: TypesTableViewControllerDelegate!
    var sortedKeys: [String] {
        return possibleTypesDictionary.keys.sort()
    }

    // MARK: - Actions
    @IBAction func donePressed(sender: AnyObject) {
        delegate?.typesController(self, didSelectTypes: selectedTypes)
    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return possibleTypesDictionary.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TypeCell", forIndexPath: indexPath)
        let key = sortedKeys[indexPath.row]
        let type = possibleTypesDictionary[key]!
        cell.textLabel?.text = type
        cell.accessoryType = (selectedTypes).contains(key) ? .Checkmark : .None
        return cell
    }

    // MARK: - Table view delegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let key = sortedKeys[indexPath.row]
        if (selectedTypes!).contains(key) {
            selectedTypes = selectedTypes.filter({ $0 != key })
        } else {
            selectedTypes.append(key)
        }

        tableView.reloadData()
    }
}
