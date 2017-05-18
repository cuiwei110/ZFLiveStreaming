//
//  EmotionView.swift
//  ZFLiveStreaming
//
//  Created by 周正飞 on 17/5/18.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit
private let KEmotionCell = "KEmotionCell"
class EmotionView: UIView {
    var emotionClicked : ((Emotion) -> ())?
    fileprivate var emotionPackages = [EmotionPacage]()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        loadEmotionData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//MARK:- 设置UI
extension EmotionView {
    fileprivate func setupUI() {
        let titles = ["普通","粉丝专属"]
        let style = ZFPageStyle()
        style.scrollEnabled = false
        let layout = ZFPageCollectionViewLayout()
        layout.cols = 7
        layout.rows = 3
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 0, 10)
        let pageCollectionView = ZFPageCollectionView(frame: bounds,
                                            titles: titles,
                                            style: style,
                                            isTitleInTop: false,
                                            layout: layout)
        pageCollectionView.dataSource = self
        pageCollectionView.delegate = self
        pageCollectionView.register(cellClass: EmotionCell.self, identifier: KEmotionCell)
        addSubview(pageCollectionView)
    }
}

//MARK:- 读取数据
extension EmotionView {
    fileprivate func loadEmotionData() {
        emotionPackages = EmotionViewModel.shareInstance.emotionPackages
    }
}

//MARK:- 数据源
extension EmotionView: ZFPageCollectionViewDataSource {
    func numberOfSections(in collectionView: ZFPageCollectionView) -> Int {
        return emotionPackages.count
    }
    func collectionView(_ collectionView: ZFPageCollectionView, numberOfItemsInSection section: Int) -> Int {
        return emotionPackages[section].emotions.count
    }
    func collectionView(_ pageCollectionView: ZFPageCollectionView, _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KEmotionCell, for: indexPath) as! EmotionCell
        cell.emotion = emotionPackages[indexPath.section].emotions[indexPath.item]
        return cell
    }
}
//MARK:- 点击代理
extension EmotionView : ZFPageCollectionViewDelegate {
    func collectionView(_ pageCollectionView: ZFPageCollectionView, _ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let emotion = emotionPackages[indexPath.section].emotions[indexPath.item]
        if let emotionClicked = emotionClicked {
            emotionClicked(emotion)
        }
    }
}


