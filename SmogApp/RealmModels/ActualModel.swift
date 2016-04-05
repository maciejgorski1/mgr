
//
//  ActualModel.swift
//  SmogApp
//
//  Created by Myrenkar on 05.04.2016.
//  Copyright © 2016 moo. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyJSON

class ActualModel: Object {

    dynamic var stationName: String? = ""
    dynamic var stationHour: String?
    dynamic var stationMax : Double = 0.0

    let pollutionsList = List<DetailslModel>()
}
