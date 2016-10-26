//
//  AppDelegateExtension.swift
//  Feet
//
//  Created by 王振宇 on 7/14/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import Foundation

var mapManager: BMKMapManager!
// QQYPf4WySscIt22WNTGAvBbkpuVPcufe 百度地图
extension AppDelegate {
  func startBaiduKit() {
    mapManager = BMKMapManager()
    let ret = mapManager.start("QQYPf4WySscIt22WNTGAvBbkpuVPcufe", generalDelegate: nil)
    if !ret {
      print("manger start failed")
    }
  }
}