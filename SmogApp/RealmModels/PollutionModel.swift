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

    dynamic var parameter: String? = ""
    dynamic var parameterdesc: String?
    dynamic var value : Double = 0.0
    dynamic var unit: String?
    dynamic var timeStamp : Double = 0.0
    dynamic var color : String?
    dynamic var lattitude : Double = 0.0
    dynamic var longitute : Double = 0.0
    dynamic var city: String?
    dynamic var cityDesc: String?
    dynamic var locationDesc : String?
    dynamic var location : String?
}
