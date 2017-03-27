//
//  ApiClient.swift
//  SwiftCocoa
//
//  Created by 王振宇 on 5/12/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
enum HttpRequestType: String {
  case OPTIONS, GET, HEAD, POST, PUT, PATCH, DELETE, TRACE, CONNECT
}


struct ApiClient {
  
  //生成header信息，每个请求都必须带的
  private static func generationHeaders() -> [String : String] {
    let headers = [
      "feeToken": UserDefaultsTool.userToken
//      "X-App-Id": "",
//      "X-Requested-With": "XMLHttpRequest",
//      "HTTP_X_APP_TYPE": "2",
//      "X-Udid" : "",
//      "X-User-Phone-Brand" : "",
//      "X-User-System" : ""
    ]
    return headers
  }
  
  
  // Request 请求封装
  private static func alamofireRequest(method: Alamofire.Method,_ URLString: URLStringConvertible, parameters: [String: AnyObject]?) -> Request {
    return request(method, URLString, parameters: parameters, encoding: .URL, headers: self.generationHeaders())
  }
  
  
  static func fetch(type: HttpRequestType, URLString url: String, paramters para: [String: AnyObject]? = nil, promise: (Promise<JSON>) -> ()){
    let method = Method(rawValue: type.rawValue)!
    self.alamofireRequest(method, url, parameters: para).responseJSON { response in
      debugPrint("url === \(url)")
      if let value = response.result.value {
        let json = JSON(value)
        let code = json["code"].intValue
        if code == 14000 {
          LoginService.showLogin()
          let msg = json["msg"].stringValue
          HUD.showError(status: msg)
          return
        }
        promise(Promise.Success(json))
        debugPrint(json)
        return
      }
      promise(Promise.Error(response.result.error!))
    }
  }
  
  
  /// 下载图片并获取图片cookie
  static func downLoadImage(urlString: String, compeletion: (NSData?, String?) -> ()) {
    let url = NSURL(string: urlString)
    let request = NSURLRequest(URL: url!)
    NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) in
      let httpUrlResponse = response as! NSHTTPURLResponse
      let cookieString = (httpUrlResponse.allHeaderFields as NSDictionary).valueForKey("Set-Cookie") as? String
      compeletion(data, cookieString)
    }
  }
}
