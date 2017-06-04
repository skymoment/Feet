//
//  DayViewController.swift
//  Feet
//
//  Created by zhenyu on 17/1/11.
//  Copyright © 2017年 王振宇. All rights reserved.
//

import UIKit

class DayViewController: UIViewController {
  
  var day: UILabel!
  var content: UILabel!
  var name: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setViews()
    // Do any additional setup after loading the view.
    owFeet({ (ownModel) in
      self.loadData(ownModel)
//        GCDTool.delay(3, task: {
          kWindow?.rootViewController = ControllerTool.chooseRootViewController()
//        })
      }) {
        kWindow?.rootViewController = ControllerTool.chooseRootViewController()
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - SetViews
  func setViews() {
    var imageName = ""
    let viewSize = view.bounds.size
    imageName = getLaunchImage(viewSize)!
    
    let imageView = UIImageView(image: UIImage(named: imageName))
    imageView.frame = view!.bounds
    view.addSubview(imageView)
    
    let day = UILabel()
    day.text = ""
    day.textColor = UIColor.white
    day.font = UIFont(name: FangZheng, size: 17)
    imageView.addSubview(day)
    self.day = day
    
    let content = UILabel()
    content.textColor = UIColor.white
    content.numberOfLines = 0
    content.font = UIFont(name: FangZheng, size: 20)
    content.text = ""
    imageView.addSubview(content)
    self.content = content
    
    let name = UILabel()
    name.text = ""
    name.textColor = UIColor.white
    name.font = UIFont(name: FangZheng, size: 20)
    name.textAlignment = .right
    imageView.addSubview(name)
    self.name = name
    
    var top = 0
    if iPhone5 {
      top = 190
    } else if iPhone4 {
      top = 130
    } else if iPhonePlus {
      top = 260
    } else if iPad {
      top = 400
    } else {
      top = 220
    }
    
    day.snp.makeConstraints { (make) in
      make.top.equalTo(top)
      make.centerX.equalTo(imageView)
    }
    
    var width = 0
    if smallScreen {
      width = 40
    } else {
      width = 60
    }
    
    content.snp.makeConstraints { (make) in
      make.top.equalTo(day.snp.bottom).offset(10)
      make.centerX.equalTo(day)
      make.left.equalTo(width)
      make.right.equalTo(view.snp.right).offset(-width)
    }
    
    name.snp.makeConstraints { (make) in
      make.top.equalTo(content.snp.bottom).offset(10)
      make.right.equalTo(content.snp.right)
    }
  }
  
  
  // MARK: - Method
  func loadData(_ model: OWModel) {
    day.text =  "第 \(model.day) 天" // "第1天"
      //model.day
    content.text =  model.content //"生活不应只有眼前的苟且，还有诗和远方。请跟随你的脚步，直到远方！"
      //model.content
    name.text = "- \(model.name)" //"- by Feet"
      //model.name
  }
  
  func getLaunchImage(_ viewSize: CGSize) -> String? {
    let imageDic = (Bundle.main.infoDictionary! as NSDictionary).value(forKey: "UILaunchImages") as! NSArray
    guard !iPad else {
      return "2048x2732"
    }
    for dic in imageDic {
      let dict = dic as! NSDictionary
      let size = CGSizeFromString(dict["UILaunchImageSize"] as! String) as CGSize
      if size.equalTo(viewSize) && "Portrait" == dict["UILaunchImageOrientation"] as! String {
        return dict["UILaunchImageName"] as? String
      }
    }
    return ""
  }
  
  
  func owFeet(_ compeletion: ((OWModel) -> ())? = nil, fail: (() -> ())? = nil) {
    HomeNetworkTool.owFeet { promiseMode in
      do {
        let _ = try promiseMode.then({ model in
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
}
