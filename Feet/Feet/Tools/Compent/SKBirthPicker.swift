//
//  SKPicker.swift
//  Feet
//
//  Created by zhenyu on 12/4/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import UIKit

protocol SKBirthPickerDelegate: class {
  func pickerChanged(date: String)
}

class SKBirthPicker: UIView {
  
  weak var picker: UIDatePicker!
  
  weak var delegate: SKBirthPickerDelegate?
  
  // MARK: - LifeCycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    setViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - SetViews
  func setViews() {
    backgroundColor = UIColor.clearColor()
    picker = {
      let p = UIDatePicker()
      addSubview(p)
      p.snp_makeConstraints(closure: { (make) in
        make.left.right.bottom.equalTo(self)
        make.height.equalTo(162)
      })
      p.setValue(UIColor.whiteColor(), forKey: "textColor")
      p.datePickerMode = .Date
      p.locale = NSLocale(localeIdentifier: "zh")
      p.addTarget(self, action: #selector(datePickerChanged), forControlEvents: .ValueChanged)
      return p
    }()
  }
  
  // MARK: - Method
  func datePickerChanged(picker: UIDatePicker) {
    let formatter = NSDateFormatter()
    formatter.dateFormat = "yyyy年MM月dd日"
    let date = formatter.stringFromDate(picker.date)
    delegate?.pickerChanged(date)
  }
}

