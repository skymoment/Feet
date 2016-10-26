//
//  NavigationController.swift
//  Feet
//
//  Created by 王振宇 on 6/5/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationBar.setBackgroundImage(UIImage(named: "touming"), forBarMetrics: .Default)
    navigationBar.barStyle = .BlackTranslucent
    navigationBar.clipsToBounds = true;
    navigationBar.tintColor = UIColor.whiteColor()
  }
}
