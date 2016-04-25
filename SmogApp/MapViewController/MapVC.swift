//
//  MapVC.swift
//  SmogApp
//
//  Created by Myrenkar on 28.02.2016.
//  Copyright © 2016 moo. All rights reserved.
//

import UIKit
import GoogleMaps
import Realm
import SwiftyJSON

class MapVC: UIViewController, GMSMapViewDelegate {
    var locations: Array<String> = []
    // google map api AIzaSyDSD_EDnw9Ipz8D88vc8blO5vcPul_OGKI
    var pollutionType: String? = "aqi"

    @IBOutlet weak var storyBoardMapView: GMSMapView!
    @IBOutlet weak var legendView: UIView!

    @IBOutlet weak var menuButton: UIBarButtonItem!
    let camera = GMSCameraPosition.cameraWithLatitude(50.010575,
        longitude: 19.949189, zoom: 7)

    override func viewDidLoad() {
        setUpMapView()
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        prepareData { (isFinished) -> Void in
        }
    }

    func setUpMapView() {
        
        storyBoardMapView.delegate = self
        storyBoardMapView.camera = camera
        storyBoardMapView.myLocationEnabled = true

    }
    func prepareData(callback: (isFinished: Bool) -> Void)
    {
        for index in 1 ... 23 {
            RequestManager.citiesWithHandler(index, completionHandler: { (response) -> Void in
                let json = JSON(data: (response.data! as NSData))
                let dataToParse = json["dane"]
                let cityData = dataToParse["city"]
                let actualData = dataToParse["actual"]
                let forecastData = dataToParse["forecast"]
                let messageData = dataToParse["message"]
                var color: UIColor
                var stationDesc = ""
                var pollutionType = ""
                if !actualData.isEmpty {
                    // debugPrint("\(index)   \(cityData["ci_name"])")
                    for (_, actualJSON): (String, JSON) in actualData {

                        // debugPrint()
                        let station_id = Int(actualJSON["station_id"].string!)
                        stationDesc = actualJSON["station_name"].string!
                        // debugPrint("\(index)  \(station_id!) \(cityData["ci_name"])")

                        let coordinates = StationsCoordinates.getCoordinatesForStationId(station_id!)
                        if actualJSON["details"][0] != nil {
                            color = Colors.getColorFromDescription(actualJSON["details"][0]["g_nazwa"].string!)
                            pollutionType = actualJSON["details"][0]["par_desc"].string!
                        } else {
                            color = Colors.getColorFromDescription("empty")
                        }

                        self.mapSetup(coordinates.long, lattitude: coordinates.lat, color: color, stationDescription: stationDesc, pollutionType: pollutionType) // debugPrint(actualJSON)
                    }
                } else {

                    for (_, forecastJSON): (String, JSON) in forecastData {
                        let station_id = Int("5\(cityData["ci_id"].string!)")
                        stationDesc = cityData["ci_citydesc"].string!

                        let coordinates = StationsCoordinates.getCoordinatesForStationId(station_id!)
                        if forecastJSON["dzisiaj"] != nil {
                            let todayJSON = forecastJSON["dzisiaj"]
                            color = Colors.getColorFromID(todayJSON["max"].string!)
                            pollutionType = todayJSON["details"][0]["par_desc"].string!
                        } else {
                            color = Colors.getColorFromDescription("empty")
                        }

                        self.mapSetup(coordinates.long, lattitude: coordinates.lat, color: color, stationDescription: stationDesc, pollutionType: pollutionType) // debugPrint(actualJSON)
                    }
                }
            })
        }
    }

    func mapSetup(longitude: Double, lattitude: Double, color: UIColor, stationDescription: String, pollutionType: String)
    {
        // debugPrint("\(longitude)  \(lattitude)   \(color.description)   ")

        let marker = GMSMarker()
        let position = CLLocationCoordinate2DMake((lattitude), (longitude))

        marker.position = position
//            marker.title = point?.locationDesc
        marker.map = storyBoardMapView
        marker.title = stationDescription
        marker.snippet = pollutionType
        marker.icon = GMSMarker.markerImageWithColor(color)
        let circle = GMSCircle(position: position, radius: 10000)

        circle.strokeColor = color
        circle.fillColor = color
        circle.map = storyBoardMapView
    }
}