//
//  ZFGiftDigitLabel.swift
//  直播间礼物弹跳数字
//
//  Created by 周正飞 on 17/5/25.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class ZFGiftDigitLabel: UILabel {
    
    // 设置label具有描边效果:
    // 画一个storke空心的字, 再画一个fill填充的字. 都具有一定宽度
    // 可以完成橘色的字中央是蓝色填充的效果.
    override func drawText(in rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        // 设置线段宽度
        context?.setLineWidth(5)
        // 磨角线
        context?.setLineCap(.round)
        // 空心的边儿
        context?.setTextDrawingMode(.stroke)
        textColor = ZFGiftAnimateStyle.giftNameTextColor
        super.drawText(in: rect)
        // 填充的
        context?.setTextDrawingMode(.fill)
        textColor = ZFGiftAnimateStyle.digitTextFillColor
        
        super.drawText(in: rect)
    }
    
    func startScaleAnimation(_ completion: @escaping () -> ()) {
        UIView.animateKeyframes(withDuration: 0.4, delay: 0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.3, animations: {
                self.transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.7, animations: {
                self.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            })
        }) { (finished) in
            UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 10, options: [], animations: { 
                self.transform = CGAffineTransform.identity
            }, completion: { (finished) in
                completion()
            })
        }
        
    }
    
}
