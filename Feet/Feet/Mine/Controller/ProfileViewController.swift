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
}

// MARK: - 
extension ProfileViewController: ProfileDelegate {
  func pushToInfoView(type: InfoViews) {
    let vc = SetUserInfoViewController(type: type)
    navigationController?.pushViewController(vc, animated: true)
  }
  
  func logOutAction() {
    UserDefaultsTool.cleanUserInfo()
    navigationController?.popViewControllerAnimated(true)
  }
}
