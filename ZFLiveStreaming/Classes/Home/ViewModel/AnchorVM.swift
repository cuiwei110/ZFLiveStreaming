//
//  AnchorVM.swift
//  ZFLiveStreaming
//
//  Created by 周正飞 on 17/5/12.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class AnchorVM: NSObject {
    var anchor: AnchorModel
    
    var nickName: String
    var onlineNumber: String
    var avatorUrl: String
    var isLiving: Bool
    
    
    init(anchor: AnchorModel) {
        self.anchor = anchor
        
        self.nickName = anchor.name
        self.onlineNumber = String(anchor.focus)
        self.avatorUrl = anchor.pic74
        self.isLiving = anchor.live == 1
        
    }
}
