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
  
  class func showLogin() {
    let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("login")
    dispatch_async(dispatch_get_main_queue()) {
      if let vc = kWindow?.rootViewController {
        vc.presentViewController(loginVC, animated: true, completion: nil)
      }
    }
  }
  
  class func isLogin() -> Bool {
    return UserDefaultsTool.isLogin()
  }
}
