//
//  PhotoViewController.swift
//  爆侃网文
//
//  Created by 金亮齐 on 2017/3/31.
//  Copyright © 2017年 醉看红尘这场梦. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    
    /// 顶部标签按钮区域
    @IBOutlet weak var topScrollView: UIScrollView!
    /// 内容区域
    @IBOutlet weak var contentScrollView: UIScrollView!
    /// 标签按钮旁的加号按钮
    @IBOutlet weak var addButton: UIButton!
    // 顶部标签数组
    private var topTitles: [[String : String]]?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewDidAppear(animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
    }
    
    //视图
    private func setupUI() {

        addContent()
    }
    private func addContent() {
        
        self.topTitles = [
            [
                "classid" : "322",
                "classname" : "图话网文"
            ],
            [
                "classid" : "434",
                "classname": "精品封面"
            ],
            [
                "classid" : "366",
                "classname": "游戏图库"
            ],
            [
                "classid" : "338",
                "classname": "娱乐八卦"
            ],
            [
                "classid" : "354",
                "classname": "社会百态"
            ],
            [
                "classid" : "357",
                "classname": "旅游视野"
            ],
            [
                "classid" : "433",
                "classname": "军事图秀"
            ]
        ]
        
        // 布局用的左边距
        var leftMargin: CGFloat = 0
        
        for i in 0..<topTitles!.count {
            let label = TopLabel()
            label.text = topTitles![i]["classname"]
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
            let photoVc = PhotoTableViewController()
            addChildViewController(photoVc)
            
            // 默认控制器
            if i == 0 {
                photoVc.classid = Int(topTitles![0]["classid"]!)
                photoVc.view.frame = contentScrollView.bounds
                contentScrollView.addSubview(photoVc.view)
            }
            
        }
        
        // 内容区域滚动范围
        contentScrollView.contentSize = CGSize(width: CGFloat(childViewControllers.count) * SCREEN_WIDTH, height: 0)
        contentScrollView.pagingEnabled = true
        
        let lastLabel = topScrollView.subviews.last as! TopLabel
        // 设置顶部标签区域滚动范围
        topScrollView.contentSize = CGSize(width: leftMargin + lastLabel.frame.width, height: 0)
    }
    
    /** 顶部标签的点击事件 */
    @objc private func didTappedTopLabel(gesture: UITapGestureRecognizer) {
        let titleLabel = gesture.view as! TopLabel
        contentScrollView.setContentOffset(CGPoint(x: CGFloat(titleLabel.tag) * contentScrollView.frame.size.width, y: contentScrollView.contentOffset.y), animated: true)
    }
}

// MARK: - scrollView代理方法
extension PhotoViewController: UIScrollViewDelegate {
    
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
        for i in 0..<topTitles!.count {
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
    
    // 正在滚动
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let value = abs(scrollView.contentOffset.x / scrollView.frame.width)
        
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
        
        // 计算子控制器数组角标
        var index = (value - CGFloat(Int(value))) > 0 ? Int(value) + 1 : Int(value)
        
        // 控制器角标范围
        if index > childViewControllers.count - 1 {
            index = childViewControllers.count - 1
        } else if index < 0 {
            index = 0
        }
        
        // 获取需要展示的控制器
        let photoVc = childViewControllers[index] as! PhotoTableViewController
        
        // 如果已经展示则直接返回
        if photoVc.view.superview != nil {
            return
        }
        
        contentScrollView.addSubview(photoVc.view)
        photoVc.view.frame = CGRect(x: CGFloat(index) * SCREEN_WIDTH, y: 0, width: SCREEN_WIDTH, height: contentScrollView.frame.height)
        
        // 传递分类数据
        photoVc.classid = Int(topTitles![index]["classid"]!)
        
    }
    
}
