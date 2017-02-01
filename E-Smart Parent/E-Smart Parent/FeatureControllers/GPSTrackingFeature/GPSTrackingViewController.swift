//
//  GPSTrackingViewController.swift
//  SchoolApp
//
//  Created by Pradeep A C on 21/10/16.
//  Copyright © 2016 Pradeep A C. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class GPSTrackingViewController: ViewController,CLLocationManagerDelegate {
    @IBOutlet weak var mapKitView: MKMapView!
    
    
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    private func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        let location = locations.last as! CLLocation
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.mapKitView.setRegion(region, animated: true)
    }
}
