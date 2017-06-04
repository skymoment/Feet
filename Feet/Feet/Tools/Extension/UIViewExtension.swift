//
//  UIViewExtension.swift
//  SwiftCocoa
//
//  Created by 王振宇 on 7/6/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import UIKit

extension UIView {
  
  // x
  var x: CGFloat {
    return self.frame.origin.x
  }
  
  // y
  var y: CGFloat {
    return self.frame.origin.y
  }
  
  // width
  var width: CGFloat {
    return self.frame.width
  }
  
  // height
  var height: CGFloat {
    return self.frame.height
  }
  
  
  // initViewFromXIB
  func initViewFromXIB(_ xibName: String) -> AnyObject {
    return UINib(nibName: xibName, bundle: nil).instantiate(withOwner: self, options: nil).first! as AnyObject
  }
}
