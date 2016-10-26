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
  
  func tabBarController(tabBarController: UITabBarController, animationControllerForTransitionFromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning?{
    let fromIndex = tabBarController.viewControllers!.indexOf(fromVC)!
    let toIndex = tabBarController.viewControllers!.indexOf(toVC)!
    
    let tabChangeDirection: TabOperationDirection = toIndex < fromIndex ? .Left : .Right
    let transitionType = SDETransitionType.TabTransition(tabChangeDirection)
    let slideAnimationController = SlideAnimationController(type: transitionType)
    return slideAnimationController
  }
  
  func tabBarController(tabBarController: UITabBarController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
    return interactive ? interactionController : nil
  }
}
