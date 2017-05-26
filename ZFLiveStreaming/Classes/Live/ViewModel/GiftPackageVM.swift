//
//  GiftPackageVM.swift
//  ZFLiveStreaming
//
//  Created by 周正飞 on 17/5/19.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit
class GiftPackageVM {
    var giftModel : GiftModel
    
    var iconImageUrl : URL?
    var subjectStr: String
    var priceStr: String
    
    init(giftModel: GiftModel) {
        self.giftModel = giftModel
        self.iconImageUrl = URL(string: giftModel.img2)
        if giftModel.subject.contains("(有声)") {
            self.subjectStr = giftModel.subject.replacingOccurrences(of: "(有声)", with: "")
        }else {
            self.subjectStr = giftModel.subject
        }

        self.priceStr = String(giftModel.coin)
    }
}
