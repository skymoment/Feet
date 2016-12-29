//
//  FeatureViewController.swift
//  Feet
//
//  Created by zhenyu on 16/12/27.
//  Copyright © 2016年 王振宇. All rights reserved.
//

import UIKit

class FeatureViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    let scrollView = UIScrollView()
    scrollView.showsHorizontalScrollIndicator = false
    scrollView.bounces = false
    scrollView.pagingEnabled = true
    scrollView.frame = view.bounds
    view.addSubview(scrollView)
    
    let imagePrefix = iPhone4 ? "small_" : "big_"
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction))
    for i in 1...3 {
      let imageName = "\(imagePrefix)\(i)"
      let imgView = UIImageView(image: UIImage(named: imageName))
      let x = view.bounds.width * CGFloat(i-1)
      imgView.frame = CGRect(x: x, y: 0, width: view.bounds.width, height: view.bounds.height)
      scrollView.addSubview(imgView)
      
      if i == 3 {
        imgView.userInteractionEnabled = true
        imgView.addGestureRecognizer(tapGesture)
      }
    }
    scrollView.contentSize = CGSize(width: view.bounds.width * 3, height: 0)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func tapAction() {
    debugPrint("最后一张")
    UIApplication.sharedApplication().keyWindow?.rootViewController = TabBarController()
  }
}
