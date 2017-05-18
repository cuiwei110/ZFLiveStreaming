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

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//MARK:- 设置UI
extension EmotionView {
    fileprivate func setupUI() {
        let titles = ["土豪","你好","跑车","鲜花"]
        let style = ZFPageStyle()
        let layout = ZFPageCollectionViewLayout()
        layout.cols = 7
        layout.rows = 3
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        let pageCollectionView = ZFPageCollectionView(frame: bounds,
                                            titles: titles,
                                            style: style,
                                            isTitleInTop: false,
                                            layout: layout)
        pageCollectionView.dataSource = self
        pageCollectionView.register(cellClass: UICollectionViewCell.self, identifier: KEmotionCell)
        addSubview(pageCollectionView)
    }
}

//MARK:- 数据源
extension EmotionView: ZFPageCollectionViewDataSource {
    func numberOfSections(in collectionView: ZFPageCollectionView) -> Int {
        return 4
    }
    func collectionView(_ collectionView: ZFPageCollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    func collectionView(_ pageCollectionView: ZFPageCollectionView, _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KEmotionCell, for: indexPath)
        cell.backgroundColor = UIColor.randomColor()
        return cell
    }
    
}


