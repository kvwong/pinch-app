//
//  EventLocationViewController.swift
//  Pinch
//
//  Created by Cameron Wu on 10/16/15.
//  Copyright © 2015 Team 2. All rights reserved.
//

import UIKit
import MapKit

class EventLocationViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var directionsButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        // 1
        let location = CLLocationCoordinate2D(
            latitude: 37.774929,
            longitude: -122.419416
        )
        // 2
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
        //3
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Code Path HQ"
        annotation.subtitle = "The Happiest Place on Earth"
        mapView.addAnnotation(annotation)
    
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPressDirectionsButton(sender: AnyObject) {
        //GoogleMaps
        if (UIApplication.sharedApplication().canOpenURL(NSURL(string:"comgooglemaps://")!)) {
            UIApplication.sharedApplication().openURL(NSURL(string:
                "comgooglemaps://?center=40.765819,-73.975866&zoom=14&views=traffic")!)
        } else {
            NSLog("Can't use Google Maps");
        }
        
        //Apple Maps
        if (UIApplication.sharedApplication().canOpenURL(NSURL(string:"http://maps.apple.com")!)) {
            UIApplication.sharedApplication().openURL(NSURL(string:
            "http://maps.apple.com/?daddr=San+Francisco,+CA&saddr=cupertino")!)
        } else {
            NSLog("Can't use Apple Maps");
        }
        
    }

}
