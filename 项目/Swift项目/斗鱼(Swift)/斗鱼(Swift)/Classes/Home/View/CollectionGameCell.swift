//
//  CollectionGameCell.swift
//  斗鱼(Swift)
//
//  Created by 金亮齐 on 2017/5/31.
//  Copyright © 2017年 醉看红尘这场梦. All rights reserved.
//

import UIKit

class CollectionGameCell: UICollectionViewCell {

    // MARK: 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var lineView: UIView!
    
    
    // MARK: 定义模型属性
    var baseGame : BaseGameModel? {
        didSet {
            titleLabel.text = baseGame?.tag_name
            
            if let iconURL = URL(string: baseGame?.icon_url ?? "") {
                if baseGame?.tag_name == "更多" {
                    iconImageView.image = UIImage(named: "home_more_btn")
                }else {
                    
//                    guard let iconURL = URL(string: anchor.vertical_src) else { return }
                    iconImageView.kf.setImage(with: iconURL, placeholder: #imageLiteral(resourceName: "placehoderImage"))
//                    iconImageView.kf.setImage(with: (with: iconURL), placeholder: #imageLiteral(resourceName: "placehoderImage"))
                }
            } else {
                iconImageView.image = UIImage(named: "home_more_btn")
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutIfNeeded()
        iconImageView.layer.cornerRadius = self.iconImageView.frame.size.height*0.5
        iconImageView.clipsToBounds = true
        frame = CGRect(x: 0, y: 0, width: 80, height: 90)
        lineView.isHidden = true
    }

}
