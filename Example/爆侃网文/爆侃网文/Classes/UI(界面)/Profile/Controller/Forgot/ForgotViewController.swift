//
//  ForgotViewController.swift
//  爆侃网文
//
//  Created by 金亮齐 on 2017/4/5.
//  Copyright © 2017年 醉看红尘这场梦. All rights reserved.
//

import UIKit

class ForgotViewController: UIViewController {
    
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var usernameView: UIView!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var retrieveButton: LoginButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let effectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.Dark))
        effectView.frame = SCREEN_BOUNDS
        bgImageView.addSubview(effectView)
        
        didChangeTextField(usernameField)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @IBAction func didChangeTextField(sender: UITextField) {
        if usernameField.text?.characters.count > 5 && emailField.text?.characters.count > 5 {
            retrieveButton.enabled = true
            retrieveButton.backgroundColor = UIColor(red: 32/255.0, green: 170/255.0, blue: 238/255.0, alpha: 1)
        } else {
            retrieveButton.enabled = false
            retrieveButton.backgroundColor = UIColor.grayColor()
        }
    }
    
    @IBAction func didTappedBackButton() {
        view.endEditing(true)
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func didTappedRetrieveButton(sender: LoginButton) {
        
        view.endEditing(true)
        
        // 开始动画
        sender.startLoginAnimation()
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(3.0 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
            
            let parameters = [
                "username" : self.usernameField.text!,
                "action" : "SendPassword",
                "email" : self.emailField.text!
            ]
            
            // 发送登录请求
            NetworkTool.shareNetworkTool.post(MODIFY_ACCOUNT_INFO, parameters: parameters) { (success, result, error) in
                if result != nil {
                    if result!["data"]["info"].stringValue == "邮件已发送，请登录邮箱认证并取回密码" {
                        self.dismissViewControllerAnimated(true, completion: {})
                    }
                    ProgressHUD.showInfoWithStatus(result!["data"]["info"].stringValue)
                } else {
                    ProgressHUD.showInfoWithStatus("找回失败，请联系管理员！")
                }
                // 结束动画
                sender.endLoginAnimation()
            }
        }
        
    }
    
}
