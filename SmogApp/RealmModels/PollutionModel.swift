//
//  PollutionModel.swift
//  SmogApp
//
//  Created by Myrenkar on 29.02.2016.
//  Copyright © 2016 moo. All rights reserved.
//

import UIKit
import RealmSwift

class PollutionModel: Object {

	dynamic var lattitude = 0.0
	dynamic var longitute = 0.0
	dynamic var city: String?
	dynamic var cityDesc: String?
	dynamic var parameter: String?
	dynamic var parameterdesc: String?
	dynamic var value = 0.0
	dynamic var unit: String?
    
}
