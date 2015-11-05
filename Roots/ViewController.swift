//
//  ViewController.swift
//  Roots
//
//  Created by Hunter Maximillion Monk on 11/5/15.
//  Copyright © 2015 Hunter Maximillion Monk. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        manager.startUpdatingLocation()
        manager.delegate = self
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let latitude = manager.location?.coordinate.latitude
        let longitude = manager.location?.coordinate.longitude
        
        print("this is my latitude \(latitude)")
        print("this is my longitude \(longitude)")
    }
    

}
