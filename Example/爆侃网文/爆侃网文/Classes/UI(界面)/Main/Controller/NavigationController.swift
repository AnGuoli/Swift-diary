//
//  NavigationController.swift
//  爆侃网文
//
//  Created by 金亮齐 on 2017/3/31.
//  Copyright © 2017年 醉看红尘这场梦. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController,UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navBar = navigationBar
        navBar.barTintColor = NAVIGATIONBAR_WHITE_COLOR
        navBar.translucent = false
        navBar.barStyle = UIBarStyle.Black
        navBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        navBar.shadowImage = UIImage()
        navBar.titleTextAttributes = [
            NSForegroundColorAttributeName : UIColor(red:0.173,  green:0.173,  blue:0.173, alpha:1),
            NSFontAttributeName : UIFont.systemFontOfSize(18)
        ]
        // 全屏返回手势
        panGestureBack()

    }

    /** 全屏返回手势 */
    func panGestureBack() -> Void {
        let target = interactivePopGestureRecognizer?.delegate
        let pan = UIPanGestureRecognizer(target: target, action: Selector("handleNavigationTransition:"))
        pan.delegate = self
        view.addGestureRecognizer(pan)
        interactivePopGestureRecognizer?.enabled = false
    }
    
    // MARK: - UIGestureRecognizerDelegate
    func gestureRecognizerShouldBegin(gesture: UIGestureRecognizer) -> Bool {
        if childViewControllers.count == 1 {
            return false
        } else {
            return true
        }
    }
    
    /**
     拦截push操作
     
     - parameter viewController: 即将压入栈的控制器
     - parameter animated:       是否动画
     */
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        } else {
            viewController.hidesBottomBarWhenPushed = false
        }
        
        super.pushViewController(viewController, animated: animated)
        
        // 压入栈后创建返回按钮
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "top_navigation_back")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal),
            style: UIBarButtonItemStyle.Done,
            target: self,
            action: #selector(back)
        )
    }
    
    /** 全局返回操作 */
    @objc private func back() {
        popViewControllerAnimated(true)
    }


}
