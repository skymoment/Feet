//
//  MineViewController.swift
//  Feet
//
//  Created by 王振宇 on 6/26/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import UIKit
import MJRefresh

class MineViewController: UIViewController {
  
  weak var avatarView: UIImageView!
  weak var nameLabel: UILabel!
  weak var sexImageView: UIImageView!
  weak var tableView: UITableView!
  var feetModels = [FeetModel]()
  var currentPage = 1
  
  let tabelHeader = MineTableHeader(frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: 40))
  
  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.navigationBar.isHidden = true
    // Do any additional setup after loading the view.
    
    setViews()
    
    // footer
    tableView.mj_footer = MJRefreshBackStateFooter {
      self.loadData(self.currentPage)
    }
    loadData()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    (tabBarController as! TabBarController).addGestrue()

    navigationController?.setNavigationBarHidden(true, animated: false)
    if let imageData = UserDefaultsTool.headerData {
      avatarView.image = UIImage(data: imageData as Data)
    }
    
    if UserDefaultsTool.userName != "" {
      nameLabel.text = UserDefaultsTool.userName
    }
    
    if UserDefaultsTool.sex == 0 {
      sexImageView.image = UIImage(named: "sex_m")
    } else {
      sexImageView.image = UIImage(named: "sex_w")
    }
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.setNavigationBarHidden(false, animated: false)
    
  }

  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  // MARK: - SetViews
  func setViews() {
    view.insertSubview(BackView(), at: 0)

    avatarView = {
      let a = UIImageView(image: UIImage(named: "d_header3"))
      a.isUserInteractionEnabled = true
      a.layer.cornerRadius = 48
      a.layer.masksToBounds = true
      let tapGesture = UITapGestureRecognizer(target: self, action: #selector(avatarTaped))
      a.addGestureRecognizer(tapGesture)
      view.addSubview(a)
      
      a.snp.makeConstraints({ (make) in
        make.top.equalTo(30)
        make.width.height.equalTo(96)
        make.centerX.equalTo(view)
      })
      return a
    }()
    
    nameLabel = {
      let l = UILabel()
      l.text = "Your Name"
      l.font = UIFont.systemFont(ofSize: 16)
      l.textColor = UIColor.white
      view.addSubview(l)
      
      l.snp.makeConstraints({ (make) in
        make.top.equalTo(avatarView.snp.bottom).offset(6)
        make.centerX.equalTo(avatarView)
      })
      return l
    }()
    
    sexImageView = {
      let s = UIImageView(image: UIImage(named: "m_woman"))
      view.addSubview(s)
      s.snp.makeConstraints({ (make) in
        make.top.equalTo(nameLabel.snp.bottom).offset(6)
        make.centerX.equalTo(nameLabel)
        make.width.height.equalTo(18)
      })
      return s
    }()
    
    tableView = {
      let t = UITableView(frame: CGRect.zero, style: .plain)
      t.backgroundColor = UIColor(hexString: "#000000", alpha: 0.2)

      t.delegate = self
      t.dataSource = self
      t.separatorStyle = .none
  
      view.addSubview(t)
      t.snp.makeConstraints({ (make) in
        make.top.equalTo(sexImageView.snp.bottom).offset(15)
        make.left.right.bottom.equalTo(view)
      })
      return t
    }()
  }
  
  // MARK: - LoadData
  func loadData(_ page: Int = 1) {
    let params = [
      "pageNumber": "\(page)",
      "type": "1"
      ]
    HUD.show()
    HomeNetworkTool.getFeet(params) { promiseModels in
      do {
        let _ = try promiseModels.then({feetModels in
          if feetModels.pageNumber == 1 {
            self.feetModels.removeAll()
          }
          HUD.dismiss()
          self.tableView.mj_footer.isHidden = feetModels.lastPage
          self.feetModels.append(contentsOf: feetModels.feets)
          self.currentPage = feetModels.pageNumber + 1
          self.tableView.reloadData()
          self.endRefresh()
        }).resolve()
      } catch where error is MyError{
        HUD.showError("\(error)")
        self.endRefresh()
      } catch{
        self.endRefresh()
        HUD.showError("网络错误")
      }
    }
  }
  
  func endRefresh() {
    tableView.mj_footer.endRefreshing()
  }
  
  // Actions
  func avatarTaped() {
    let vc = ProfileViewController()
    LoginService.logIn(self) {
      self.navigationController!.pushViewController(vc, animated: true)
    }
  }
}


// MAKR: - UITableViewDelegate,UITableViewDataSource
extension MineViewController: UITableViewDelegate,UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return feetModels.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = MineCell(vLine: tabelHeader.vline(),style: .default, reuseIdentifier: MineCell.identifier())
    cell.refresh(feetModels[indexPath.row])
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let id = feetModels[indexPath.row].id
    let vc = DetailViewController(id: "\(id)", type: .minelist)
    navigationController?.pushViewController(vc, animated: true)
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 150
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    return tabelHeader
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 40
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if scrollView.contentOffset.y <= -100 {
      loadData()
    }
  }
}
