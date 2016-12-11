//
//  LoactionTool.swift
//  Feet
//
//  Created by 王振宇 on 7/19/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import Foundation
import CoreLocation

@objc
protocol LocationToolDelegate:class {
  func locationWithState(location: CLLocation, state: String)
}

class LoactionTool: NSObject {
  static let shareInstance = LoactionTool()
  let locationManager = CLLocationManager()
  weak var delegate: LocationToolDelegate?
  
  private override init() {
    
  }
  
  func isEnableLocation() -> Bool {
    if CLLocationManager.locationServicesEnabled() {
      locationManager.distanceFilter = kCLLocationAccuracyBest
      locationManager.delegate = self
      locationManager.requestWhenInUseAuthorization()
      locationManager.startUpdatingLocation()
      return true
    }
    return false
  }
}


extension LoactionTool: CLLocationManagerDelegate {
  func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let location = locations.last
    
    let coor = location?.coordinate
    debugPrint("latitude === \(coor?.latitude)")
    debugPrint("longitude === \(coor?.longitude)")
    
    locationManager.stopUpdatingLocation()
    CLGeocoderAction(location!)
  }
  
  func CLGeocoderAction(location: CLLocation) {
    let geocoder = CLGeocoder()
    geocoder.reverseGeocodeLocation(location) { (marks, error) in
      for mark in marks! {
        let dic = mark.addressDictionary
        let state = dic!["State"]
        debugPrint("lcoaiton ==== \(state) ")
        
        if let d = self.delegate {
          d.locationWithState(location, state: "\(state!)")
        }
      }
    }
  }
}
