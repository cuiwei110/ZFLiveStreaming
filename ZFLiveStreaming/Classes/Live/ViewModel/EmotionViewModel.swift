//
//  EmotionViewModel.swift
//  ZFLiveStreaming
//
//  Created by 周正飞 on 17/5/18.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import Foundation
class EmotionViewModel {
    static let shareInstance = EmotionViewModel()
    var emotionPackages: [EmotionPacage] = [EmotionPacage]()
    
    private init() {
        emotionPackages.append(EmotionPacage(plistName:"QHNormalEmotionSort.plist"))
        emotionPackages.append(EmotionPacage(plistName:"QHSohuGifSort.plist"))
    }
    
}
