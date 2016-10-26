//
//  ViewController.swift
//  Feet
//
//  Created by 王振宇 on 5/29/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  var feetModels:[FeetModel]!
  
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
    
    // WARNING: - need to fixed
    view.insertSubview(BackView(), belowSubview: tableView)
    
    setNaviItem()
//    zhugeTrack()
    
    loadData()
  }
  
  override func viewWillAppear(animated: Bool) {
    navigationController?.setNavigationBarHidden(false, animated: false)
    super.viewWillAppear(animated)
    (tabBarController as! TabBarController).addGestrue()
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
    
    
    let leftImageView = UIImageView(image: UIImage(named: "send"))
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
    navigationController!.pushViewController(PostViewController(), animated: true)
  }
  
  func leftBarAction() {
    debugPrint("leftBar")
    tabBarController?.selectedIndex = 0
  }
  
  
  // 默认 10 条
  func loadData() {
    let params = [
      "pageNumber": "1"
    ]
    
    HomeNetworkTool.post(params) { promiseModels in
      do {
        let _ = try promiseModels.then({models in
          self.feetModels = models
        }).resolve()
      } catch where error is MyError{
        debugPrint("\(error)")
      } catch{
        debugPrint("网络错误")
      }

    }
  }
}


extension ViewController: UITableViewDelegate,UITableViewDataSource {
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
  
    let cell = tableView.dequeueReusableCellWithIdentifier("feetCell") as! FeetCell
    
    return cell
  }
  
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let vc = DetailViewController()
    navigationController?.pushViewController(vc, animated: true)
  }
}

