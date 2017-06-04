//
//  BirthdayView.swift
//  Feet
//
//  Created by 王振宇 on 10/7/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import UIKit

class BirthdayView: UIView {

  var birthdayPicker: SKBirthPicker!
  weak var boderField: BorderTextField!
  
  var birthday: String {
    get {
      return boderField.text
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setViews() {
    let h = TransparentView()
    self.addSubview(h)
    h.snp.makeConstraints { (make) in
      make.top.equalTo(64 + 15)
      make.left.equalTo(15)
      make.right.equalTo(-15)
      make.height.equalTo(180)
    }
    
    let birthImage = UIImageView(image: UIImage(named:"brithday"))
    h.addSubview(birthImage)
    birthImage.snp.makeConstraints({ (make) in
      make.top.equalTo(15)
      make.centerX.equalTo(h)
      make.width.height.equalTo(28)
    })
    
    birthdayPicker = {
      let p = SKBirthPicker()
      p.frame = CGRect(x: 0, y: KScreenHeigth - 162, width: KScreenWidth, height: 162)
      p.delegate = self
      return p
    }()
    
    boderField = {
      let b = BorderTextField()
      b.placeHolder = "选择侬的生日"
      b.textField.inputView = birthdayPicker
      b.textField.delegate = self
      h.addSubview(b)
      b.snp.makeConstraints { (make) in
        make.top.equalTo(birthImage.snp.bottom).offset(50)
        make.left.equalTo(h.snp.left).offset(20)
        make.right.equalTo(h.snp.right).offset(-20)
        make.height.equalTo(40)
      }
      return b
    }()
  }
}

extension BirthdayView: SKBirthPickerDelegate {
  func pickerChanged(_ date: String) {
    boderField.text = date
  }
}

extension BirthdayView: UITextFieldDelegate {
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    return false
  }
}
