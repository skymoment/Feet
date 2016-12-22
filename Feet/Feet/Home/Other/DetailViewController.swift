//
//  DetailViewController.swift
//  Feet
//
//  Created by 王振宇 on 7/31/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  var id = "0"
  var model: FeetDetailModel!
  var comments = [CommentInfo]()
  var tableView: UITableView!
  weak var commentView: CommentView!
  
  /// 键盘 + commentView 的高度
  var heightOfKB: CGFloat = 0
  
  // MARK: - LifeCycle
  convenience init(id: String) {
    self.init()
    self.id = id
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setViews()
    loadData()
    // Do any additional setup after loading the view.
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    (tabBarController as! TabBarController).removeGestrue()
    

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
    
    tableView = {
      let t = UITableView()
      t.backgroundColor = UIColor.clearColor()
      t.delegate = self
      t.dataSource = self
      t.separatorStyle = .None
      t.rowHeight = UITableViewAutomaticDimension
      t.estimatedRowHeight = 100
  
      view.addSubview(t)
      t.snp_makeConstraints(closure: { (make) in
        make.left.right.equalTo(view)
        make.top.equalTo(view).offset(64)
        make.bottom.equalTo(view.snp_bottom).offset(-50)
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
  
  // MAKR: - LoadData
  func loadData() {
    HomeNetworkTool.getFeetDetail(["id": id]) { (promisModel) in
      do {
        let _ = try promisModel.then({ model in
          self.model = model
          self.comments = model.commentInfo
          self.commentView.feetUserId = model.feetInfo.userId
          self.tableView.tableHeaderView = FeetDetailHeader(model: self.model)
          self.tableView.reloadData()
        }).resolve()
      } catch where error is MyError {
        debugPrint("\(error)")
      } catch {
        debugPrint("网络错误")
      }
    }
  }
  
  // MARK: - Keyborad Notification Method
  func keyboardWillShow(notification: NSNotification) {
    let rect = notification.userInfo![UIKeyboardFrameEndUserInfoKey]!.CGRectValue
    let time = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! NSTimeInterval
    let height = rect.height
    heightOfKB = height + 50
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
    heightOfKB = 0
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


// MARK: - UITableViewDelegate,UITableViewDataSource
extension DetailViewController: UITableViewDelegate,UITableViewDataSource {
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let model = model {
      return model.commentInfo.count
    } else {
      return 0
    }
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = CommentCell(style: .Default, reuseIdentifier: CommentCell.identifier())
    cell.commentLabel.delegate = self
    cell.refresh(model.commentInfo[indexPath.row])
    return cell
  }
  
  func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 0.1
  }
  
  func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 0.1
  }
  
  func scrollViewWillBeginDragging(scrollView: UIScrollView) {
    view.endEditing(true)
  }
}


// MARK: - CommentDelegate
extension DetailViewController: CommentDelegate {
  func commentNameselected(name: CommentInfo, y: Int) {
    debugPrint(name)
    commentView.loadData("\(name.userId)", feetId: "\(name.feetId)")
    commentView.borderText.textField.becomeFirstResponder()
    let text = "回复\(name.nickname):"
    commentView.borderText.text = text
    tableContentOffset(y)
  }
  
  func commentOtherNameSelected(otherName: CommentInfo, y: Int) {
    debugPrint(otherName)
    commentView.loadData("\(otherName.replyUserId)", feetId: "\(otherName.feetId)")
    commentView.borderText.textField.becomeFirstResponder()
    let text = "回复\(otherName.replyUserName):"
    commentView.borderText.text = text
    tableContentOffset(y)
  }
  
  func commentContentSelected(name: CommentInfo, y: Int) {
    debugPrint(name)
    commentView.loadData("\(name.userId)", feetId: "\(name.feetId)")
    commentView.borderText.textField.becomeFirstResponder()
    let text = "回复\(name.replyUserName):"
    commentView.borderText.text = text
    tableContentOffset(y)
  }
  
  func tableContentOffset(y: Int) {
    let offsetY = CGFloat(y) - (KScreenHeigth - heightOfKB)
    if offsetY > 0 {
      let contentY = tableView.contentOffset.y
      tableView.setContentOffset(CGPoint(x: 0, y: contentY + offsetY), animated: true)
    }
  }
}
