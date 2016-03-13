//
//  StringExtension.swift
//  SmogApp
//
//  Created by Myrenkar on 13.03.2016.
//  Copyright © 2016 moo. All rights reserved.
//

import UIKit

extension String {
    func toDouble() -> Double? {
        return NSNumberFormatter().numberFromString(self)?.doubleValue
    }
}
