//
//  ProfileView.swift
//  Feet
//
//  Created by 王振宇 on 7/31/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import UIKit

protocol ProfileDelegate: class {
  func pushToInfoView(_ type: InfoViews)
  func logOutAction()
  func changeAvatar(_ view: UIImageView)
}

class ProfileView: UIView {
  
  let preTag = 100
  var headerView: TransparentView!   // 101
  var signView: TransparentView!     // 102
  var signLabel: UILabel!
  var nameView: TransparentView!     // 103
  var nameLabel: UILabel!
  var sexView: TransparentView!      // 104
  var sexImageView: UIImageView!
  var brithdayView: TransparentView! // 105
  var birthdayLabel: UILabel!
  var mailView: TransparentView!     // 106
  var mailLabel: UILabel!
  var updateView: TransparentView!   // 107
  var changBackView: TransparentView!// 108
  var logOutView: TransparentView!   // 109
  var headerImageView: UIImageView!  // 头像
  
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
      h.snp.makeConstraints { (make) in
        make.top.equalTo(15 + 64)
        make.left.equalTo(15)
        make.right.equalTo(-15)
        make.height.equalTo(75)
      }
      // 头像 需要替换
      var image: UIImage!
      if let imageData = UserDefaultsTool.headerData {
        image = UIImage(data: imageData as Data)
      } else {
        image = UIImage(named: "d_header2")
      }
      let avatar = UIImageView(image: image)
      avatar.layer.cornerRadius = 23
      avatar.layer.masksToBounds = true
      h.addSubview(avatar)
      avatar.snp.makeConstraints({ (make) in
        make.center.equalTo(h)
        make.width.height.equalTo(46)
      })
      headerImageView = avatar
      
