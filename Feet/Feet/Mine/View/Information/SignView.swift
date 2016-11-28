//
//  SignView.swift
//  Feet
//
//  Created by 王振宇 on 10/7/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import UIKit

class SignView: UIView {

  weak var boderField: BorderTextField!
  var sign: String {
    get {
      return boderField.text
    }
  }
  
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
    let h = TransparentView()
    self.addSubview(h)
    h.snp_makeConstraints { (make) in
      make.top.equalTo(64 + 15)
      make.left.equalTo(15)
      make.right.equalTo(-15)
      make.height.equalTo(180)
    }
    
    
    let imageView = UIImageView(image: UIImage(named:"sign"))
    h.addSubview(imageView)
    imageView.snp_makeConstraints(closure: { (make) in
      make.top.equalTo(15)
      make.centerX.equalTo(h)
      make.width.height.equalTo(28)
    })
    
    
    boderField = {
      let b = BorderTextField()
      b.placeHolder = "侬能写点东西吗？"
      b.textField.becomeFirstResponder()
      h.addSubview(b)
      b.snp_makeConstraints { (make) in
        make.top.equalTo(imageView.snp_bottom).offset(50)
        make.left.equalTo(h.snp_left).offset(20)
        make.right.equalTo(h.snp_right).offset(-20)
        make.height.equalTo(40)
      }
      return b
    }()
  }
}
