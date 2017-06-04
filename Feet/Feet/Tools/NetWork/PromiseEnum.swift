//
//  PromiseEnum.swift
//  SwiftCocoa
//
//  Created by 王振宇 on 5/12/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import Foundation

struct MyError: Error {
  var error: String = ""
}

extension MyError: CustomStringConvertible {
  var description: String {
    return self.error
  }
}

enum Promise<T> {
  case success(T)
  case error(Error)
}

// T 和 U 都表示类型
extension Promise {
  func then<U>(_ f: (T) -> U) -> Promise<U> {
    switch self {
    case .success(let t): return .success(f(t))
    case .error(let err): return .error(err)
    }
  }
  
  func then<U>(_ f: (T) -> Promise<U>) -> Promise<U> {
    switch self {
    case .success(let t): return f(t)
    case .error(let err): return .error(err)
    }
  }
}

extension Promise {
  func resolve() throws -> T {
    switch self {
    case Promise.success(let value): return value
    case Promise.error(let error): throw error
    }
  }
  
  init(_ throwingExpr: (Void) throws -> T) {
    do{
      let value = try throwingExpr()
      self = Promise.success(value)
    } catch {
      self = Promise.error(error)
    }
  }
}
