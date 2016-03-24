//
//  CityModel.swift
//  SmogApp
//
//  Created by Myrenkar on 23.03.2016.
//  Copyright © 2016 moo. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class City: Object {
    dynamic var id: String! = "kluczDoUpdate"

    let pollutions = List<PollutionModel>()

    override static func primaryKey() -> String? {
        return "id"
    }

    class func getLocationNames() -> Set<String> {
        var citySet = Set<String>()

        let realm = try! Realm()

        var results = realm.objects(PollutionModel)

        for item in results {

            citySet.insert(item.location!)
        }

        return citySet
    }

    class func citiesSerialization(jsonArray: NSData) {
        var citySet = Set<String>()
        let json = JSON(data: jsonArray)
        // debugPrint(json)

        for (_, subJSON): (String, JSON) in json {

            debugPrint(subJSON)
            citySet.insert(subJSON["citydesc"].string!)
        }
        debugPrint(citySet)
    }

    class func serializationPollutionModel(jsonArray: NSData) {

        let realm = try! Realm()

        try! realm.write { () -> Void in

            let citysModel = realm.objects(City).first

            if citysModel == nil {
                let json = JSON(data: jsonArray)
                let cityModel = City()

                for (_, subJSON): (String, JSON) in json {

                    let pollution = PollutionModel()

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

                    if (subJSON["locationdesc"].rawString()! != "null")
                    {
                        pollution.locationDesc = subJSON["locationdesc"].string!
                    }
                    else {
                        pollution.locationDesc = ""
                    }

                    if (subJSON["location"].rawString()! != "null")
                    {
                        pollution.location = subJSON["location"].string!
                    }
                    else {
                        pollution.location = ""
                    }
                    if (subJSON["timestamp"].rawString()! != "null")
                    {
                        let value = subJSON["timestamp"].string!
                        pollution.timeStamp = value.toDouble()!
                    }
                    else {
                        pollution.timeStamp = 0.0
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

                    if (subJSON["aqicolor"].rawString()! != "null")
                    {
                        pollution.color = subJSON["aqicolor"].string!
                    }
                    else {
                        pollution.color = ""
                    }

                    cityModel.pollutions.append(pollution)
                }
                realm.add(cityModel, update: true)
            }

            else {

                let json = JSON(data: jsonArray)
                let cityModel = City()

                for (_, subJSON): (String, JSON) in json {

                    let pollution = PollutionModel()

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
                    if (subJSON["aqicolor"].rawString()! != "null")
                    {
                        pollution.color = subJSON["aqicolor"].string!
                    }
                    else {
                        pollution.color = ""
                    }

                    if let index = cityModel.pollutions.indexOf(pollution) {
                        cityModel.pollutions.replace(index, object: pollution)
                    }
                }
                realm.add(cityModel, update: true)
            }
        }
    }
}