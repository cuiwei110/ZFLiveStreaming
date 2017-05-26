//
//  ZFGiftChannelView.swift
//  直播间礼物弹跳数字
//
//  Created by 周正飞 on 17/5/25.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit
enum ZFGiftChannelViewStatus {
    case idle //闲置状态
    case animating
    case willEnd // 三秒等待
    case endAnimating // 消失的0.25
}
protocol ZFGiftChannelViewDelegate: class {
    func channelViewEndAnimation(_ channelView: ZFGiftChannelView)
}


class ZFGiftChannelView: UIView {
    weak var delegate: ZFGiftChannelViewDelegate?
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var avatorImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var giftNameLabel: UILabel!
    @IBOutlet weak var giftImageView: UIImageView!
    @IBOutlet weak var giftDigitLabel: ZFGiftDigitLabel!
    var cacheNumber = 0 // 待弹跳数字的次数
    fileprivate var currentGiftNum = 0 // 当前显示的数字
    var status: ZFGiftChannelViewStatus = .idle
    var giftAnimateModel : ZFGiftAnimateModel? {
        didSet {
            // 赋值
            guard let giftAnimateModel = giftAnimateModel else { return }
            avatorImageView.zf_setImage(with: giftAnimateModel.senderURL)
            userNameLabel.text = giftAnimateModel.senderName
            giftNameLabel.text = "送出礼物 [\(giftAnimateModel.giftName)]"
            giftImageView.zf_setImage(with: giftAnimateModel.giftURL)
            // 弹出视图
            status = .animating
            showAnimation()
        }
    }
    
    override func awakeFromNib() {
        giftNameLabel.textColor = ZFGiftAnimateStyle.giftNameTextColor
        backView.backgroundColor = ZFGiftAnimateStyle.giftChannelBackColor
        backgroundColor = UIColor.clear
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backView.layer.cornerRadius = frame.height * 0.5
        avatorImageView.layer.cornerRadius = frame.height * 0.5
        avatorImageView.layer.masksToBounds = true
        avatorImageView.layer.borderColor = ZFGiftAnimateStyle.avatorImageBorderColor
        avatorImageView.layer.borderWidth = 2
    }
}
//MARK:- 对外提供的函数
extension ZFGiftChannelView {
    // 增加连击动画
    func addOnceToCache() {
        if status == .willEnd { // 如果是将要消失
            digitLabelAnimation() // 立即进行动画
            status = .animating  // 修改状态,不然影响下一次点击的效果
            NSObject.cancelPreviousPerformRequests(withTarget: self) //取消将要消失的方法
        }else {
            cacheNumber += 1 // 如果不是将要消失的状态,直接添加数字,动画过程中会时刻判断number>0
        }
        
    }
    class func loadFromNib() -> ZFGiftChannelView{
        return Bundle.main.loadNibNamed("ZFGiftChannelView", owner: nil, options: nil)?.first as! ZFGiftChannelView
    }
}

//MARK:- 执行动画代码
extension ZFGiftChannelView {
    // 自身从左侧出现到屏幕上的动画
    fileprivate func showAnimation() {
        UIView.animate(withDuration: 0.2, animations: { 
            self.alpha = 1
            self.frame.origin.x = 0
        }) { (isfinished) in
            self.digitLabelAnimation()
        }
    }
    
    // 数字弹跳+1动画
    fileprivate func digitLabelAnimation() {
        currentGiftNum += 1
        giftDigitLabel.text = " x \(currentGiftNum) "
        
        giftDigitLabel.startScaleAnimation {
            if self.cacheNumber > 0 {
                self.cacheNumber -= 1
                self.digitLabelAnimation()
            }else {
                self.status = .willEnd
                self.perform(#selector(self.endAnimation), with: nil, afterDelay: 3.0)
            }
 
        }
    }
    
    @objc fileprivate func endAnimation() {
        status = .endAnimating
        UIView.animate(withDuration: 0.25, animations: {
            self.frame.origin.x = UIScreen.main.bounds.width
            self.alpha = 0
        }) { (isfinished) in
            self.currentGiftNum = 0
            self.giftAnimateModel = nil
            self.frame.origin.x = -self.frame.width
            self.status = .idle
            self.delegate?.channelViewEndAnimation(self)
        }
    }
}






