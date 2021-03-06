//
//  BorderTextField.swift
//  Feet
//
//  Created by zhenyu on 10/29/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import UIKit

class BorderTextField: UIView {
  weak var textField: UITextField!
  
  var text: String {
    get {
      if let field = textField {
        return field.text! ?? ""
      } else {
        return ""
      }
    }
    
    set {
      if let field = textField {
        field.text = newValue
      }
    }
  }
  
  var placeHolder: String {
    get {
      if let field = textField {
        return field.placeholder ?? ""
      } else {
        return ""
      }
    }
    
    set {
      if let field = textField {
        field.placeholder = newValue
      }
    }
  }
  
  var borderColor: UIColor {
    set {
      self.layer.borderColor = newValue.cgColor
    }
    get {
      return UIColor(cgColor: self.layer.borderColor!)
    }
  }
  
  
  // LifeCycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    setViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - setViews
  func setViews() {
    self.layer.borderColor = UIColor.white.cgColor
    self.layer.borderWidth = 1
    self.layer.cornerRadius = 3
    
    textField = {
      let t = UITextField()
      t.borderStyle = .none
      t.font = UIFont.systemFont(ofSize: 15)
      t.textAlignment = .center
      t.textColor = UIColor.white
      addSubview(t)
      t.snp.makeConstraints { (make) in
        make.center.equalTo(self)
        make.left.equalTo(12)
        make.right.equalTo(-12)
        make.height.equalTo(36)
      }
      return t
    }()
  }

  
  // MARK: - Method
  func highLightBorder() {
  }
  
  func normalBorder() {
    //    self.layer.borderColor = kLightColor.CGColor
  }
}

