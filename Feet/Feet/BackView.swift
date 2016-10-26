//
//  BackView.swift
//  Feet
//
//  Created by 王振宇 on 5/29/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import UIKit

class BackView: UIView {
  var imageView: UIImageView!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(loadBackImage), name: KChangeThemeNotification, object: nil)
    self.frame = CGRect(x: 0, y: 0, width: KScreenWidth, height: KScreenHeigth)
    setBackView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func setBackView() {
    
    let newImage = UIImage(named: "summer")?.blurImageWithRadius(10)
    let imageView = UIImageView(image: newImage)
    imageView.frame = CGRect(x: 0, y: 0, width: KScreenWidth, height: KScreenHeigth)

    self.imageView = imageView
    self.addSubview(imageView)
  }

  func loadBackImage() {
    let newImage = ThemeManager.shareInstance.getThemeImage()
    imageView.image = newImage
  }
}