      return h
    }()
    
    
    signView = {
      let h = TransparentView()
      h.tag = preTag + 2
      let tapGesture = UITapGestureRecognizer(target: self, action: #selector(transparentViewTaped))
      h.addGestureRecognizer(tapGesture)
      self.addSubview(h)
      h.snp.makeConstraints { (make) in
        make.top.equalTo(headerView.snp.bottom).offset(10)
        make.left.right.equalTo(headerView)
        make.height.equalTo(75)
      }
      
      let imageView = UIImageView(image: UIImage(named: "sign"))
      h.addSubview(imageView)
      imageView.snp.makeConstraints({ (make) in
        make.centerX.equalTo(h)
        make.top.equalTo(10)
      })
      
      let label = UILabel()
      h.addSubview(label)
      label.textColor = UIColor.white
      label.text = "彰显个性，留下签名"
      label.font = UIFont.systemFont(ofSize: 15)
      label.snp.makeConstraints({ (make) in
        make.centerX.equalTo(imageView)
        make.top.equalTo(imageView.snp.bottom).offset(10)
      })
      signLabel = label
      return h
    }()
    
    nameView = {
      let h = TransparentView()
      h.tag = preTag + 3
      let tapGesture = UITapGestureRecognizer(target: self, action: #selector(transparentViewTaped))
      h.addGestureRecognizer(tapGesture)
      self.addSubview(h)
      h.snp.makeConstraints { (make) in
        make.top.equalTo(signView.snp.bottom).offset(10)
        make.left.equalTo(signView)
        make.right.equalTo(signView.snp.centerX).offset(-10)
        make.height.equalTo(75)
      }
      
      let imageView = UIImageView(image: UIImage(named: "name"))
      h.addSubview(imageView)
      imageView.snp.makeConstraints({ (make) in
        make.centerX.equalTo(h)
        make.top.equalTo(10)
      })
      
      let label = UILabel()
      h.addSubview(label)
      label.textColor = UIColor.white
      label.text = "昵称"
      label.font = UIFont.systemFont(ofSize: 15)
      label.snp.makeConstraints({ (make) in
        make.centerX.equalTo(imageView)
        make.top.equalTo(imageView.snp.bottom).offset(10)
      })
      nameLabel = label
      return h
    }()
    
    sexView = {
      let h = TransparentView()
      h.tag = preTag + 4
      let tapGesture = UITapGestureRecognizer(target: self, action: #selector(transparentViewTaped))
      h.addGestureRecognizer(tapGesture)
      self.addSubview(h)
      h.snp.makeConstraints { (make) in
        make.top.equalTo(signView.snp.bottom).offset(10)
        make.right.equalTo(signView)
        make.left.equalTo(signView.snp.centerX).offset(10)
        make.height.equalTo(75)
      }
      
      let label = UILabel()
      h.addSubview(label)
      label.textColor = UIColor.white
      label.text = "性别"
      label.font = UIFont.systemFont(ofSize: 15)
      label.snp.makeConstraints({ (make) in
        make.centerX.equalTo(h)
        make.top.equalTo(20)
      })
      
      
      let imageView = UIImageView(image: UIImage(named: "sex_m"))
      h.addSubview(imageView)
      imageView.snp.makeConstraints({ (make) in
        make.centerX.equalTo(label)
        make.top.equalTo(label.snp.bottom).offset(10)
      })
      sexImageView = imageView
      return h
    }()
    
    
    brithdayView = {
      let h = TransparentView()
      h.tag = preTag + 5
      let tapGesture = UITapGestureRecognizer(target: self, action: #selector(transparentViewTaped))
      h.addGestureRecognizer(tapGesture)
      self.addSubview(h)
      h.snp.makeConstraints { (make) in
        make.top.equalTo(nameView.snp.bottom).offset(10)
        make.left.equalTo(nameView)
        make.right.equalTo(nameView)
        make.height.equalTo(75)
      }
      
      
      let imageView = UIImageView(image: UIImage(named: "brithday"))
      h.addSubview(imageView)
      imageView.snp.makeConstraints({ (make) in
        make.centerX.equalTo(h)
        make.top.equalTo(10)
      })
      
      let label = UILabel()
      h.addSubview(label)
      label.textColor = UIColor.white
      label.text = "请选择生日"
      label.font = UIFont.systemFont(ofSize: 15)
      label.snp.makeConstraints({ (make) in
        make.centerX.equalTo(imageView)
        make.top.equalTo(imageView.snp.bottom).offset(10)
      })
      birthdayLabel = label
      return h
    }()
    
    
    mailView = {
      let h = TransparentView()
      h.tag = preTag + 6
      let tapGesture = UITapGestureRecognizer(target: self, action: #selector(transparentViewTaped))
      h.addGestureRecognizer(tapGesture)
      self.addSubview(h)
      h.snp.makeConstraints { (make) in
        make.top.equalTo(sexView.snp.bottom).offset(10)
        make.left.equalTo(sexView)
        make.right.equalTo(sexView)
        make.height.equalTo(75)
      }
      
      
      let imageView = UIImageView(image: UIImage(named: "email"))
      h.addSubview(imageView)
      imageView.snp.makeConstraints({ (make) in
        make.centerX.equalTo(h)
        make.top.equalTo(10)
      })
      
      let label = UILabel()
      h.addSubview(label)
      label.textColor = UIColor.white
      label.text = "请输入您的邮箱"
      if smallScreen {
        label.font = UIFont.systemFont(ofSize: 12)
      } else {
        label.font = UIFont.systemFont(ofSize: 15)
      }
      label.snp.makeConstraints({ (make) in
        make.centerX.equalTo(imageView)
        make.top.equalTo(imageView.snp.bottom).offset(10)
      })
      mailLabel = label
      return h
    }()
    
    
    logOutView = {
      let h = TransparentView()
      h.backgroundColor = UIColor(hexString: "#000000", alpha: 0.3)
      h.tag = preTag + 9
      let tapGesture = UITapGestureRecognizer(target: self, action: #selector(transparentViewTaped))
      h.addGestureRecognizer(tapGesture)
      self.addSubview(h)
      h.snp.makeConstraints { (make) in
        make.top.equalTo(mailView.snp.bottom).offset(10)
        make.left.equalTo(signView)
        make.right.equalTo(signView)
        make.height.equalTo(45)
      }
      
      
      let imageView = UIImageView(image: UIImage(named: "logOut"))
      h.addSubview(imageView)
      imageView.snp.makeConstraints({ (make) in
        make.centerX.equalTo(h).offset(-30)
        make.centerY.equalTo(h)
      })
      
      let label = UILabel()
      h.addSubview(label)
      label.textColor = UIColor.white
      label.text = "退出登录"
      label.font = UIFont.systemFont(ofSize: 15)
      label.snp.makeConstraints({ (make) in
        make.centerY.equalTo(imageView)
        make.left.equalTo(imageView.snp.right).offset(8)
      })
      
      return h
    }()
  }
  
  func transparentViewTaped(_ sender: UITapGestureRecognizer) {
    let tag = sender.view?.tag
    debugPrint("InfoViewTag: \(tag)")
    
    guard tag == 109 || tag == 101  else {
      let type = InfoViews(type: tag!)
      delegate?.pushToInfoView(type)
      return
    }
    
    if tag == 101 {
      debugPrint("更换头像")
      delegate?.changeAvatar(headerImageView)
    } else {
      debugPrint("退出登录")
      delegate?.logOutAction()
    }
  }
  
  /// 更新个人信息 
  func updateProfie() {
    if UserDefaultsTool.sign != "" {
      signLabel.text = UserDefaultsTool.sign
    }
    
    if UserDefaultsTool.userName != "" {
      nameLabel.text = UserDefaultsTool.userName
    }
    
    if UserDefaultsTool.sex == 0 {
      sexImageView.image = UIImage(named: "sex_m")
    } else {
      sexImageView.image = UIImage(named: "sex_w")
    }
    
    if UserDefaultsTool.birthday != "" {
      birthdayLabel.text = UserDefaultsTool.birthday
    }
    
    if UserDefaultsTool.email != "" {
      mailLabel.text = UserDefaultsTool.email
    }
  }
}
