//
//  InputAccessoryView.swift
//  花田小憩
//
//  Created by 金亮齐 on 2016/12/22.
//  Copyright © 2016年 醉看红尘这场梦. All rights reserved.
//

import UIKit

class InputAccessoryView: UIView {
    weak var filed : UITextField?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(doneBtn)
        doneBtn.addTarget(self, action: #selector(InputAccessoryView.done), forControlEvents: .TouchUpInside)
        
        backgroundColor = UIColor.darkGrayColor()
        doneBtn.snp_makeConstraints { (make) in
            make.right.centerY.equalTo(self)
            make.width.equalTo(60)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func done() {
        if let _ = filed {
            filed!.resignFirstResponder()
        }
    }
    
    /// 完成按钮
    private lazy var doneBtn = UIButton(title: "完成", imageName: nil, target: nil, selector: nil, font: defaultFont14, titleColor: UIColor.whiteColor())

}
