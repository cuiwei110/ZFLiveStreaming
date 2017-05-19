//
//  GiftModel.swift
//  ZFLiveStreaming
//
//  Created by 周正飞 on 17/5/19.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import Foundation
class GiftModel: NSObject {
    var img2: String = "" //图片
    var coin: Int = 0 //价格
    var subject: String = "" // 标题
    init(dict: [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {  }
    


    
    
}
