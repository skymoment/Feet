//
//  TabBarVCDelegate.swift
//  Feet
//
//  Created by 王振宇 on 6/2/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import UIKit

class TabBarVCDelegate: NSObject, UITabBarControllerDelegate {
  
  var interactive = false
  let interactionController = UIPercentDrivenInteractiveTransition()
  
  func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning?{
    let fromIndex = tabBarController.viewControllers!.index(of: fromVC)!
    let toIndex = tabBarController.viewControllers!.index(of: toVC)!
    
    let tabChangeDirection: TabOperationDirection = toIndex < fromIndex ? .left : .right
    let transitionType = SDETransitionType.tabTransition(tabChangeDirection)
    let slideAnimationController = SlideAnimationController(type: transitionType)
    return slideAnimationController
  }
  
  func tabBarController(_ tabBarController: UITabBarController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
    return interactive ? interactionController : nil
  }
}
