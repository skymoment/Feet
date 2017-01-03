//
//  ViewController.swift
//  Feet
//
//  Created by 王振宇 on 5/29/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import UIKit
import MJRefresh

class ViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  var feetModels = [FeetModel]()
  
  //
  var currentPage = 1
  
  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view, typically from a nib.
    title = "Feet"
    view.backgroundColor = UIColor.whiteColor()
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 300
    tableView.backgroundColor = UIColor.clearColor()
    tableView.separatorStyle = .None
    
    // header
    tableView.mj_header = MJRefreshStateHeader {
      self.loadData()
    }
    
    // footer
    tableView.mj_footer = MJRefreshBackStateFooter {
      self.loadData(self.currentPage)
    }
    
    tableView.mj_header.beginRefreshing()
    
    // WARNING: - need to fixed
    view.insertSubview(BackView(), belowSubview: tableView)
    (tabBarController as! TabBarController).removeGestrue()

    setNaviItem()
//    zhugeTrack()
  }
  
  override func viewWillAppear(animated: Bool) {
    navigationController?.setNavigationBarHidden(false, animated: false)
    super.viewWillAppear(animated)
    if UserDefaultsTool.isLogin() {
      (tabBarController as! TabBarController).addGestrue()
    }
    // TODO: ...
//    loadData()
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  // MARK: - setView
  func setNaviItem() {
    let imageView = UIImageView(image: UIImage(named: "send"))
    let gesture = UITapGestureRecognizer(target: self, action: #selector(rightBarAction))
    imageView.addGestureRecognizer(gesture)
    navigationItem.rightBarButtonItem = UIBarButtonItem(customView: imageView)
    
    let leftImageView = UIImageView(image: UIImage(named: "d_header"))
    leftImageView.frame = CGRect(x: 0, y: 0, width: 28, height: 28)
    let gestureLeft = UITapGestureRecognizer(target: self, action: #selector(leftBarAction))
    leftImageView.addGestureRecognizer(gestureLeft)
    navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftImageView)
  }
  
  // MARK: - Methods
  func zhugeTrack() {
    let track = "用户浏览"
    let trackInfo = ["浏览数量":"230"]
    ZhuGeio.RecordUserTrack(track, trackInfo: trackInfo)
  }
  
  func rightBarAction() {
    debugPrint("rightBar")
    LoginService.logIn(self) { 
      self.navigationController!.pushViewController(PostViewController(), animated: true)
    }
  }
  
  func leftBarAction() {
    debugPrint("leftBar")
    LoginService.logIn(self) {
      self.tabBarController?.selectedIndex = 0
    }
  }
  
  
  // 默认 10 条
  func loadData(page: Int = 1) {
    let params = [
      "pageNumber": "\(page)"
    ]
    
    HomeNetworkTool.getFeet(params) { promiseModels in
      do {
        let _ = try promiseModels.then({ feetModels in
          if feetModels.pageNumber == 1 {
            self.feetModels.removeAll()
          }
          
          self.tableView.mj_footer.hidden = feetModels.lastPage
          self.feetModels.appendContentsOf(feetModels.feets)
          self.currentPage = feetModels.pageNumber
          self.tableView.reloadData()
          self.endRefresh()
        }).resolve()
      } catch where error is MyError{
        HUD.showError(status: "\(error)")
        self.endRefresh()
        debugPrint("\(error)")
      } catch{
        self.endRefresh()
        HUD.showError(status: "网络错误")
      }
    }
  }
  
  func endRefresh() {
    tableView.mj_header.endRefreshing()
    tableView.mj_footer.endRefreshing()
  }
}

//MARK: - UITableViewDelegate,UITableViewDataSource
extension ViewController: UITableViewDelegate,UITableViewDataSource {
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return feetModels.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
  
    let cell = tableView.dequeueReusableCellWithIdentifier("feetCell") as! FeetCell
    cell.refresh(feetModels[indexPath.row])
    return cell
  }
  
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let vc = DetailViewController(id: "\(feetModels[indexPath.row].id)")
    navigationController?.pushViewController(vc, animated: true)
  }
}

