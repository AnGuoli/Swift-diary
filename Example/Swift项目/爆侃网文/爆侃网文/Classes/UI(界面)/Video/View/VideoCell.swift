//
//  VideoCell.swift
//  爆侃网文
//
//  Created by 金亮齐 on 2017/3/31.
//  Copyright © 2017年 醉看红尘这场梦. All rights reserved.
//

import UIKit
import YYWebImage

class VideoCell: UITableViewCell {

    var postModel: ArticleListModel? {
        didSet {
            iconView.yy_setImageWithURL(NSURL(string: postModel!.titlepic!), options: YYWebImageOptions.ShowNetworkActivity)
            titleLabel.text = postModel!.title
            dateLabel.text = postModel!.newstime
            readCountLabel.text = "阅读量: \(postModel!.onclick!)"
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // 准备uI
        prepareUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     准备UI
     */
    private func prepareUI() {
        
        contentView.addSubview(iconView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(readCountLabel)
        
        let margin = 10
        
        // 约束控件
        iconView.snp_makeConstraints { (make) -> Void in
            make.top.left.equalTo(10)
            make.size.equalTo(CGSize(width: 80, height: 80))
        }
        titleLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(iconView.snp_top).offset(5)
            make.left.equalTo(iconView.snp_right).offset(margin)
            make.right.equalTo(-margin)
        }
        dateLabel.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(iconView.snp_bottom).offset(-5)
            make.left.equalTo(iconView.snp_right).offset(margin)
        }
        readCountLabel.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(iconView.snp_bottom).offset(-5)
            make.right.equalTo(-margin)
        }
        
    }
    
    // MARK: - 懒加载
    private lazy var iconView: UIImageView = {
        let iconView = UIImageView()
        iconView.contentMode = UIViewContentMode.ScaleAspectFill
        iconView.layer.masksToBounds = true
        return iconView
    }()
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        return titleLabel
    }()
    private lazy var dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.textColor = UIColor.grayColor()
        dateLabel.font = UIFont.systemFontOfSize(12)
        return dateLabel
    }()
    private lazy var readCountLabel: UILabel = {
        let readCountLabel = UILabel()
        readCountLabel.textColor = UIColor.grayColor()
        readCountLabel.font = UIFont.systemFontOfSize(12)
        return readCountLabel
    }()

}
