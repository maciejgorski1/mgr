//
//  PollutionModel.swift
//  SmogApp
//
//  Created by Myrenkar on 29.02.2016.
//  Copyright © 2016 moo. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyJSON

class PollutionModel: Object {

    dynamic var lattitude = 0.0
    dynamic var longitute = 0.0
    dynamic var city: String?
    dynamic var cityDesc: String?

    let parameters = List<Parameters>()

    class func citiesSerialization(jsonArray: NSData) {
        var citySet = Set<String>()
        let json = JSON(data: jsonArray)
//        debugPrint(json)

        for (index, subJSON): (String, JSON) in json {

            debugPrint(subJSON)
            citySet.insert(subJSON["citydesc"].string!)
        }
        debugPrint(citySet)
    }

    class func pollutionSerialization(jsonArray: NSData) {
        var citySet = Set<String>()
        let json = JSON(data: jsonArray)
        
        for (index, subJSON): (String, JSON) in json {
            citySet.insert(subJSON["citydesc"].string!)
        }

        let realm = try! Realm()
        realm.beginWrite()

        for (index, subJSON): (String, JSON) in json {
            
            
        }
    }
}

class Parameters: Object {

    dynamic var parameter: String?
    dynamic var parameterdesc: String?
    dynamic var value = 0.0
    dynamic var unit: String?
}