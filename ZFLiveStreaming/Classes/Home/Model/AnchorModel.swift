//
//  AnchorModel.swift
//  ZFLiveStreaming
//
//  Created by 周正飞 on 17/5/12.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {

    var avatar: String = ""
    var name: String = ""
    var pic51: String = ""
    var pic74:String = ""
    var roomid: String = ""
    var uid: String = ""
    
    var push = 0
    var focus = 0
    var live = 0
    var weeklyStar = 0
    var yearParty = 0
    override var description: String {
        return yy_modelDescription()
    }
  
}
