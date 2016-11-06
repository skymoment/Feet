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
  
  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
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
      t.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: 60))
      t.backgroundColor = UIColor.clearColor()
      t.delegate = self
      t.dataSource = self
      t.rowHeight = UITableViewAutomaticDimension
      t.estimatedRowHeight = 100
  
      view.addSubview(t)
      t.snp_makeConstraints(closure: { (make) in
        make.left.right.bottom.equalTo(view)
        make.top.equalTo(view).offset(64)
      })
      return t
    }()
    
    // WARNING: - need to fixed
    view.insertSubview(BackView(), belowSubview: tableView)
  }
}

extension DetailViewController: UITableViewDelegate,UITableViewDataSource {
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = CommentCell(style: .Default, reuseIdentifier: CommentCell.identifier())

    return cell
  }
}
