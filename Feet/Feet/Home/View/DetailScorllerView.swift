//
//  DetailScorllerView.swift
//  Feet
//
//  Created by 王振宇 on 7/31/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import UIKit

class DetailScorllerView: UIView {
  var images: [String] = ["image1"]
  var imageViews: [UIImageView] = []
  
  convenience init(images: [String]) {
    self.init(frame: CGRect(x: 0, y: 0, width: KScreenWidth - 30, height: (KScreenWidth-30)*9/16))
    self.images = images
    setViews(self.images)
  }
  
  override init(frame:CGRect) {
    super.init(frame: frame)
//    setViews(images)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setViews(images: [String]) {
    let scorllerView = UIScrollView(frame: self.frame)
    scorllerView.pagingEnabled = true
    scorllerView.frame = self.frame
    self.addSubview(scorllerView)
    
    for (index,value) in images.enumerate() {
      let size = CGSize(width: self.width, height: self.height)
      var imageView: UIImageView!
      if value == "image1" {
        imageView =  UIImageView(image: UIImage(named:"\(value)"))
      } else {
        let url = NSURL(string: value)
        let imageViewURL = UIImageView()
        imageViewURL.sd_setImageWithURL(url)
        imageView = imageViewURL
      }
      imageView.frame = CGRect(origin: CGPoint(x: CGFloat(index) * self.width, y: 0), size: size)
      imageView.center =  CGPoint(x: CGFloat(index) * self.width + scorllerView.center.x, y: scorllerView.center.y)
      imageViews.append(imageView)
      scorllerView.addSubview(imageView)
    }
    scorllerView.contentSize = CGSize(width: self.width * CGFloat(images.count), height: scorllerView.height)
  }
}
