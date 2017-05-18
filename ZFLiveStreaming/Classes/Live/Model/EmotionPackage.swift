//
//  EmotionPack.swift
//  ZFLiveStreaming
//
//  Created by 周正飞 on 17/5/18.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import Foundation
class EmotionPacage {
    var emotions: [Emotion] = [Emotion]()
    
    init(plistName: String) {
        guard let path = Bundle.main.path(forResource: plistName, ofType: nil) else { return }
        guard let emotionArr = NSArray.init(contentsOfFile: path) as? [String] else { return }
        self.emotions =  emotionArr.map{ Emotion(emotionName: $0) }
    }
    
}
