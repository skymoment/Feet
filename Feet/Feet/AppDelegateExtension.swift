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


/// 每日一句
extension AppDelegate {
  func owFeet(compeletion: ((OWModel) -> ())? = nil, fail: (() -> ())? = nil) {
    HomeNetworkTool.owFeet { promiseMode in
      do {
        let _ = try promiseMode.then({ model in
          debugPrint(model.name)
          model.name = "by Feet"
          model.day = "1"
          model.content = "从今天开始，同学们的脚步由我来守护！！！"
          compeletion?(model)
        }).resolve()
      } catch where error is MyError{
        fail?()
        debugPrint("\(error)")
      } catch{
        fail?()
        debugPrint("\(error)")
      }
    }
  }
  
  func ownImageView() {
    var imageName = ""
    let viewSize = kWindow!.bounds.size
    let imageDic = NSBundle.mainBundle().infoDictionary!["UILaunchImages"] as! NSArray

    for dic in imageDic {
      let imageSize = CGSizeFromString(dic.valueForKey("UILaunchImages") as! String)
      if CGSizeEqualToSize(imageSize, viewSize) &&
        "Portrait" == dic["UILaunchImageOrientation"] as! String {
        imageName = dic["UILaunchImageName"] as! String
      }
    }
    
    let imageView = UIImageView(image: UIImage(named: imageName))
    imageView.frame = kWindow!.bounds
    kWindow!.addSubview(imageView)
    
    let day = UILabel()
    day.text = "第101天"
    imageView.addSubview(day)
    day.snp_makeConstraints { (make) in
      make.top.equalTo(230)
      make.centerX.equalTo(imageView)
    }
  }
}



