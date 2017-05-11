//
//  HomeType.swift
//  ZFLiveStreaming
//
//  Created by 周正飞 on 17/5/11.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class HomeType {

    var title: String
    var type: Int = 0
    init(dict: Dictionary<String, AnyObject>) {
        self.title = dict["title"] as! String
        self.type = dict["type"] as! Int
    }
}
