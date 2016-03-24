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

class MapVC: UIViewController {
    var locations : Array<String> = []
    // google map api AIzaSyDSD_EDnw9Ipz8D88vc8blO5vcPul_OGKI
    var pollutionType : String? = "caqi"
    @IBOutlet weak var menuButton: UIBarButtonItem!

    func prepareData()
    {
        let cities = City.getLocationNames()
        locations = Array(cities)
    }

    override func viewDidLoad() {
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        prepareData()
        let camera = GMSCameraPosition.cameraWithLatitude(50.010575,
            longitude: 19.949189, zoom: 7)
        let mapView = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
        mapView.myLocationEnabled = true
        self.view = mapView

        for location in locations {

            let realm = try! Realm()

            let point = realm.objects(PollutionModel).filter("location = '\(location)'").first
            let pollution = realm.objects(PollutionModel).filter("location = '\(location)' AND parameter = '\(pollutionType!)'").first

            let marker = GMSMarker()
            let position = CLLocationCoordinate2DMake((point?.lattitude)!, (point?.longitute)!)

            marker.position = position
            marker.title = point?.locationDesc
            marker.map = mapView

            if pollution != nil {
                let circle = GMSCircle(position: position, radius: 10000)
                circle.strokeColor = UIColor.init(hexString: (pollution?.color)!)
                circle.fillColor = UIColor.init(hexString: (pollution?.color)!)
                circle.map = mapView
            }
        }
    }
}