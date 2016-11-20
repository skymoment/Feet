//
//  DetailViewController.swift
//  Feet
//
//  Created by 王振宇 on 7/31/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  
  var tableView: UITableView!
  var tableViewHeader: FeetDetailHeader!
  weak var commentView: CommentView!
  
  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setViews()
    // Do any additional setup after loading the view.
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    (tabBarController as! TabBarController).removeGestrue()
    
    //
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillShow), name: UIKeyboardWillShowNotification, object: nil)
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillHidden), name: UIKeyboardWillHideNotification, object: nil)
    (tabBarController as! TabBarController).removeGestrue()
  }
  
  override func viewDidDisappear(animated: Bool) {
    super.viewDidDisappear(animated)
    NSNotificationCenter.defaultCenter().removeObserver(self)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - SetViews
  func setViews() {
    view.backgroundColor = UIColor.whiteColor()
    
    tableViewHeader = {
      let t = FeetDetailHeader(frame: CGRect(x: 0, y: 0, width: view.width, height: 10))
      return t
    }()
    
    tableView = {
      let t = UITableView()
      t.tableHeaderView = tableViewHeader
      t.backgroundColor = UIColor.clearColor()
      t.delegate = self
      t.dataSource = self
      t.rowHeight = UITableViewAutomaticDimension
      t.estimatedRowHeight = 100
  
      view.addSubview(t)
      t.snp_makeConstraints(closure: { (make) in
        make.left.right.bottom.equalTo(view)
        make.top.equalTo(view).offset(64)
        make.bottom.equalTo(view).offset(-50)
      })
      return t
    }()
    
    // WARNING: - need to fixed
    view.insertSubview(BackView(), belowSubview: tableView)
    
    commentView = {
      let commentView = CommentView()
      view.addSubview(commentView)
      commentView.snp_makeConstraints { (make) in
        make.bottom.equalTo(view.snp_bottom).priorityMedium()
        make.left.right.equalTo(view)
        make.height.equalTo(50)
      }
      return commentView
    }()
  }
  
  
  // MARK: - Keyborad Notification Method
  func keyboardWillShow(notification: NSNotification) {
    let rect = notification.userInfo![UIKeyboardFrameEndUserInfoKey]!.CGRectValue
    let time = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! NSTimeInterval
    let height = rect.height
    
    commentView.snp_updateConstraints { (make) in
      make.bottom.equalTo(view.snp_bottom).offset(-height)
    }
    
    view.setNeedsUpdateConstraints()
    UIView.animateWithDuration(time) {
      self.commentView.hight()
      self.view.layoutIfNeeded()
    }
  }
  
  func keyboardWillHidden(notification: NSNotification) {
    commentView.snp_updateConstraints { (make) in
      make.bottom.equalTo(view.snp_bottom)
    }
    view.setNeedsUpdateConstraints()
    UIView.animateWithDuration(0.3) {
      self.commentView.normal()
      self.view.layoutIfNeeded()
    }
  }
}

extension DetailViewController: UITableViewDelegate,UITableViewDataSource {
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = CommentCell(style: .Default, reuseIdentifier: CommentCell.identifier())
    cell.commentLabel.delegate = self
    return cell
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    debugPrint(indexPath.row)
  }
  
  func scrollViewWillBeginDragging(scrollView: UIScrollView) {
    view.endEditing(true)
  }
}

extension DetailViewController: CommentDelegate {
  func commentNameselected(name: String) {
    debugPrint(name)
  }
  
  func commentOtherNameSelected(otherName: String) {
    debugPrint(otherName)
  }
  
  func commentContentSelected(name: String) {
    debugPrint(name)
  }
}
