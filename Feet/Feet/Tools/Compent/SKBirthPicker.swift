//
//  SKPicker.swift
//  Feet
//
//  Created by zhenyu on 12/4/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import UIKit

protocol SKBirthPickerDelegate: class {
  func pickerChanged(_ date: String)
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
    backgroundColor = UIColor.clear
    picker = {
      let p = UIDatePicker()
      addSubview(p)
      p.snp.makeConstraints({ (make) in
        make.left.right.bottom.equalTo(self)
        make.height.equalTo(162)
      })
      p.setValue(UIColor.white, forKey: "textColor")
      p.datePickerMode = .date
      p.locale = Locale(identifier: "zh")
      p.addTarget(self, action: #selector(datePickerChanged), for: .valueChanged)
      return p
    }()
  }
  
  // MARK: - Method
  func datePickerChanged(_ picker: UIDatePicker) {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy年MM月dd日"
    let date = formatter.string(from: picker.date)
    delegate?.pickerChanged(date)
  }
}

