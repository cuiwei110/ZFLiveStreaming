//
//  ZFGiftAnimateModel.swift
//  直播间礼物弹跳数字
//
//  Created by 周正飞 on 17/5/25.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class ZFGiftAnimateModel: NSObject{

    var senderName: String
    var senderURL: String
    var giftName: String
    var giftURL: String
    
    init(senderName: String, senderURL: String, giftName:String, giftURL: String) {
        self.senderName = senderName
        self.senderURL = senderURL
        self.giftName = giftName
        self.giftURL = giftURL
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? ZFGiftAnimateModel else {
            return false
        }
        guard object.giftName == giftName && object.senderName == senderName else {
            return false
        }
        return true
    }
    
}
