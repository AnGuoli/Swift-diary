//
//  NewsViewController.swift
//  爆侃网文
//
//  Created by 金亮齐 on 2017/3/31.
//  Copyright © 2017年 醉看红尘这场梦. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    
    /// 顶部标签按钮区域
    @IBOutlet weak var topScrollView: UIScrollView!
    /// 内容区域
    @IBOutlet weak var contentScrollView: UIScrollView!
    /// 标签按钮旁的加号按钮
    @IBOutlet weak var addButton: UIButton!
    
    
    var contentOffsetX: CGFloat = 0.0
    
    // 栏目数组
    private var selectedArray: [[String : String]]?
    private var optionalArray: [[String : String]]?

    override func viewDidLoad() {
        super.viewDidLoad()

        // 准备视图
        prepareUI()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(didReceiveRemoteNotificationOfJPush(_:)), name: "didReceiveRemoteNotificationOfJPush", object: nil)

    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    /** 处理接收到的远程通知，跳转到指定的文章 */
    func didReceiveRemoteNotificationOfJPush(notification: NSNotification) -> Void {
        
        if let userInfo = notification.object as? NSDictionary {
            guard let classid = userInfo["classid"], let id = userInfo["id"] else {return}
            let detailVc = NewsDetailViewController()
            detailVc.articleParam = (classid as! String,id as! String)
            navigationController?.pushViewController(detailVc, animated: true)
        }
        
    }
    // MARK: - 各种自定义方法
    /**
     准备视图
     */
    private func prepareUI() {
        
        // 移除原有数据
        for subView in topScrollView.subviews {
            if subView.isKindOfClass(TopLabel.classForCoder()) {
                subView.removeFromSuperview()
            }
        }
        for subView in contentScrollView.subviews {
            subView.removeFromSuperview()
        }
        for vc in childViewControllers {
            vc.removeFromParentViewController()
        }
        
        // 添加内容
        addContent()
    }
    
    /**
     编辑分类按钮点击
     */
    @IBAction func didTappedEditColumnButton(sender: UIButton) {
        sender.selected = !sender.selected
        
        if sender.selected {
            editColumnVc.selectedArray = selectedArray
            editColumnVc.optionalArray = optionalArray
            editColumnVc.view.frame = CGRect(x: 0, y: 60, width: SCREEN_WIDTH, height: 0)
            addChildViewController(editColumnVc)
            view.addSubview(editColumnVc.view)
            tabBarController?.tabBar.hidden = true
            
            // 切换控制器动画
            UIView.animateWithDuration(0.25, animations: {
                self.editColumnVc.view.frame = CGRect(x: 0, y: 60, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - 60)
                self.addButton.imageView!.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
            })
        } else {
            UIView.animateWithDuration(0.25, animations: {
                self.editColumnVc.view.frame = CGRect(x: 0, y: 60, width: SCREEN_WIDTH, height: 0)
                self.addButton.imageView!.transform = CGAffineTransformIdentity
                }, completion: { (_) in
                    self.selectedArray = self.editColumnVc.selectedArray
                    self.optionalArray = self.editColumnVc.optionalArray
                    NSUserDefaults.standardUserDefaults().setObject(self.selectedArray, forKey: "selectedArray")
                    NSUserDefaults.standardUserDefaults().setObject(self.optionalArray, forKey: "optionalArray")
                    self.editColumnVc.view.removeFromSuperview()
                    self.tabBarController?.tabBar.hidden = false
                    
                    self.prepareUI()
            })
        }
        
    }
    
    /**
     配置栏目
     */
    private func setupColumn() {
        let tempSelectedArray = NSUserDefaults.standardUserDefaults().objectForKey("selectedArray") as? [[String : String]]
        let tempOptionalArray = NSUserDefaults.standardUserDefaults().objectForKey("optionalArray") as? [[String : String]]
        
        if tempSelectedArray != nil || tempOptionalArray != nil {
            selectedArray = tempSelectedArray != nil ? tempSelectedArray : [[String : String]]()
            optionalArray = tempOptionalArray != nil ? tempOptionalArray : [[String : String]]()
        } else {
            selectedArray = [
                [
                    "classid" : "10000",
                    "classname" : "今日头条"
                ],
                [
                    "classid" : "2",
                    "classname": "网文快讯"
                ],
                [
                    "classid" : "21",
                    "classname": "媒体视角"
                ],
                [
                    "classid" : "12",
                    "classname": "网文IP"
                ],
                [
                    "classid" : "264",
                    "classname": "企业资讯"
                ],
                [
                    "classid" : "33",
                    "classname": "作家风采"
                ],
                [
                    "classid" : "34",
                    "classname": "维权在线"
                ],
                [
                    "classid" : "212",
                    "classname": "业者动态"
                ],
                [
                    "classid" : "132",
                    "classname": "风花雪月"
                ],
                [
                    "classid" : "396",
                    "classname": "独家报道"
                ],
                [
                    "classid" : "119",
                    "classname": "求职招聘"
                ],
            ]
            
            optionalArray = [
                [
                    "classid" : "32",
                    "classname": "高端访谈"
                ],
                [
                    "classid" : "102",
                    "classname": "政策解读"
                ],
                [
                    "classid" : "111",
                    "classname": "写作指导"
                ],
                [
                    "classid" : "115",
                    "classname": "征稿信息"
                ],
                [
                    "classid" : "51",
                    "classname": "精彩活动"
                ],
                [
                    "classid" : "440",
                    "classname": "写作常识"
                ],
                [
                    "classid" : "209",
                    "classname": "数据分析"
                ],
                [
                    "classid" : "208",
                    "classname": "统计图表"
                ],
                [
                    "classid" : "405",
                    "classname": "名家专栏"
                ],
                [
                    "classid" : "394",
                    "classname": "传统文学"
                ],
                [
                    "classid" : "414",
                    "classname": "写作素材"
                ],
                [
                    "classid" : "281",
                    "classname": "游戏世界"
                ],
                [
                    "classid" : "57",
                    "classname": "娱乐八卦"
                ],
                [
                    "classid" : "58",
                    "classname": "社会杂谈"
                ],
                [
                    "classid" : "56",
                    "classname": "影视动画"
                ]
            ]
            
            // 默认栏目保存
            NSUserDefaults.standardUserDefaults().setObject(selectedArray, forKey: "selectedArray")
            NSUserDefaults.standardUserDefaults().setObject(optionalArray, forKey: "optionalArray")
        }
        
    }
    
    /**
     添加顶部标题栏和控制器
     */
    private func addContent() {
        
        // 初始化栏目
        setupColumn()
        
        // 布局用的左边距
        var leftMargin: CGFloat = 0
        
        for i in 0..<selectedArray!.count {
            
            let label = TopLabel()
            label.text = selectedArray![i]["classname"]
            label.tag = i
            label.scale = i == 0 ? 1.0 : 0.0
            label.userInteractionEnabled = true
            topScrollView.addSubview(label)
            
            // 利用layout来自适应各种长度的label
            label.snp_makeConstraints(closure: { (make) -> Void in
                make.left.equalTo(leftMargin + 15)
                make.centerY.equalTo(topScrollView)
            })
            
            // 更新布局和左边距
            topScrollView.layoutIfNeeded()
            leftMargin = CGRectGetMaxX(label.frame)
            
            // 添加标签点击手势
            label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedTopLabel(_:))))
            
            // 添加控制器
            let newsVc = NewsTableViewController()
            addChildViewController(newsVc)
            
            // 默认控制器
            if i == 0 {
                newsVc.classid = Int(selectedArray![0]["classid"]!)
                newsVc.view.frame = CGRect(x: 0, y: 0, width: contentScrollView.bounds.width, height: contentScrollView.bounds.height)
                contentScrollView.addSubview(newsVc.view)
            }
        }
        
        // 内容区域滚动范围
        contentScrollView.contentSize = CGSize(width: CGFloat(childViewControllers.count) * SCREEN_WIDTH, height: 0)
        contentScrollView.pagingEnabled = true
        
        let lastLabel = topScrollView.subviews.last as! TopLabel
        // 设置顶部标签区域滚动范围
        topScrollView.contentSize = CGSize(width: leftMargin + lastLabel.frame.width, height: 0)
        
        // 视图滚动到第一个位置
        contentScrollView.setContentOffset(CGPoint(x: 0, y: contentScrollView.contentOffset.y), animated: true)
    }
    
    /**
     顶部标签的点击事件
     */
    @objc private func didTappedTopLabel(gesture: UITapGestureRecognizer) {
        let titleLabel = gesture.view as! TopLabel
        contentScrollView.setContentOffset(CGPoint(x: CGFloat(titleLabel.tag) * contentScrollView.frame.size.width, y: contentScrollView.contentOffset.y), animated: true)
    }
    
}

