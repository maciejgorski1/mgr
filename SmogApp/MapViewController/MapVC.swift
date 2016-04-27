//
//  MapVC.swift
//  SmogApp
//
//  Created by Myrenkar on 28.02.2016.
//  Copyright © 2016 moo. All rights reserved.
//

import UIKit
import GoogleMaps
import RealmSwift
import SwiftyJSON

class MapVC: UIViewController, GMSMapViewDelegate {
    var locations: Array<String> = []
    let defaults = NSUserDefaults.standardUserDefaults()
    var pollutionType: String = ""
    let camera = GMSCameraPosition.cameraWithLatitude(50.010575,
        longitude: 19.949189, zoom: 7)

    @IBOutlet weak var storyBoardMapView: GMSMapView!
    @IBOutlet weak var legendView: UIView!
    @IBOutlet weak var menuButton: UIBarButtonItem!

    override func viewDidLoad() {
        pollutionType = defaults.stringForKey(PollutionChosen.Pollution)!
        setUpMapView()
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        prepareData(pollutionType) { (isFinished) -> Void in
            self.removeAllOverlays()
        }
    }

    func setUpMapView() {

        storyBoardMapView.delegate = self
        storyBoardMapView.camera = camera
        storyBoardMapView.myLocationEnabled = true

    }
    func prepareData(pollutionTypeFromNSDefaults: String, callback: (isFinished: Bool) -> Void)
    { self.showWaitOverlay()
        for index in 1 ... 23 {
            RequestManager.citiesWithHandler(index, completionHandler: { (response) -> Void in
                let json = JSON(data: (response.data! as NSData))
                let dataToParse = json["dane"]
                let cityData = dataToParse["city"]
                let actualData = dataToParse["actual"]
                let forecastData = dataToParse["forecast"]
                let messageData = dataToParse["message"]
                var color = ""
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
                                    color = detailsRow["max"].string!
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

                                color = detailsJSON["max"].string!
                                pollutionType = "\(detailsJSON["par_desc"].string!)  "
                                self.mapSetup(coordinates.long, lattitude: coordinates.lat, color: color, stationDescription: stationDesc, pollutionType: pollutionType)
                            }
                            else {

                            }

                        }

                    } else {

                    }

                }
                if index == 23 {
                    callback(isFinished: true)
                }
            })
        }
    }

    func mapSetup(longitude: Double, lattitude: Double, color: String, stationDescription: String, pollutionType: String)
    {

        let marker = GMSMarker()
        let position = CLLocationCoordinate2DMake((lattitude), (longitude))

        marker.position = position
        marker.map = storyBoardMapView
        marker.title = stationDescription
        marker.snippet = pollutionType
        marker.icon = UIImage(named: Colors.getImageNameFromID(color))

    }
    @IBAction func changeMapTypeButtonClicked(sender: AnyObject) {
        if storyBoardMapView.mapType == kGMSTypeNormal {
            storyBoardMapView.mapType = kGMSTypeSatellite
        } else if storyBoardMapView.mapType == kGMSTypeSatellite {
            storyBoardMapView.mapType = kGMSTypeHybrid
        } else if storyBoardMapView.mapType == kGMSTypeHybrid {
            storyBoardMapView.mapType = kGMSTypeTerrain
        } else if storyBoardMapView.mapType == kGMSTypeTerrain {
            storyBoardMapView.mapType = kGMSTypeNormal
        }

    }
//    func mapView(mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
//        // custom view
//
//    }
}