//
//  UIImage+extension.swift
//  ZFLiveStreaming
//
//  Created by 周正飞 on 17/5/15.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import Foundation
import UIKit
extension UIImage {
    /// 重绘一张指定尺寸的图
    func compressAlignedImage(size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        let frame = CGRect(origin: CGPoint(), size: size)
        draw(in: frame)
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resultImage
    }
    
    // 重绘一张图,有助于减少内存
    func compressImage() -> UIImage! {
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        draw(at: CGPoint())
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resultImage!
    }
    
    //切圆角
    func cirImage(_ cornerRadius: CGFloat, _ sizetoFit: CGSize) -> UIImage? {

      
        let rect = CGRect(origin: CGPoint(), size: sizetoFit)
        UIGraphicsBeginImageContextWithOptions(sizetoFit, true, 0)
        let path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
        UIColor.white.setFill()
        UIRectFill(rect)
        path.addClip()
        draw(in: rect)
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resultImage
        
    }
    
}




