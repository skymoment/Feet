//
//  LoginService.swift
//  Feet
//
//  Created by 王振宇 on 7/30/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import UIKit

class LoginService: NSObject {
  class func logIn(viewcontroller: UIViewController, next: () ->()) {
    if !UserDefaultsTool.isLogin() {
      let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("login")
      dispatch_async(dispatch_get_main_queue()) {
        viewcontroller.presentViewController(loginVC, animated: true, completion: nil)
      }
    } else {
      next()
    }
  }
}
