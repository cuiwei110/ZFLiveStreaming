//
//  EmotionCell.swift
//  ZFLiveStreaming
//
//  Created by 周正飞 on 17/5/18.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class EmotionCell: UICollectionViewCell {
    lazy var emotionImageView = UIImageView()
    
    var emotion: Emotion? {
        didSet {
            guard let emotion = emotion else { return }
            emotionImageView.image = UIImage(named: emotion.emotionName)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        emotionImageView.frame.size = CGSize(width: bounds.width * 0.7, height: bounds.height * 0.7)
        contentView.addSubview(emotionImageView)
    }
}
