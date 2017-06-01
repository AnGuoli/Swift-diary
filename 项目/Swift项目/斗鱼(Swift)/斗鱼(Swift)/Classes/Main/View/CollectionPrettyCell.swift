//
//  CollectionPrettyCell.swift
//  斗鱼(Swift)
//
//  Created by 金亮齐 on 2017/5/31.
//  Copyright © 2017年 醉看红尘这场梦. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionPrettyCell: UICollectionViewCell {
    
    //MARK : - 控件属性
    @IBOutlet weak var iconImageView: UIImageView!

    @IBOutlet weak var onlineBtn: UIButton!
    
    @IBOutlet weak var nickNameLabel: UILabel!
    
    @IBOutlet weak var cityBtn: UIButton!
    

    // MARK:- 定义模型
    var anchor : AnchorModel? {
        didSet {
            // 0.校验模型是否有值
            guard let anchor = anchor else { return }
            
            // 1.取出在线人数显示的文字
            var onlineStr : String = ""
            if anchor.online >= 10000 {
                onlineStr = "\(Int(anchor.online / 10000))万在线"
            } else {
                onlineStr = "\(anchor.online)在线"
            }
            onlineBtn.setTitle(onlineStr, forState: .Normal)
            
            // 2.昵称的显示
            nickNameLabel.text = anchor.nickname
            
            //所在城市
            cityBtn.setTitle(anchor.anchor_city, forState: .Normal)
            
            // 3.设置封面图片
            guard let iconURL = NSURL(string: anchor.vertical_src) else { return }
            iconImageView.kf_setImageWithURL(iconURL)
        }
    }

}
