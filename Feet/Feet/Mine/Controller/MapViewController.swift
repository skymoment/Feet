//
//  MapViewController.swift
//  Feet
//
//  Created by 王振宇 on 7/14/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

// 地图上自定义的标注点和覆盖物  称之为 地图覆盖物

import UIKit

class MapViewController: UIViewController {
  
  weak var mapView: BMKMapView!
  
  override func viewDidLoad() {
    super.viewDidLoad()

    mapView = {
      let m = BMKMapView(frame: view.frame)
      m.zoomLevel = 19
      view.addSubview(m)
      return m
    }()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(false, animated: false)

    mapView.delegate = self
    (tabBarController as! TabBarController).removeGestrue()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    // 标注 就是带气泡的那种
    let annotation = BMKPointAnnotation()
    var coor = CLLocationCoordinate2D()
    coor.latitude = 39.915
    coor.longitude = 116.404
    annotation.coordinate = coor
    annotation.title = "长按可移动哦"
    mapView.addAnnotation(annotation)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    mapView.delegate = nil
    (tabBarController as! TabBarController).addGestrue()
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
  }
}

extension MapViewController: BMKMapViewDelegate{
  func mapView(_ mapView: BMKMapView!, viewFor annotation: BMKAnnotation!) -> BMKAnnotationView! {
    if annotation.isKind(of: BMKPointAnnotation.self) {
      let newAnnotationView = BMKPinAnnotationView(annotation: annotation, reuseIdentifier: "myAnnotation")
      newAnnotationView?.pinColor = UInt(BMKPinAnnotationColorRed)
      newAnnotationView?.animatesDrop = true
      newAnnotationView?.isDraggable = true
      newAnnotationView?.image = UIImage(named: "location")
      return newAnnotationView
    }
    return nil
  }
  
  func mapView(_ mapView: BMKMapView!, annotationView view: BMKAnnotationView!, didChangeDragState newState: UInt, fromOldState oldState: UInt) {
    print("newState=======\(newState)")
    print("newState=======\(oldState)")
  }
}
