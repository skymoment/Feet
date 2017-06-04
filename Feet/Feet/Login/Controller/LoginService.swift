//
//  LoginService.swift
//  Feet
//
//  Created by 王振宇 on 7/30/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import UIKit

class LoginService: NSObject {
  class func logIn(_ viewcontroller: UIViewController, next: () ->()) {
    if !UserDefaultsTool.isLogin() {
      let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "login")
      DispatchQueue.main.async {
        viewcontroller.present(loginVC, animated: true, completion: nil)
      }
    } else {
      next()
    }
  }
  
  class func showLogin() {
    UserDefaultsTool.cleanUserInfo()
    let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "login")
    DispatchQueue.main.async {
      if let vc = kWindow?.rootViewController {
        vc.present(loginVC, animated: true, completion: nil)
      }
    }
  }
  
  class func isLogin() -> Bool {
    return UserDefaultsTool.isLogin()
  }
  
  
  /// 下载图片并获取图片cookie
  class func downLoadImage(_ urlString: String, compeltion: @escaping (Data, String) -> ()) {
    debugPrint("urlString ====== \(urlString)")
    let url = URL(string: urlString)
    let request = URLRequest(url: url!)
    NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) { (response, data, error) in
      let httpUrlResponse = response as! HTTPURLResponse
      let cookieString = (httpUrlResponse.allHeaderFields as NSDictionary).value(forKey: "Set-Cookie") as? String
      debugPrint("cookieString ======== \(cookieString)")
      if let cookieString = cookieString {
        compeltion(data!, cookieString)
      }
    }
  }
}
