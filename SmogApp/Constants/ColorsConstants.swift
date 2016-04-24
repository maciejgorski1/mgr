//
//  ColorsConstants.swift
//  SmogApp
//
//  Created by Myrenkar on 24.04.2016.
//  Copyright © 2016 moo. All rights reserved.
//

import Foundation

struct Colors {
    static func getColorFromDescription(description: String) -> UIColor {
        var color = UIColor()

        if description == "Bardzo dobry" {
            color = UIColor.init(hexString: "#00B050")
        } else if description == "Dobry" {
            color = UIColor.init(hexString: "#00E400")
        } else if description == "Umiarkowany" {
            color = UIColor.init(hexString: "#FFFF00")
        } else if description == "Dostateczny" {
            color = UIColor.init(hexString: "#FFFF00")
        } else if description == "Zły" {
            color = UIColor.init(hexString: "#FF0000")
        } else if description == "Bardzo zły" {
            color = UIColor.init(hexString: "#7E0023")
        } else {
            color = UIColor.init(hexString: "#C6D6D5")
        }

        return color
    }
}