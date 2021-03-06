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
  var headerView: UIImageView!
  var currentPage = 1
  
  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view, typically from a nib.
    title = "Feet"
    view.backgroundColor = UIColor.white
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 300
    tableView.backgroundColor = UIColor.clear
    tableView.separatorStyle = .none
    
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
  
  override func viewWillAppear(_ animated: Bool) {
    navigationController?.setNavigationBarHidden(false, animated: false)
    super.viewWillAppear(animated)
    if UserDefaultsTool.isLogin() {
      (tabBarController as! TabBarController).addGestrue()
    }
    
    if let imageData = UserDefaultsTool.headerData {
      headerView.image = UIImage(data: imageData as Data)
    }
  }
  
  override func viewWillDisappear(_ animated: Bool) {
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
    leftImageView.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
    leftImageView.layer.cornerRadius = 17
    leftImageView.layer.borderWidth = 1
    leftImageView.layer.borderColor = UIColor.white.cgColor
    leftImageView.layer.masksToBounds = true
    let gestureLeft = UITapGestureRecognizer(target: self, action: #selector(leftBarAction))
    leftImageView.addGestureRecognizer(gestureLeft)
    headerView = leftImageView
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
  func loadData(_ page: Int = 1) {
    let params = [
      "pageNumber": "\(page)"
    ]
    
    HomeNetworkTool.getFeet(params) { promiseModels in
      do {
        let _ = try promiseModels.then({ feetModels in
          if feetModels.pageNumber == 1 {
            self.feetModels.removeAll()
          }
          self.tableView.mj_footer.isHidden = feetModels.lastPage
          self.feetModels.append(contentsOf: feetModels.feets)
          self.currentPage = feetModels.pageNumber + 1
          self.tableView.reloadData()
          self.endRefresh()
        }).resolve()
      } catch where error is MyError{
        HUD.showError("\(error)")
        self.endRefresh()
        debugPrint("\(error)")
      } catch{
        self.endRefresh()
        HUD.showError("网络错误")
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
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return feetModels.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  
    let cell = tableView.dequeueReusableCell(withIdentifier: "feetCell") as! FeetCell
    cell.refresh(feetModels[indexPath.row])
    return cell
  }
  
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let vc = DetailViewController(id: "\(feetModels[indexPath.row].id)")
    navigationController?.pushViewController(vc, animated: true)
  }
}

