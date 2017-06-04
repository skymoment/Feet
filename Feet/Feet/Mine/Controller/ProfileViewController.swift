//
//  ProfileViewController.swift
//  Feet
//
//  Created by 王振宇 on 7/31/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
  
  var profileView: ProfileView!
  var imagePicker: ImagePicker!
  var avatar: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.white
    setViews()
    // Do any additional setup after loading the view.
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    (tabBarController as! TabBarController).removeGestrue()
    profileView.updateProfie()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func setViews() {
    profileView = {
      let p = ProfileView()
      p.delegate = self
      view.addSubview(p)
      p.snp.makeConstraints { (make) in
        make.left.right.top.bottom.equalTo(0)
      }
      return p
    }()
  }
  
  // MARK: - Method
  func avatarUpLoad(_ path: String) {
    HUD.show()
    PostNetTool.qiuNiuToken { 
      QiniuTool.upLoadImage(path) { (img) in
        UserNetworkTool.userInfo(["image": QNHeader + img], completion: { promiseString in
          do {
            let _ = try promiseString.then({model in
              debugPrint("上传结果 ===== \(model.image)")
              ApiClient.downLoadImage(model.image, compeletion: { (data, cookieString) in
                if let data = data {
                  UserDefaultsTool.headerData = data
                  self.avatar.image = UIImage(data: data)
                  HUD.showSuccess("上传成功")
                }
              })
            }).resolve()
          } catch where error is MyError{
            debugPrint("\(error)")
          } catch{
            debugPrint("网络错误")
          }
        })
      }
    }
  }
}

// MARK: -  ProfileDelegate
extension ProfileViewController: ProfileDelegate {
  func pushToInfoView(_ type: InfoViews) {
    let vc = SetUserInfoViewController(type: type)
    navigationController?.pushViewController(vc, animated: true)
  }
  
  func logOutAction() {
    HUD.show()
    LoginNetTool.logOut { promiseString in
      do {
        HUD.dismiss()
        let _ = try promiseString.then({ string in
          UserDefaultsTool.cleanUserInfo()
          self.tabBarController?.selectedIndex = 1
          self.navigationController?.popViewController(animated: true)
        }).resolve()
      } catch where error is MyError {
        HUD.showError("\(error)")
      } catch {
        HUD.showError("\(error)")
      }
    }
  }
  
  func changeAvatar(_ view: UIImageView) {
    avatar = view
    self.imagePicker = ImagePicker(viewController: self)
    self.imagePicker.delegate = self
  }
}

// MARK: - ImagePickerDelegate
extension ProfileViewController: ImagePickerDelegate {
  func imagePickerDidFinishPickingImage(_ image: UIImage) {
    let folderPath = cacheFolderPath + "/imageCaches"
    let imagePath = folderPath + "/header.jpg"
    
    let data = UIImageJPEGRepresentation(image, 0.5)
    debugPrint("imageDataSize: === \((data?.count)!/1024)")
    do {
      try FileManager.default.createDirectory(atPath: folderPath, withIntermediateDirectories: true, attributes: nil)
      try? data?.write(to: URL(fileURLWithPath: imagePath), options: [.atomic])
    } catch _ {}
    
//    avatar.image = image.imageWithSize(CGSize(width: 160, height: 160))
    avatarUpLoad(imagePath)
  }
}
