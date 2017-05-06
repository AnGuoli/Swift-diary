//
//  Common.swift
//  爆侃网文
//
//  Created by 金亮齐 on 2017/3/31.
//  Copyright © 2017年 醉看红尘这场梦. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SnapKit
import SVProgressHUD


/**
 是否是夜间模式
 
 - returns: true 是夜间模式
 */
func isNight() -> Bool {
    return NSUserDefaults.standardUserDefaults().boolForKey(NIGHT_KEY)
}

/// 保存夜间模式的状态的key
let NIGHT_KEY = "night"

/// appStore中的应用id
let APPLE_ID = "1115587250"

/// 导航栏背景颜色 - （红色）
let NAVIGATIONBAR_RED_COLOR = UIColor(red:0.831,  green:0.239,  blue:0.243, alpha:1)

/// 导航栏背景颜色 - (白色)
let NAVIGATIONBAR_WHITE_COLOR = UIColor.colorWithRGB(244, g: 244, b: 244)

/// 控制器背景颜色
let BACKGROUND_COLOR = UIColor(red:0.933,  green:0.933,  blue:0.933, alpha:1)

/// 全局边距
let MARGIN: CGFloat = 12

/// 全局圆角
let CORNER_RADIUS: CGFloat = 5

/// 屏幕宽度
let SCREEN_WIDTH = UIScreen.mainScreen().bounds.width

/// 屏幕高度
let SCREEN_HEIGHT = UIScreen.mainScreen().bounds.height

/// 屏幕bounds
let SCREEN_BOUNDS = UIScreen.mainScreen().bounds

/// 全局遮罩透明度
let GLOBAL_SHADOW_ALPHA: CGFloat = 0.6

/// shareSDK
let SHARESDK_APP_KEY = "132016f2c3a12"
let SHARESDK_APP_SECRET = "3c94e6038eff8073d82b426d52288ca7"

/// 微信
let WX_APP_ID = "wx2e1f6f0887148b6c"
let WX_APP_SECRET = "7ad13c3c6dae53e1584c205bf32146f9"

/// QQ
let QQ_APP_ID = "1105411292"
let QQ_APP_KEY = "WfKZYbDH68l7s9AU"

/// 微博
let WB_APP_KEY = "2664017296"
let WB_APP_SECRET = "6c5b97909709e89a72c0f949cc23f5f0"
let WB_REDIRECT_URL = "https://blog.6ag.cn"

/// 极光推送
let JPUSH_APP_KEY = "8e0c2d457d44144fd2a6dc52"
let JPUSH_MASTER_SECRET = "a33a60f6935a625c251e33d0"
let JPUSH_CHANNEL = "Publish channel"
let JPUSH_IS_PRODUCTION = true

/// 检查是否登录的key 用户保存登录状态到偏好设置
let IS_LOGIN = "isLogin"

/// 保存正文字体大小的key
let CONTENT_FONT_SIZE = "contentFontSize"

