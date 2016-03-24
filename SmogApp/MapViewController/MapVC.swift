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
        let camera = GMSCameraPosition.cameraWithLatitude(-33.86,
            longitude: 151.20, zoom: 6)
        let mapView = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
        mapView.myLocationEnabled = true
        self.view = mapView
        for location in locations {

            let realm = try! Realm()

            let point = realm.objects(PollutionModel).filter("location = '\(location)'").first

            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2DMake((point?.lattitude)!, (point?.longitute)!)
            marker.title = point?.locationDesc
//            marker.snippet = "Australia"
            marker.map = mapView
//            debugPrint(point)
        }

//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2DMake(-33.86, 151.20)
//        marker.title = "Sydney"
//        marker.snippet = "Australia"
//        marker.map = mapView
    }
}
