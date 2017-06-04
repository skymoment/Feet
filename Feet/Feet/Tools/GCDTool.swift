//
//  GCDTool.swift
//  SwiftCocoa
//
//  Created by 王振宇 on 5/4/16.
//  Copyright © 2016 wangzhenyu. All rights reserved.
//

import Foundation

//typealias Task = (_ cancel: Bool) -> Void
//
//struct GCDTool {
//  static func delay(_ time: TimeInterval, task:@escaping () -> ()) -> Task? {
//    
//    func dispatch_later(_ block: @escaping ()->()) {
//      DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(time * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: block)
//    }
//    
//    var closure: ()->()? = task
//    var result: Task?
//    
//    let delayedClosure: Task = { cancel in
//      if let internalClosure = closure {
//        if (cancel == false) {
//          DispatchQueue.main.async(execute: internalClosure);
//        }
//      }
//      closure = nil
//      result = nil
//    }
//    
//    result = delayedClosure
//    
//    dispatch_later {
//      if let delayedClosure = result {
//        delayedClosure(false)
//      }
//    }
//    return result
//  }
//  
//  func cancel(_ task: Task?) {
//    task?(true)
//  }
//  
//  static func mainQueue(_ task: @escaping () -> Void){
//    DispatchQueue.main.async(execute: task)
//  }
//  
//  static func backQueue(_ task: () -> ()){
//    DispatchQueue.global(priority: 0).async(execute: task)
//  }
//  
//  static func onceQueue(_ task: () -> ()){
//    var onceToken: Int = 0
//    dispatch_once(&onceToken,task)
//  }
//}




