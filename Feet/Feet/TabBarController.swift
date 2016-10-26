//
//  TabBarController.swift
//  Feet
//
//  Created by 王振宇 on 6/1/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
  private var panGesture: UIPanGestureRecognizer = UIPanGestureRecognizer()
  private let tabBarVCDelegate = TabBarVCDelegate()
  private var subViewControllerCount: Int{
    let count = viewControllers != nil ? viewControllers!.count : 0
    return count
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.tabBar.tintColor = UIColor.greenColor()
    self.tabBar.hidden = true
    let feetVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ViewController") as! ViewController
    let navFeet = NavigationController(rootViewController: feetVC)
    
    let mineVC = MineViewController()
    let navMine = NavigationController(rootViewController: mineVC)
    addChildViewController(navMine)
    addChildViewController(navFeet)
    selectedIndex = 1
    
    addGestrue()
    delegate = tabBarVCDelegate
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  func removeGestrue() {
    view.removeGestureRecognizer(panGesture)
  }
  
  func addGestrue() {
    panGesture.addTarget(self, action: #selector(TabBarController.handlePan(_:)))
    view.addGestureRecognizer(panGesture)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func handlePan(panGesture: UIPanGestureRecognizer){
    let translationX =  panGesture.translationInView(view).x
    let translationAbs = translationX > 0 ? translationX : -translationX
    let progress = translationAbs / view.frame.width
    switch panGesture.state{
    case .Began:
      tabBarVCDelegate.interactive = true
      let velocityX = panGesture.velocityInView(view).x
      if velocityX < 0{
        if selectedIndex < subViewControllerCount - 1{
          selectedIndex += 1
        }
      }else {
        if selectedIndex > 0{
          selectedIndex -= 1
        }
      }
    case .Changed:
      tabBarVCDelegate.interactionController.updateInteractiveTransition(progress)
    case .Cancelled, .Ended:
      /*这里有个小问题，转场结束或是取消时有很大几率出现动画不正常的问题。在8.1以上版本的模拟器中都有发现，7.x 由于缺乏条件尚未测试，
       但在我的 iOS 9.2 的真机设备上没有发现，而且似乎只在 UITabBarController 的交互转场中发现了这个问题。在 NavigationController 暂且没发现这个问题，
       Modal 转场尚未测试，因为我在 Demo 里没给它添加交互控制功能。
       
       测试不完整，具体原因也未知，不过解决手段找到了。多谢 @llwenDeng 发现这个 Bug 并且找到了解决手段。
       解决手段是修改交互控制器的 completionSpeed 为1以下的数值，这个属性用来控制动画速度，我猜测是内部实现在边界判断上有问题。
       这里其修改为0.99，既解决了 Bug 同时尽可能贴近原来的动画设定。
       */
      if progress > 0.3{
        tabBarVCDelegate.interactionController.completionSpeed = 0.99
        tabBarVCDelegate.interactionController.finishInteractiveTransition()
      }else{
        //转场取消后，UITabBarController 自动恢复了 selectedIndex 的值，不需要我们手动恢复。
        tabBarVCDelegate.interactionController.completionSpeed = 0.99
        tabBarVCDelegate.interactionController.cancelInteractiveTransition()
      }
      tabBarVCDelegate.interactive = false
    default: break
    }
  }

}
