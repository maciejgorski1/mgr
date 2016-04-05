//
//  StationsCoordinates.swift
//  SmogApp
//
//  Created by Myrenkar on 05.04.2016.
//  Copyright © 2016 moo. All rights reserved.
//

import Foundation

struct StationsCoordinates {
    static func getCoordinatesForStationId(stationId: Int) -> (lat: Double, long: Double) {
        var lattitude : Double = 0.0
        var longitude : Double = 0.0

        switch stationId {
        case 1:
            longitude = 19.926189
            lattitude = 50.057678
        case 2:
            longitude = 20.053492
            lattitude = 50.057678
        case 3:
            longitude = 19.949189
            lattitude = 50.010575
        case 4:
            longitude = 21.004167
            lattitude = 50.020169
        case 5:
            longitude = 20.714403
            lattitude = 49.619281
        case 6:
            longitude = 19.569869
            lattitude = 50.277569
        case 7:
            longitude = 20.053492
            lattitude = 50.057678
        case 8:
            longitude = 20.053492
            lattitude = 50.057678
        case 9:
            longitude = 20.053492
            lattitude = 50.057678
        case 10:
            longitude = 20.053492
            lattitude = 50.057678
        case 11:
            longitude = 20.053492
            lattitude = 50.057678
        case 12:
            longitude = 19.960083
            lattitude = 49.293564
        case 13:
            longitude = 19.946008
            lattitude = 50.057447
        case 14:
            longitude = 20.018317
            lattitude = 50.099361
        case 15:
            longitude = 19.895358
            lattitude = 50.081197
        case 16:
            longitude = 20.992580
            lattitude = 50.018263
        case 17:
            longitude = 20.053492
            lattitude = 50.057678
        case 18:
            longitude = 20.053492
            lattitude = 50.057678
        case 19:
            longitude = 20.053492
            lattitude = 50.057678
        case 20:
            longitude = 20.053492
            lattitude = 50.057678
        case 21:
            longitude = 20.053492
            lattitude = 50.057678
        case 22:
            longitude = 20.053492
            lattitude = 50.057678
        case 23:
            longitude = 20.053492
            lattitude = 50.057678
        case 24:
            longitude = 20.053492
            lattitude = 50.057678

        default:
            longitude = 20.053492
            lattitude = 50.057678
        }

        return (lattitude, longitude)
    }
}