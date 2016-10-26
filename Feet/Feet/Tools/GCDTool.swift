//
//  GCDTool.swift
//  SwiftCocoa
//
//  Created by 王振宇 on 5/4/16.
//  Copyright © 2016 wangzhenyu. All rights reserved.
//

import Foundation

typealias Task = (cancel: Bool) -> Void

struct GCDTool {
  static func delay(time: NSTimeInterval, task:() -> ()) -> Task? {
    
    func dispatch_later(block: ()->()) {
      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), block)
    }
    
    var closure: dispatch_block_t? = task
    var result: Task?
    
    let delayedClosure: Task = { cancel in
      if let internalClosure = closure {
        if (cancel == false) {
          dispatch_async(dispatch_get_main_queue(), internalClosure);
        }
      }
      closure = nil
      result = nil
    }
    
    result = delayedClosure
    
    dispatch_later {
      if let delayedClosure = result {
        delayedClosure(cancel: false)
      }
    }
    return result
  }
  
  func cancel(task: Task?) {
    task?(cancel: true)
  }
  
  static func mainQueue(task: () -> Void){
    dispatch_async(dispatch_get_main_queue(), task)
  }
  
  static func backQueue(task: () -> ()){
    dispatch_async(dispatch_get_global_queue(0,0),task)
  }
  
  static func onceQueue(task: () -> ()){
    var onceToken: dispatch_once_t = 0
    dispatch_once(&onceToken,task)
  }
}




