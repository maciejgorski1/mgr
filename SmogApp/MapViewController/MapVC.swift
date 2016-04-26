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
    let defaults = NSUserDefaults.standardUserDefaults()
    var pollutionType: String = ""
    @IBOutlet weak var storyBoardMapView: GMSMapView!
    @IBOutlet weak var legendView: UIView!

    @IBOutlet weak var menuButton: UIBarButtonItem!
    let camera = GMSCameraPosition.cameraWithLatitude(50.010575,
        longitude: 19.949189, zoom: 7)

    override func viewDidLoad() {
        pollutionType = defaults.stringForKey(PollutionChosen.Pollution)!
        setUpMapView()
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        prepareData(pollutionType) { (isFinished) -> Void in

        }
    }

    func setUpMapView() {

        storyBoardMapView.delegate = self
        storyBoardMapView.camera = camera
        storyBoardMapView.myLocationEnabled = true

    }
    func prepareData(pollutionTypeFromNSDefaults: String, callback: (isFinished: Bool) -> Void)
    {
        for index in 1 ... 23 {
            RequestManager.citiesWithHandler(index, completionHandler: { (response) -> Void in
                let json = JSON(data: (response.data! as NSData))
                let dataToParse = json["dane"]
                let cityData = dataToParse["city"]
                let actualData = dataToParse["actual"]
                let forecastData = dataToParse["forecast"]
                let messageData = dataToParse["message"]
                var color = UIColor.whiteColor().colorWithAlphaComponent(0.8)
                var stationDesc = ""
                var pollutionType = ""
                if !actualData.isEmpty {
                    for (_, actualJSON): (String, JSON) in actualData {

                        let station_id = Int(actualJSON["station_id"].string!)
                        stationDesc = actualJSON["station_name"].string!
                        let coordinates = StationsCoordinates.getCoordinatesForStationId(station_id!)

                        if !actualJSON["details"].isEmpty {
                            let detailsJSON = actualJSON["details"]
                            for (_, detailsRow): (String, JSON) in detailsJSON {
                                if detailsRow["o_wskaznik"].string! == pollutionTypeFromNSDefaults {
                                    color = Colors.getColorFromID(detailsRow["max"].string!)
                                    pollutionType = detailsRow["par_desc"].string!
                                    self.mapSetup(coordinates.long, lattitude: coordinates.lat, color: color, stationDescription: stationDesc, pollutionType: pollutionType)
                                }
                                else {

                                }
                            }
                        }

                        else {
                        }

                    }
                } else {

                    let station_id = Int("5\(cityData["ci_id"].string!)")
                    stationDesc = cityData["ci_citydesc"].string!

                    let coordinates = StationsCoordinates.getCoordinatesForStationId(station_id!)
                    if !forecastData["dzisiaj"].isEmpty {
                        let todayJSON = forecastData["dzisiaj"]["details"]
                        for (_, detailsJSON): (String, JSON) in todayJSON {
                            if detailsJSON["fo_wskaznik"].string! == pollutionTypeFromNSDefaults {

                                color = Colors.getColorFromID(detailsJSON["max"].string!)
                                pollutionType = "\(detailsJSON["par_desc"].string!)  "
                                self.mapSetup(coordinates.long, lattitude: coordinates.lat, color: color, stationDescription: stationDesc, pollutionType: pollutionType)
                            }
                            else {

                            }

                        }

                    } else {

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