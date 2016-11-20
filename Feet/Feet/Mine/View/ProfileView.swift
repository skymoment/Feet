//
//  ProfileView.swift
//  Feet
//
//  Created by 王振宇 on 7/31/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import UIKit

protocol ProfileDelegate: class {
  func pushToInfoView(type: InfoViews)
  func logOutAction()
}

class ProfileView: UIView {
  
  let preTag = 100
  var headerView: TransparentView!   // 101
  var signView: TransparentView!     // 102
  var nameView: TransparentView!     // 103
  var sexView: TransparentView!      // 104
  var brithdayView: TransparentView! // 105
  var mailView: TransparentView!     // 106
  var updateView: TransparentView!   // 107
  var changBackView: TransparentView!// 108
  var logOutView: TransparentView!   // 109
  
  var userModel: UserModel!
  
  weak var delegate: ProfileDelegate?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.addSubview(BackView())
    setViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setViews() {
    headerView = {
      let h = TransparentView()
      h.tag = preTag + 1
      let tapGesture = UITapGestureRecognizer(target: self, action: #selector(transparentViewTaped))
      h.addGestureRecognizer(tapGesture)
      self.addSubview(h)
      h.snp_makeConstraints { (make) in
        make.top.equalTo(15 + 64)
        make.left.equalTo(15)
        make.right.equalTo(-15)
        make.height.equalTo(75)
      }
      // 头像 需要替换
      let avatar = UIImageView(image: UIImage(named:"m_default"))
      avatar.layer.cornerRadius = 23
      avatar.layer.masksToBounds = true
      h.addSubview(avatar)
      avatar.snp_makeConstraints(closure: { (make) in
        make.center.equalTo(h)
        make.width.height.equalTo(46)
      })
      
      return h
    }()
    
    
    signView = {
      let h = TransparentView()
      h.tag = preTag + 2
      let tapGesture = UITapGestureRecognizer(target: self, action: #selector(transparentViewTaped))
      h.addGestureRecognizer(tapGesture)
      self.addSubview(h)
      h.snp_makeConstraints { (make) in
        make.top.equalTo(headerView.snp_bottom).offset(10)
        make.left.right.equalTo(headerView)
        make.height.equalTo(75)
      }
      
      let imageView = UIImageView(image: UIImage(named: "sign"))
      h.addSubview(imageView)
      imageView.snp_makeConstraints(closure: { (make) in
        make.centerX.equalTo(h)
        make.top.equalTo(10)
      })
      
      let label = UILabel()
      h.addSubview(label)
      label.textColor = UIColor.whiteColor()
      label.text = "彰显个性，留下签名"
      label.font = UIFont.systemFontOfSize(15)
      label.snp_makeConstraints(closure: { (make) in
        make.centerX.equalTo(imageView)
        make.top.equalTo(imageView.snp_bottom).offset(10)
      })
      return h
    }()
    
    nameView = {
      let h = TransparentView()
      h.tag = preTag + 3
      let tapGesture = UITapGestureRecognizer(target: self, action: #selector(transparentViewTaped))
      h.addGestureRecognizer(tapGesture)
      self.addSubview(h)
      h.snp_makeConstraints { (make) in
        make.top.equalTo(signView.snp_bottom).offset(10)
        make.left.equalTo(signView)
        make.right.equalTo(signView.snp_centerX).offset(-10)
        make.height.equalTo(75)
      }
      
      let imageView = UIImageView(image: UIImage(named: "name"))
      h.addSubview(imageView)
      imageView.snp_makeConstraints(closure: { (make) in
        make.centerX.equalTo(h)
        make.top.equalTo(10)
      })
      
      let label = UILabel()
      h.addSubview(label)
      label.textColor = UIColor.whiteColor()
      label.text = "昵称"
      label.font = UIFont.systemFontOfSize(15)
      label.snp_makeConstraints(closure: { (make) in
        make.centerX.equalTo(imageView)
        make.top.equalTo(imageView.snp_bottom).offset(10)
      })
      return h
    }()
    
    sexView = {
      let h = TransparentView()
      h.tag = preTag + 4
      let tapGesture = UITapGestureRecognizer(target: self, action: #selector(transparentViewTaped))
      h.addGestureRecognizer(tapGesture)
      self.addSubview(h)
      h.snp_makeConstraints { (make) in
        make.top.equalTo(signView.snp_bottom).offset(10)
        make.right.equalTo(signView)
        make.left.equalTo(signView.snp_centerX).offset(10)
        make.height.equalTo(75)
      }
      
      let label = UILabel()
      h.addSubview(label)
      label.textColor = UIColor.whiteColor()
      label.text = "性别"
      label.font = UIFont.systemFontOfSize(15)
      label.snp_makeConstraints(closure: { (make) in
        make.centerX.equalTo(h)
        make.top.equalTo(20)
      })
      
      let imageView = UIImageView(image: UIImage(named: "sex_m"))
      h.addSubview(imageView)
      imageView.snp_makeConstraints(closure: { (make) in
        make.centerX.equalTo(label)
        make.top.equalTo(label.snp_bottom).offset(10)
      })
      
      return h
    }()
    
    
    brithdayView = {
      let h = TransparentView()
      h.tag = preTag + 5
      let tapGesture = UITapGestureRecognizer(target: self, action: #selector(transparentViewTaped))
      h.addGestureRecognizer(tapGesture)
      self.addSubview(h)
      h.snp_makeConstraints { (make) in
        make.top.equalTo(nameView.snp_bottom).offset(10)
        make.left.equalTo(nameView)
        make.right.equalTo(nameView)
        make.height.equalTo(75)
      }
      
      
      let imageView = UIImageView(image: UIImage(named: "brithday"))
      h.addSubview(imageView)
      imageView.snp_makeConstraints(closure: { (make) in
        make.centerX.equalTo(h)
        make.top.equalTo(10)
      })
      
      let label = UILabel()
      h.addSubview(label)
      label.textColor = UIColor.whiteColor()
      label.text = "请选择生日"
      label.font = UIFont.systemFontOfSize(15)
      label.snp_makeConstraints(closure: { (make) in
        make.centerX.equalTo(imageView)
        make.top.equalTo(imageView.snp_bottom).offset(10)
      })
      
      return h
    }()
    
    
    mailView = {
      let h = TransparentView()
      h.tag = preTag + 6
      let tapGesture = UITapGestureRecognizer(target: self, action: #selector(transparentViewTaped))
      h.addGestureRecognizer(tapGesture)
      self.addSubview(h)
      h.snp_makeConstraints { (make) in
        make.top.equalTo(sexView.snp_bottom).offset(10)
        make.left.equalTo(sexView)
        make.right.equalTo(sexView)
        make.height.equalTo(75)
      }
      
      
      let imageView = UIImageView(image: UIImage(named: "email"))
      h.addSubview(imageView)
      imageView.snp_makeConstraints(closure: { (make) in
        make.centerX.equalTo(h)
        make.top.equalTo(10)
      })
      
      let label = UILabel()
      h.addSubview(label)
      label.textColor = UIColor.whiteColor()
      label.text = "请输入您的邮箱"
      label.font = UIFont.systemFontOfSize(15)
      label.snp_makeConstraints(closure: { (make) in
        make.centerX.equalTo(imageView)
        make.top.equalTo(imageView.snp_bottom).offset(10)
      })
      
      return h
    }()
    
    
    logOutView = {
      let h = TransparentView()
      h.backgroundColor = UIColor(hexString: "#000000", alpha: 0.3)
      h.tag = preTag + 9
      let tapGesture = UITapGestureRecognizer(target: self, action: #selector(transparentViewTaped))
      h.addGestureRecognizer(tapGesture)
      self.addSubview(h)
      h.snp_makeConstraints { (make) in
        make.top.equalTo(mailView.snp_bottom).offset(10)
        make.left.equalTo(signView)
        make.right.equalTo(signView)
        make.height.equalTo(45)
      }
      
      
      let imageView = UIImageView(image: UIImage(named: "logOut"))
      h.addSubview(imageView)
      imageView.snp_makeConstraints(closure: { (make) in
        make.centerX.equalTo(h).offset(-30)
        make.centerY.equalTo(h)
      })
      
      let label = UILabel()
      h.addSubview(label)
      label.textColor = UIColor.whiteColor()
      label.text = "退出登录"
      label.font = UIFont.systemFontOfSize(15)
      label.snp_makeConstraints(closure: { (make) in
        make.centerY.equalTo(imageView)
        make.left.equalTo(imageView.snp_right).offset(8)
      })
      
      return h
    }()
  }
  
  func transparentViewTaped(sender: UITapGestureRecognizer) {
    let tag = sender.view?.tag
    debugPrint("InfoViewTag: \(tag)")
    
    guard tag == 109 || tag == 101  else {
      let type = InfoViews(type: tag!)
      delegate?.pushToInfoView(type)
      return
    }
    
    if tag == 101 {
      debugPrint("更换头像")
    } else {
      debugPrint("退出登录")
      delegate?.logOutAction()
    }
  }
}
