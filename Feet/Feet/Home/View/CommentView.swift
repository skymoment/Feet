//
//  CommentView.swift
//  Feet
//
//  Created by zhenyu on 11/20/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import UIKit

protocol CommentViewDelegate: class {
  func commented()
}

class CommentView: UIView {
  
  weak var borderText: BorderTextField!
  var userId = ""
  var feetId = ""
  
  weak var delegate: CommentViewDelegate?
  
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
    self.backgroundColor = UIColor(hexString: "#FFFFFF", alpha: 0.7)

    let topLine = UIView()
    topLine.backgroundColor = UIColor(hexString: "#b4b4b4")
    self.addSubview(topLine)
    topLine.snp_makeConstraints { (make) in
      make.top.equalTo(self.snp_top)
      make.left.right.equalTo(self)
      make.height.equalTo(1)
    }
    
    borderText = {
      let b = BorderTextField()
      b.textField.textColor = UIColor.blackColor()
      b.borderColor = UIColor(hexString: "#b4b4b4")
      b.textField.delegate = self
      b.placeHolder = "抢个沙发吧 ~"
      self.addSubview(b)
      b.snp_makeConstraints { (make) in
        make.centerY.equalTo(self)
        make.left.equalTo(15)
        make.right.equalTo(self.snp_right).offset(-15)
        make.height.equalTo(32)
      }
      return b
    }()
  }
  
  // MARK: - LoadData
  func loadData(userId: String, feetId: String) {
    self.userId = userId
    self.feetId = feetId
  }
  
  // MARK: - Method
  func normal() {
    self.backgroundColor = UIColor(hexString: "#FFFFFF", alpha: 0.7)
  }
  
  func hight() {
    self.backgroundColor = UIColor(hexString: "#FFFFFF", alpha: 1.0)
  }
}

// MAKR: - UITextFieldDelegate
extension CommentView: UITextFieldDelegate {
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    let content = textField.text!.componentsSeparatedByString(":")
    
    guard LoginService.isLogin() else {
      return false
    }
    
    guard textField.text?.length() > 0 else {
      debugPrint("评论内容不能为空哦")
      return true
    }
    
    let comment = content.count >= 2 ? content[1] : textField.text!
    
    let params = ["content": comment,
                  "feetid": feetId,
                  "replyUserId": userId
                  ]
    HomeNetworkTool.commentFeet(params) { promiseJSON in
      do {
        let _ = try promiseJSON.then({models in
          textField.text = ""
          textField.resignFirstResponder()
          self.delegate?.commented()
        }).resolve()
      } catch where error is MyError{
        debugPrint("\(error)")
      } catch{
        debugPrint("网络错误")
      }
    }
    return true
  }
}
