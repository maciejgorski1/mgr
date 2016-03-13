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

    dynamic var lattitude : Double = 0.0
    dynamic var longitute : Double = 0.0
    dynamic var city: String?
    dynamic var cityDesc: String?
    dynamic var parameter: String?
    dynamic var parameterdesc: String?
    dynamic var value : Double = 0.0
    dynamic var unit: String?
    dynamic var timeStamp : Double = 0.0

    dynamic var myPrimaryKey: String! = "hg@!ipf!@r?4F"

    override static func primaryKey() -> String? {
        return "myPrimaryKey"
    }

    class func sharedGlobalPollution() -> PollutionModel! {

        let realm = try! Realm()
        let pollutions = realm.objects(PollutionModel.self)

        if (pollutions.count > 0) {

            return pollutions.first
        }
        else {
            let instance = PollutionModel()

            try! realm.write {
                realm.add(instance)
            }

            return instance
        }
    }

    class func citiesSerialization(jsonArray: NSData) {
        var citySet = Set<String>()
        let json = JSON(data: jsonArray)
//        debugPrint(json)

        for (_, subJSON): (String, JSON) in json {

            debugPrint(subJSON)
            citySet.insert(subJSON["citydesc"].string!)
        }
        debugPrint(citySet)
    }

    class func pollutionSerialization(jsonArray: NSData) {

        let json = JSON(data: jsonArray)
//
//        for (_, subJSON): (String, JSON) in json {
//            citySet.insert(subJSON["citydesc"].string!)
//        }

        if (!json.isEmpty) {

            let realm = try! Realm()
            try! Realm().write { () -> Void in

                let pollution = PollutionModel.sharedGlobalPollution()

                for (_, subJSON): (String, JSON) in json {

                    if (subJSON["city"].rawString()! != "null")
                    {
                        pollution.city = subJSON["city"].string!
                    }
                    else {
                        pollution.city = ""
                    }

                    if (subJSON["citydesc"].rawString()! != "null")
                    {
                        pollution.cityDesc = subJSON["citydesc"].string!
                    }
                    else {
                        pollution.cityDesc = ""
                    }

                    if (subJSON["lat"].rawString()! != "null")
                    {

                        let value = subJSON["lat"].string!
                        pollution.lattitude = value.toDouble()!
                    }
                    else {
                        pollution.lattitude = 0.0
                    }

                    if (subJSON["long"].rawString()! != "null")
                    {

                        let value = subJSON["long"].string!
                        pollution.longitute = value.toDouble()!
                    }
                    else {
                        pollution.longitute = 0.0
                    }

                    if (subJSON["parameter"].rawString()! != "null")
                    {
                        pollution.parameter = subJSON["parameter"].string!
                    }
                    else {
                        pollution.parameter = ""
                    }

                    if (subJSON["parameterdesc"].rawString()! != "null")
                    {
                        pollution.parameterdesc = subJSON["parameterdesc"].string!
                    }
                    else {
                        pollution.parameterdesc = ""
                    }

                    if (subJSON["value"].rawString()! != "null")
                    {

                        let value = subJSON["value"].string!
                        pollution.value = value.toDouble()!
                    }
                    else {
                        pollution.value = 0.0
                    }
                    if (subJSON["unit"].rawString()! != "null")
                    {
                        pollution.unit = subJSON["unit"].string!
                    }
                    else {
                        pollution.unit = ""
                    }
                    debugPrint(subJSON)
                    realm.add(pollution, update: true)
                }
            }
        }
    }
}

class Parameters: Object {

    dynamic var parameter: String?
    dynamic var parameterdesc: String?
    dynamic var value = 0.0
    dynamic var unit: String?
}