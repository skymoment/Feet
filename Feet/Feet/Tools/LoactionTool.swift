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
  func locationWithState(_ location: CLLocation, state: String)
  func locationFail()
}

class LoactionTool: NSObject {
  static let shareInstance = LoactionTool()
  let locationManager = CLLocationManager()
  weak var delegate: LocationToolDelegate?
  
  fileprivate override init() {
    
  }
  
  func isEnableLocation() -> Bool {
    if CLLocationManager.locationServicesEnabled() {
      locationManager.distanceFilter = kCLLocationAccuracyBest
      locationManager.delegate = self
      locationManager.requestWhenInUseAuthorization()
      locationManager.startUpdatingLocation()
      return true
    }
    delegate?.locationFail()
    return false
  }
}


extension LoactionTool: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let location = locations.last
    
    let coor = location?.coordinate
    debugPrint("latitude === \(coor?.latitude)")
    debugPrint("longitude === \(coor?.longitude)")
    
    locationManager.stopUpdatingLocation()
    CLGeocoderAction(location!)
  }
  
  func CLGeocoderAction(_ location: CLLocation) {
    let geocoder = CLGeocoder()
    geocoder.reverseGeocodeLocation(location) { (marks, error) in
      
      if let marks = marks {
        for mark in marks {
          let dic = mark.addressDictionary
          let state = dic!["State"]
          debugPrint("lcoaiton ==== \(state) ")
          
          self.delegate?.locationWithState(location, state: "\(state!)")
        }
      } else {
        self.delegate?.locationFail()
      }
    }
  }
}
