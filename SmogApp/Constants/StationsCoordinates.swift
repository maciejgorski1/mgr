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
        var lattitude: Double = 0.0
        var longitude: Double = 0.0

        switch stationId {
        case 1:
            longitude = 19.926189 // krakow
            lattitude = 50.057678
        case 2:
            longitude = 20.053492 // krakow
            lattitude = 50.057678
        case 3:
            longitude = 19.949189 // krakow
            lattitude = 50.010575
        case 4:
            longitude = 21.004167 // tarnow
            lattitude = 50.020169
        case 5:
            longitude = 20.714403 // nowysacz
            lattitude = 49.619281
        case 6:
            longitude = 19.569869 // olkusz
            lattitude = 50.277569
        case 7:
            longitude = 19.830422 // skawina
            lattitude = 49.971047
        case 8:
            longitude = 20.053492 // suchabeskidzka
            lattitude = 50.057678
        case 11:
            longitude = 19.477464 // trzebina
            lattitude = 50.159406
        case 12:
            longitude = 19.960083 // zakopane
            lattitude = 49.293564
        case 13:
            longitude = 19.946008 // krakow
            lattitude = 50.057447
        case 14:
            longitude = 20.018317 // krakow
            lattitude = 50.099361
        case 15:
            longitude = 19.895358 // krakow
            lattitude = 50.081197
        case 16:
            longitude = 20.992580 // tarnow
            lattitude = 50.018263
        case 54:
            longitude = 20.053492 // bochnia
            lattitude = 50.057678
        case 55:
            longitude = 20.053492 // brzesko
            lattitude = 50.057678
        case 56:
            longitude = 20.053492 // chrzanów
            lattitude = 50.057678
        case 57:
            longitude = 20.053492 // dabrowatarnowska
            lattitude = 50.057678
        case 58:
            longitude = 20.053492 // gorlice
            lattitude = 50.057678
        case 59:
            longitude = 20.053492 // krynicazdroj
            lattitude = 50.057678
        case 510:
            longitude = 20.053492 // limanowa
            lattitude = 50.057678
        case 511:
            longitude = 20.053492 // miechow
            lattitude = 50.057678
        case 512:
            longitude = 20.053492 // myslenice
            lattitude = 50.057678
        case 513:
            longitude = 20.053492 // nowytarg
            lattitude = 50.057678
        case 515:
            longitude = 20.053492 // oswiecim
            lattitude = 50.057678
        case 516:
            longitude = 20.053492 // proszowice
            lattitude = 50.057678
        case 520:
            longitude = 20.053492 // tuchow
            lattitude = 50.057678
        case 521:
            longitude = 20.053492 // wadowice
            lattitude = 50.057678
        case 522:
            longitude = 20.053492 // wieliczka
            lattitude = 50.057678
        case 519:
            longitude = 20.053492 // trzebinia
            lattitude = 50.057678
        case 524:
            longitude = 20.053492 // gminaklaj
            lattitude = 50.057678
        default:
            longitude = 20.053492
            lattitude = 50.057678
        }
//        "3   nowysacz"
//        "2   tarnow"
//        "4   bochnia"
//        "5   brzesko"
//        "1   krakow"
//        "6   chrzanow"
//        "7   dabrowatarnowska"
//        "8   gorlice"
//        "9   krynicazdroj"
//        "10   limanowa"
//        "11   miechow"
//        "12   myslenice"
//        "13   nowytarg"
//        "14   olkusz"
//        "15   oswiecim"
//        "16   proszowice"
//        "17   skawina"
//        "18   suchabeskidzka"
//        "20   tuchow"
//        "21   wadowice"
//        "22   wieliczka"
//        "19   trzebina"
//        "24   gminaklaj"
//        "23   zakopane"

        return (lattitude, longitude)
    }
}