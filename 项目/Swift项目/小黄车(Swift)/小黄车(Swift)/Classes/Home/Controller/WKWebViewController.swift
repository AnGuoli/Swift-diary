//
//  WKWebViewController.swift
//  小黄车(Swift)
//
//  Created by 金亮齐 on 2017/6/6.
//  Copyright © 2017年 醉看红尘这场梦. All rights reserved.
//

import UIKit
import WebKit

class WKWebViewController: UIViewController {
    // MARK: - lazy
    fileprivate lazy var webView: WKWebView = { [unowned self] in
        // 创建webveiew
        let webView = WKWebView(frame: self.view.bounds)
        webView.navigationDelegate = self
        webView.uiDelegate = self
        return webView
        }()
    fileprivate lazy var progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .bar)
        progressView.frame.size.width = self.view.frame.size.width
        // 这里可以改进度条颜色
        progressView.tintColor = UIColor.green
        return progressView
    }()
    
    // MARK: - 生命周期
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        view.addSubview(webView)
        view.insertSubview(progressView, aboveSubview: webView)
    }
    convenience init(navigationTitle: String, urlStr: String) {
        self.init(nibName: nil, bundle: nil)
        navigationItem.title = navigationTitle
        webView.load(URLRequest(url: URL(string: urlStr)!))
    }
    convenience init(navigationTitle: String, url: URL) {
        self.init(nibName: nil, bundle: nil)
        navigationItem.title = navigationTitle
        webView.load(URLRequest(url:  url))
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.edgesForExtendedLayout = UIRectEdge()
        
        webView.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: navHeight-1, right: 0)
        webView.addObserver(self, forKeyPath: "loading", options: .new, context: nil)
        webView.addObserver(self, forKeyPath: "title", options: .new, context: nil)
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "loading" {
            self.showHudInViewWithMode(view: self.webView, hint: "正在加载", mode: .indeterminate, imageName: nil)
        } else if keyPath == "title" {
            //            title = self.webView.title
        } else if keyPath == "estimatedProgress" {
            print(webView.estimatedProgress)
            progressView.setProgress(Float(webView.estimatedProgress), animated: false)
        }
        self.progressView.isHidden = (self.progressView.progress == 1)
        if self.progressView.progress == 1 {
            self.hideHud()
        }
        
        if webView.isLoading == true {
            // 手动调用JS代码
            let js = "callJsAlert()"
            webView.evaluateJavaScript(js, completionHandler: { (any, err) in
                debugPrint(any)
            })
        }
    }
    
    // 移除观察者
    deinit {
        webView.removeObserver(self, forKeyPath: "loading")
        webView.removeObserver(self, forKeyPath: "title")
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - HTTPS
extension WKWebViewController {
    func connection(connection: NSURLConnection, canAuthenticateAgainstProtectionSpace protectionSpace: URLProtectionSpace) -> Bool {
        return (protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust)
    }
    
    func connection(connection: NSURLConnection, didReceiveAuthenticationChallenge challenge: URLAuthenticationChallenge) {
        if (challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust) {
            challenge.sender!.use(URLCredential(trust: challenge.protectionSpace.serverTrust!), for: challenge)
            challenge.sender!.continueWithoutCredential(for: challenge)
        }
    }
}

// MARK: - WKScriptMessageHandler
extension WKWebViewController: WKScriptMessageHandler {
    // WKScriptMessageHandler：必须实现的函数，是APP与js交互，提供从网页中收消息的回调方法
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print(message.body)
        print(message.webView)
    }
}

// MARK: - WKNavigationDelegate
extension WKWebViewController: WKNavigationDelegate {
    // 决定导航的动作，通常用于处理跨域的链接能否导航。WebKit对跨域进行了安全检查限制，不允许跨域，因此我们要对不能跨域的链接
    // 单独处理。但是，对于Safari是允许跨域的，不用这么处理。
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let hostname = (navigationAction.request as NSURLRequest).url?.host?.lowercased()
        
        print(hostname)
        print(navigationAction.navigationType)
        // 处理跨域问题
        if navigationAction.navigationType == .linkActivated && hostname!.contains(".baidu.com") {
            // 手动跳转
            UIApplication.shared.openURL(navigationAction.request.url!)
            
            // 不允许导航
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print(#function)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        print(#function)
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        print(#function)
        completionHandler(.performDefaultHandling, nil)
    }
    
}

// MARK: - WKUIDelegate
extension WKWebViewController: WKUIDelegate {
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: "tip", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: { (_) -> Void in
            // We must call back js
            completionHandler()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        completionHandler(true)
    }
    
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        completionHandler("woqu")
    }
    
    func webViewDidClose(_ webView: WKWebView) {
        print("close")
    }
}
