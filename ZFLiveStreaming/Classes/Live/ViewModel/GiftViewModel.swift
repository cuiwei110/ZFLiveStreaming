//
//  GiftViewModel.swift
//  ZFLiveStreaming
//
//  Created by 周正飞 on 17/5/19.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import Foundation
class GiftViewModel {
    
    lazy var giftListData:[GiftPackage] = [GiftPackage]()
    
    func loadGiftListData(finished: @escaping (_ isSuccess:Bool) -> ()) {
        NetworkTool.shareInstance.loadGiftData(type: 0, page: 1, rows: 150) { (dict, error) in
            guard  error == nil else {
                finished(false)
                return
            }
            guard let rootDict = dict else {
                finished(false)
                return
            }
            guard let dataDict = rootDict["message"] as? [String: Any] else { return }
            for i in 0 ..< dataDict.count {
                guard let dict = dataDict["type\(i+1)"] as? [String: Any] else {continue}
                self.giftListData.append(GiftPackage(dict: dict))
            }
            self.giftListData =  self.giftListData.filter({ $0.t != 0 }).sorted(by: {return $0.t > $1.t})
            finished(true)
            
            
        }
    }
    
}
