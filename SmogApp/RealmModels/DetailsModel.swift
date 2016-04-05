//
//  DetailsModel.swift
//  SmogApp
//
//  Created by Myrenkar on 05.04.2016.
//  Copyright © 2016 moo. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyJSON

class DetailslModel: Object {
    
    dynamic var o_wskaznik: String? = ""
    dynamic var stationHour: String?
    dynamic var o_czas: String? = ""
    dynamic var caqi_value: String? = ""
    dynamic var caqi_id: String? = ""
    dynamic var aqi_value: String? = ""
    dynamic var aqi_id: String? = ""
    dynamic var g_min_val: String? = ""
    dynamic var g_max_val: String? = ""
    dynamic var par_desc: String? = ""
    dynamic var g_nazwa: String? = ""
    dynamic var o_value : Double = 0.0
    
    
}