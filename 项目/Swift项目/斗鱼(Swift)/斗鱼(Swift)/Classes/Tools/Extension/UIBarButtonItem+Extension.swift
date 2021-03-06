//
//  UIBarButtonItem+Extension.swift
//  斗鱼(Swift)
//
//  Created by 金亮齐 on 2017/5/31.
//  Copyright © 2017年 醉看红尘这场梦. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    /**
     推荐使用： 类方法创建UIBarButtonItem
     
     - parameter imageName:     图片名称
     - parameter highImageName: 高亮时的图片名称（默认为""）
     - parameter size:          按钮的尺寸（默认为"CGSizeZero"）
     
     - returns: UIBarButtonItem
     */
    // 便利构造函数: 1> convenience开头 2> 在构造函数中必须明确调用一个设计的构造函数(self)
    convenience init(imageName: String, highImageName: String = "", size: CGSize = CGSize.zero, target: Any,action: Selector)  {
        // 1.创建UIButton
        let btn = UIButton()
        
        // 2.设置btn的图片
        btn.setImage(UIImage(named: imageName), for: UIControlState())
        if highImageName != "" {
            btn.setImage(UIImage(named: highImageName), for: .highlighted)
        }
        
        // 3.设置btn的尺寸
        if size == CGSize.zero {
            btn.sizeToFit()
        } else {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        btn.addTarget(target, action: action, for: .touchUpInside)
        
        // 4.创建UIBarButtonItem
        self.init(customView : btn)
    }
    
    
    /**
     不推荐使用： 类方法创建UIBarButtonItem
     
     - parameter imageName:     图片名称
     - parameter highImageName: 高亮时的图片名称
     - parameter size:          按钮的尺寸
     
     - returns: UIBarButtonItem
     */
    class func createItem(_ imageName: String, highImageName: String = "", size: CGSize  = CGSize.zero) -> UIBarButtonItem {
        let btn = UIButton()
        
        btn.setImage(UIImage(named: imageName), for: UIControlState())
        btn.setImage(UIImage(named: highImageName), for: .highlighted)
        
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        btn.sizeToFit()
        
        return UIBarButtonItem(customView: btn)
    }
    
}

