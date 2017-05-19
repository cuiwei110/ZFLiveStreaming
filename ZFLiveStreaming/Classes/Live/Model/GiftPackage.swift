//
//  GiftPackage.swift
//  ZFLiveStreaming
//
//  Created by 周正飞 on 17/5/19.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import Foundation
class GiftPackage: NSObject {
    var t: Int = 0
    var title: String = ""
    var list: [GiftModel] = [GiftModel]()
    
    init(dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "list" {
            if let listArr = value as? [[String : Any]] {
                for listDict in listArr {
                    list.append(GiftModel(dict: listDict))
                }
            }
        }else {
            super.setValue(value, forKey: key)
        }
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
   
    
    
}
