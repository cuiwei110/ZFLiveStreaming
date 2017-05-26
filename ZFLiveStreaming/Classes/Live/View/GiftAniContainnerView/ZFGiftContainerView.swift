//
//  ZFGiftContainerView.swift
//  直播间礼物弹跳数字
//
//  Created by 周正飞 on 17/5/25.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit
private let kChannelViewH: CGFloat = 40

class ZFGiftContainerView: UIView {

    fileprivate var channelViews = [ZFGiftChannelView]()
    // 存放未出现的礼物模型以及缓存的个数
    fileprivate lazy var cachesGiftAniModel = [(model:ZFGiftAnimateModel?,cache:Int)]()
    fileprivate var channelCount: CGFloat = 0 // 可以展示的通道数
    
    init(frame: CGRect, channelCount: CGFloat = 2) {
        super.init(frame: frame)
        self.channelCount = channelCount
        setupUI()
    }
    private init () {
        super.init(frame: CGRect.zero)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
//MARK:- 设置UI
extension ZFGiftContainerView {
    fileprivate func setupUI() {
        let w: CGFloat = frame.width
        let channelMargin = ZFGiftAnimateStyle.channelMargin
        let h: CGFloat = (frame.height - channelMargin * (channelCount - 1)) / channelCount
        let x: CGFloat = -frame.width
        for i in 0 ..< Int(channelCount) {
            let y: CGFloat = (kChannelViewH + channelMargin) * CGFloat(i)
            let channelView = ZFGiftChannelView.loadFromNib()
            channelView.delegate = self
            channelView.frame = CGRect(x: x, y: y, width: w, height: h)
            channelView.alpha = 0
            channelViews.append(channelView)
            addSubview(channelView)
        }
    }
}

//MARK:- 设置模型属性
extension ZFGiftContainerView {
    
    func showWithGiftAniModel(_ model: ZFGiftAnimateModel) {
        // 1. 判断正在忙的channalView中的username/giftname
        if let channelView = checkUsingChannelView(model) {
            channelView.addOnceToCache()
        }else if let channelView = checkIdleChannelView() { // 判断是否有闲置的channelView
            channelView.giftAnimateModel = model
        }else {
            // 把模型加入到缓存
            // 如果缓存中有相同的模型了,加它的个数
            for i in 0 ..< cachesGiftAniModel.count {
                let cacheGift = cachesGiftAniModel[i]
                if cacheGift.0 == model {
                    cachesGiftAniModel[i].1 += 1
                    return
                }
            }
            // 如果缓存中没有这个模型,再添加
            cachesGiftAniModel.append((model,0))
        }
    }
    
    // 返回正在活跃的channelView
    private func checkUsingChannelView(_ giftModel: ZFGiftAnimateModel) -> ZFGiftChannelView?{
        for channelView in channelViews {
            if giftModel.isEqual(channelView.giftAnimateModel) && channelView.status != .endAnimating{
                return channelView
            }
        }
           return nil
    }
    // 返回正在闲置的channelView
    private func checkIdleChannelView() -> ZFGiftChannelView? {
        for channelView in channelViews {
            if channelView.status == .idle {
                return channelView
            }
        }
        return nil
    }
}
//MARK:- channelView代理
extension ZFGiftContainerView: ZFGiftChannelViewDelegate {
    // channelView变得闲置了
    func channelViewEndAnimation(_ channelView: ZFGiftChannelView) {
        if cachesGiftAniModel.count > 0 {
            channelView.cacheNumber = cachesGiftAniModel.first!.cache
            channelView.giftAnimateModel = cachesGiftAniModel.first?.model
            cachesGiftAniModel.removeFirst()
        }
    }
}