// MARK: - scrollView代理方法
extension NewsViewController: UIScrollViewDelegate {
    
    // 滚动结束后触发 代码导致
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        
        // 滚动标题栏
        let titleLabel = topScrollView.subviews[index]
        var offsetX = titleLabel.center.x - topScrollView.frame.size.width * 0.5
        let offsetMax = topScrollView.contentSize.width - topScrollView.frame.size.width
        
        if offsetX < 0 {
            offsetX = 0
        } else if (offsetX > offsetMax) {
            offsetX = offsetMax
        }
        
        // 滚动顶部标题
        topScrollView.setContentOffset(CGPoint(x: offsetX, y: topScrollView.contentOffset.y), animated: true)
        
        // 恢复其他label缩放
        for i in 0..<selectedArray!.count {
            if i != index {
                let topLabel = topScrollView.subviews[i] as! TopLabel
                topLabel.scale = 0.0
            }
        }
        
    }
    
    // 滚动结束 手势导致
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        scrollViewDidEndScrollingAnimation(scrollView)
    }
    
    // 开始拖拽视图
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        contentOffsetX = scrollView.contentOffset.x
    }
    
    // 正在滚动
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let value = (scrollView.contentOffset.x / scrollView.frame.width)
        
        let leftIndex = Int(value)
        let rightIndex = leftIndex + 1
        let scaleRight = value - CGFloat(leftIndex)
        let scaleLeft = 1 - scaleRight
        
        let labelLeft = topScrollView.subviews[leftIndex] as! TopLabel
        labelLeft.scale = Float(scaleLeft)
        
        if rightIndex < topScrollView.subviews.count {
            let labelRight = topScrollView.subviews[rightIndex] as! TopLabel
            labelRight.scale = Float(scaleRight)
        }
        
        var index = Int(value)
        
        // 根据滑动方向计算下标
        if scrollView.contentOffset.x - contentOffsetX > 2.0 {
            index = (value - CGFloat(Int(value))) > 0 ? Int(value) + 1 : Int(value)
        } else if contentOffsetX - scrollView.contentOffset.x > 2.0 {
            index = (value - CGFloat(Int(value))) < 0 ? Int(value) - 1 : Int(value)
        }
        
        // 控制器角标范围
        if index > childViewControllers.count - 1 {
            index = childViewControllers.count - 1
        } else if index < 0 {
            index = 0
        }
        
        // 获取需要展示的控制器
        let newsVc = childViewControllers[index] as! NewsTableViewController
        
        // 如果已经展示则直接返回
        if newsVc.view.superview != nil {
            return
        }
        
        contentScrollView.addSubview(newsVc.view)
        newsVc.view.frame = CGRect(x: CGFloat(index) * SCREEN_WIDTH, y: 0, width: SCREEN_WIDTH, height: contentScrollView.frame.height)
        
        // 传递分类数据
        newsVc.classid = Int(selectedArray![index]["classid"]!)
    }
}