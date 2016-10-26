//
//  PromiseEnum.swift
//  SwiftCocoa
//
//  Created by 王振宇 on 5/12/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import Foundation

struct MyError: ErrorType {
  var error: String = ""
}

extension MyError: CustomStringConvertible {
  var description: String {
    return self.error
  }
}

enum Promise<T> {
  case Success(T)
  case Error(ErrorType)
}

// T 和 U 都表示类型
extension Promise {
  func then<U>(f: T -> U) -> Promise<U> {
    switch self {
    case .Success(let t): return .Success(f(t))
    case .Error(let err): return .Error(err)
    }
  }
  
  func then<U>(f: T -> Promise<U>) -> Promise<U> {
    switch self {
    case .Success(let t): return f(t)
    case .Error(let err): return .Error(err)
    }
  }
}

extension Promise {
  func resolve() throws -> T {
    switch self {
    case Promise.Success(let value): return value
    case Promise.Error(let error): throw error
    }
  }
  
  init(@noescape _ throwingExpr: Void throws -> T) {
    do{
      let value = try throwingExpr()
      self = Promise.Success(value)
    } catch {
      self = Promise.Error(error)
    }
  }
}
