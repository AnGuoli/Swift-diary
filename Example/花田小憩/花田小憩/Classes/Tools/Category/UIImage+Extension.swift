//
//  UIImage+Extension.swift
//  花田小憩
//
//  Created by 金亮齐 on 2016/12/21.
//  Copyright © 2016年 醉看红尘这场梦. All rights reserved.
//

import UIKit

extension UIImage
{
    // 改变图片的颜色
    class func imageWithColor(imageName:String, color: UIColor) -> UIImage
    {
        let image = UIImage(named: imageName)!
        UIGraphicsBeginImageContext(image.size)
        let context = UIGraphicsGetCurrentContext();
        CGContextTranslateCTM(context, 0, image.size.height);
        CGContextScaleCTM(context, 1.0, -1.0);
        CGContextSetBlendMode(context, .Normal);
        let rect = CGRectMake(0, 0, image.size.width, image.size.height);
        CGContextClipToMask(context, rect, image.CGImage);
        color.setFill()
        CGContextFillRect(context, rect);
        let newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return newImage;
    }
}
