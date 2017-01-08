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
    view.backgroundColor = UIColor.whiteColor()
    setViews()
    // Do any additional setup after loading the view.
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    (tabBarController as! TabBarController).removeGestrue()
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
      p.snp_makeConstraints { (make) in
        make.left.right.top.bottom.equalTo(0)
      }
      return p
    }()
  }
  
  // MARK: - Method
  func avatarUpLoad(path: String) {
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
  func pushToInfoView(type: InfoViews) {
    let vc = SetUserInfoViewController(type: type)
    navigationController?.pushViewController(vc, animated: true)
  }
  
  func logOutAction() {
    UserDefaultsTool.cleanUserInfo()
    tabBarController?.selectedIndex = 1
    navigationController?.popViewControllerAnimated(true)
  }
  
  func changeAvatar(view: UIImageView) {
    avatar = view
    self.imagePicker = ImagePicker(viewController: self)
    self.imagePicker.delegate = self
  }
}

// MARK: - ImagePickerDelegate
extension ProfileViewController: ImagePickerDelegate {
  func imagePickerDidFinishPickingImage(image: UIImage) {
    let folderPath = cacheFolderPath + "/imageCaches"
    let imagePath = folderPath + "/header.jpg"
    
    let data = UIImageJPEGRepresentation(image, 0.5)
    debugPrint("imageDataSize: === \((data?.length)!/1024)")
    do {
      try NSFileManager.defaultManager().createDirectoryAtPath(folderPath, withIntermediateDirectories: true, attributes: nil)
      data?.writeToFile(imagePath, atomically: true)
    } catch _ {}
    
//    avatar.image = image.imageWithSize(CGSize(width: 160, height: 160))
    avatarUpLoad(imagePath)
  }
}
