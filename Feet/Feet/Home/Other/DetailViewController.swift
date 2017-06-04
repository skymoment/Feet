//
//  DetailViewController.swift
//  Feet
//
//  Created by 王振宇 on 7/31/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import UIKit

enum  FeetDetail {
  case feetlist
  case minelist
}


class DetailViewController: UIViewController {
  
  var id = "0"
  var type: FeetDetail = .feetlist
  var model: FeetDetailModel!
  var comments = [CommentInfo]()
  var tableView: UITableView!
  weak var commentView: CommentView!
  
  /// 键盘 + commentView 的高度
  var heightOfKB: CGFloat = 0
  
  // MARK: - LifeCycle
  convenience init(id: String, type: FeetDetail = .feetlist) {
    self.init()
    self.id = id
    self.type = type
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setViews()
    loadData()
    // Do any additional setup after loading the view.
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHidden), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    (tabBarController as! TabBarController).removeGestrue()
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    NotificationCenter.default.removeObserver(self)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - SetViews
  func setViews() {
    view.backgroundColor = UIColor.white
    
    tableView = {
      let t = UITableView()
      t.backgroundColor = UIColor.clear
      t.delegate = self
      t.dataSource = self
      t.separatorStyle = .none
      t.rowHeight = UITableViewAutomaticDimension
      t.estimatedRowHeight = 100
      
      let bottom = type == .feetlist ? -50 : 0
      view.addSubview(t)
      t.snp.makeConstraints({ (make) in
        make.left.right.equalTo(view)
        make.top.equalTo(view).offset(64)
        make.bottom.equalTo(view.snp.bottom).offset(bottom)
      })
      return t
    }()
    
    // WARNING: - need to fixed
    view.insertSubview(BackView(), belowSubview: tableView)
    
    commentView = {
      let commentView = CommentView()
      commentView.delegate = self
      view.addSubview(commentView)
      commentView.snp.makeConstraints { (make) in
        make.bottom.equalTo(view.snp.bottom).priorityMedium()
        make.left.right.equalTo(view)
        make.height.equalTo(50)
      }
      if type == .minelist {
        commentView.isHidden = true
      }
      return commentView
    }()
  }
  
  // MAKR: - LoadData
  func loadData() {
    HUD.show()
    HomeNetworkTool.getFeetDetail(["id": id]) { (promisModel) in
      do {
        let _ = try promisModel.then({ model in
          self.model = model
          self.comments = model.commentInfo
          self.commentView.loadData("", feetId: "\(model.feetInfo.id)")
          self.tableView.tableHeaderView = FeetDetailHeader(model: self.model)
          self.tableView.reloadData()
          HUD.dismiss()
        }).resolve()
      } catch where error is MyError {
        debugPrint("\(error)")
        HUD.showError("\(error)")
      } catch {
        HUD.showError("网络错误")
      }
    }
  }
  
  // MARK: - Keyborad Notification Method
  func keyboardWillShow(_ notification: Notification) {
    let rect = (notification.userInfo![UIKeyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue
    let time = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
    let height = rect?.height
    heightOfKB = height! + 50
    commentView.snp.updateConstraints { (make) in
//      make.bottom.equalTo(view.snp.bottom).offset((-height)!)
    }
  
    view.setNeedsUpdateConstraints()
    UIView.animate(withDuration: time, animations: {
      self.commentView.hight()
      self.view.layoutIfNeeded()
    }) 
  }
  
  func keyboardWillHidden(_ notification: Notification) {
    heightOfKB = 0
    commentView.snp.updateConstraints { (make) in
      make.bottom.equalTo(view.snp.bottom)
    }
    view.setNeedsUpdateConstraints()
    UIView.animate(withDuration: 0.3, animations: {
      self.commentView.normal()
      self.view.layoutIfNeeded()
    }) 
  }
}


// MARK: - UITableViewDelegate,UITableViewDataSource
extension DetailViewController: UITableViewDelegate,UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let model = model {
      return model.commentInfo.count
    } else {
      return 0
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = CommentCell(style: .default, reuseIdentifier: CommentCell.identifier())
    if type == .feetlist {
      cell.commentLabel.delegate = self
    }
    cell.refresh(model.commentInfo[indexPath.row])
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 0.1
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 0.1
  }
  
  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    view.endEditing(true)
  }
}


// MARK: - CommentDelegate
extension DetailViewController: CommentDelegate {
  func commentNameselected(_ name: CommentInfo, y: Int) {
    debugPrint(name)
    commentView.loadData("\(name.userId)", feetId: "\(name.feetId)")
    commentView.borderText.textField.becomeFirstResponder()
    let text = "回复\(name.nickname):"
    commentView.borderText.text = text
    tableContentOffset(y)
  }
  
  func commentOtherNameSelected(_ otherName: CommentInfo, y: Int) {
    debugPrint(otherName)
    commentView.loadData("\(otherName.replyUserId)", feetId: "\(otherName.feetId)")
    commentView.borderText.textField.becomeFirstResponder()
    let text = "回复\(otherName.replyUserName):"
    commentView.borderText.text = text
    tableContentOffset(y)
  }
  
  func commentContentSelected(_ name: CommentInfo, y: Int) {
    debugPrint(name)
    commentView.loadData("\(name.replyUserId)", feetId: "\(name.feetId)")
    commentView.borderText.textField.becomeFirstResponder()
    let text = "回复\(name.nickname):"
    commentView.borderText.text = text
    tableContentOffset(y)
  }
  
  func tableContentOffset(_ y: Int) {
//    GCDTool.delay(0.4) {
      let offsetY = CGFloat(y) - (KScreenHeigth - self.heightOfKB)
      if offsetY > 0 {
        let contentY = self.tableView.contentOffset.y
        self.tableView.setContentOffset(CGPoint(x: 0, y: contentY + offsetY), animated: true)
      }
//    }
  }
}


// MARK: - CommentViewDelegate
extension DetailViewController: CommentViewDelegate {
  func commented() {
    loadData()
  }
}



