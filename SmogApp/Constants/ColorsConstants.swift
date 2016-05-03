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
            color = UIColor.init(hexString: "#FF7E00")
        } else if description == "Zły" {
            color = UIColor.init(hexString: "#FF0000")
        } else if description == "Bardzo zły" {
            color = UIColor.init(hexString: "#7E0023")
        } else {
            color = UIColor.init(hexString: "#C6D6D5")
        }

        return color
    }

    static func getColorFromID(id: String) -> UIColor {
        var color = UIColor()

        if id == "1" {
            color = UIColor.init(hexString: "#00B050")
        } else if id == "2" {
            color = UIColor.init(hexString: "#00E400")
        } else if id == "3" {
            color = UIColor.init(hexString: "#FFFF00")
        } else if id == "4" {
            color = UIColor.init(hexString: "#FF7E00")
        } else if id == "5" {
            color = UIColor.init(hexString: "#FF0000")
        } else if id == "6" {
            color = UIColor.init(hexString: "#7E0023")
        } else {
            color = UIColor.init(hexString: "#C6D6D5")
        }

        return color
    }
   static func getDescriptionFromID(id: String) -> String {
        var type = ""

        if id == "1" {
            type = "Bardzo dobry"
        } else if id == "2" {
            type = "Dobry"
        } else if id == "3" {
            type = "Umiarkowany"
        } else if id == "4" {
            type = "Dostateczny"
        } else if id == "5" {
            type = "Zły"
        } else if id == "6" {
            type = "Bardzo dobry"
        } else {
            type = ""
        }
        return type
    }
    static func getImageNameFromID(id: String) -> String {
        var imageName = ""

        if id == "1" {
            imageName = "icon_green"
        } else if id == "2" {
            imageName = "icon_greener"
        } else if id == "3" {
            imageName = "icon_yellow"
        } else if id == "4" {
            imageName = "icon_dst"
        } else if id == "5" {
            imageName = "icon_red"
        } else if id == "6" {
            imageName = "icon_veryBad" }
        else {
            imageName = "icon_noData"
        }

        return imageName
    }

}