//
//  MapVC.swift
//  SmogApp
//
//  Created by Myrenkar on 28.02.2016.
//  Copyright © 2016 moo. All rights reserved.
//

import UIKit
import GoogleMaps
import SwiftyJSON
import SCLAlertView

class MapVC: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {
    @IBOutlet weak var storyBoardMapView: GMSMapView!
    @IBOutlet weak var legendView: UIView!
    @IBOutlet weak var menuButton: UIBarButtonItem!

    var locations: Array<String> = []
    let defaults = NSUserDefaults.standardUserDefaults()
    var pollutionType: String = ""
    let camera = GMSCameraPosition.cameraWithLatitude(50.010575,
        longitude: 19.949189, zoom: 7)
    var locationManager = CLLocationManager()
    var didFindMyLocation = false
    var mapView = GMSMapView()


    override func viewDidAppear(animated: Bool) {
        let button = UIButton(frame: CGRect(x: 0.8 * self.view.frame.size.width, y: 0.9 * self.view.frame.size.height, width: 32.0, height: 32.0))
        button.setImage(UIImage(named: "camera"), forState: .Normal)
        button.addTarget(self, action: #selector(MapVC.btnTouched(_:)), forControlEvents: .TouchUpInside)
        self.view.addSubview(button)
    }
    override func viewDidLoad() {
        pollutionType = defaults.stringForKey(PollutionChosen.Pollution)!
        setUpMapView()
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()

        if Reachability.isConnectedToNetwork() == true {
            prepareData(pollutionType) { (isFinished) -> Void in
                self.removeAllOverlays()
            }

        } else {

            SCLAlertView().showError("Brak internetu ", subTitle: "Upewnij się, że masz połączenie z internetem")

        }
    }

    func setUpMapView() {
        mapView = .mapWithFrame(CGRectZero, camera: camera)
        mapView.myLocationEnabled = true
        self.view = mapView
        mapView.delegate = self

    }
    func prepareData(pollutionTypeFromNSDefaults: String, callback: (isFinished: Bool) -> Void)
    { self.showWaitOverlay()
        for index in 1 ... 23 {
            RequestManager.citiesWithHandler(index, completionHandler: { (response) -> Void in
                if response.result.isSuccess {

                    let json = JSON(data: (response.data! as NSData))
                    let dataToParse = json["dane"]
                    let cityData = dataToParse["city"]
                    let actualData = dataToParse["actual"]
                    let forecastData = dataToParse["forecast"]
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
                                        pollutionType = detailsRow["par_desc"].string!.capitalizedString
                                        let pollutionValue = "\(detailsRow["o_value"].double!) \(detailsRow["par_unit"].string!) "
                                        let acquisitionTime = detailsRow["o_czas"].string!
                                        let stateName = detailsRow["g_nazwa"].string!
                                        self.mapSetup(coordinates.long, lattitude: coordinates.lat, color: color, stationDescription: stationDesc, pollutionType: pollutionType, percentfOfLimit: pollutionValue, timeOfAcqusition: acquisitionTime, pollutionLevel: stateName)
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
                                    pollutionType = detailsJSON["par_desc"].string!.capitalizedString
                                    let pollutionValue = "\(detailsJSON["fca_avg_value"].double!) \(detailsJSON["par_unit"].string!) "
                                    let acquisitionTime = detailsJSON["fo_date"].string!
                                    let stateName = Colors.getDescriptionFromID(color)
                                    self.mapSetup(coordinates.long, lattitude: coordinates.lat, color: color, stationDescription: stationDesc, pollutionType: pollutionType, percentfOfLimit: pollutionValue, timeOfAcqusition: acquisitionTime, pollutionLevel: stateName)
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

                } else {
                
                
                }

            })
        }
    }

    func mapSetup(longitude: Double, lattitude: Double, color: String, stationDescription: String, pollutionType: String, percentfOfLimit: String, timeOfAcqusition: String, pollutionLevel: String)
    {
        let dataArray: [String] = [stationDescription, pollutionType, percentfOfLimit, timeOfAcqusition, pollutionLevel]

        let marker = GMSMarker()
        let position = CLLocationCoordinate2DMake((lattitude), (longitude))

        marker.position = position
        marker.map = mapView
        // marker.snippet = pollutionType
        marker.icon = UIImage(named: Colors.getImageNameFromID(color))
        marker.userData = dataArray

    }
    @IBAction func changeMapTypeButtonClicked(sender: AnyObject) {
        if mapView.mapType == kGMSTypeNormal {
            mapView.mapType = kGMSTypeSatellite
        } else if mapView.mapType == kGMSTypeSatellite {
            mapView.mapType = kGMSTypeHybrid
        } else if mapView.mapType == kGMSTypeHybrid {
            mapView.mapType = kGMSTypeTerrain
        } else if mapView.mapType == kGMSTypeTerrain {
            mapView.mapType = kGMSTypeNormal
        }

    }

    func btnTouched(sender: AnyObject) {
        let date = NSDate().toLocalTime()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFormatter.stringFromDate(date.toLocalTime())
        let fileName = "\(pollutionType)_\(dateString)"

        UIGraphicsBeginImageContextWithOptions(self.mapView.frame.size, false, 0);
        self.mapView.drawViewHierarchyInRect(self.mapView.bounds, afterScreenUpdates: true)

        let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!

        if let image = UIGraphicsGetImageFromCurrentImageContext() {

            let fileURL = documentsURL.URLByAppendingPathComponent(fileName + ".png")
            if let pngImageData = UIImagePNGRepresentation(image) {
                pngImageData.writeToURL(fileURL, atomically: false)
            }
            UIGraphicsEndImageContext()
        }
    }

    func mapView(mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        let markerInfoView = NSBundle.mainBundle().loadNibNamed("AnnotationXib", owner: self, options: nil).first as! AnnotationVC

        if let markerData = marker.userData as? [String] {
            markerInfoView.adresLabel.text = markerData[0]
            markerInfoView.pollutionLabel.text = markerData[1]
            markerInfoView.levelLabel.text = markerData[2]
            markerInfoView.hourLabel.text = markerData[3]
            markerInfoView.stateLabel.text = markerData[4]

        } else {
            markerInfoView.adresLabel.text = " "
            markerInfoView.hourLabel.text = " "
            markerInfoView.levelLabel.text = " "
            markerInfoView.hourLabel.text = ""
            markerInfoView.stateLabel.text = ""

        }

        return markerInfoView
    }

}