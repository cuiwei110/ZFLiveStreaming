//
//  GiftView.swift
//  ZFLiveStreaming
//
//  Created by 周正飞 on 17/5/18.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit
private let KGiftCell = "KGiftCell"
class GiftView: UIView,LoadNibable {

    @IBOutlet weak var pageCollectionView: UIView!
    
    @IBOutlet weak var balanceLabel: UILabel!
    
    @IBOutlet weak var sendGiftBtn: UIButton!
    fileprivate var collectionView: ZFPageCollectionView!
    
    fileprivate var giftViewModel = GiftViewModel()
    
    @IBAction func sendGiftClick(_ sender: UIButton) {
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        loadData()
        setupUI()
    }
}

//MARK:- 设置UI
extension GiftView {
    fileprivate func setupUI() {
        let titles = ["热门","高级","豪华","专属"]
        let style = ZFPageStyle()
        style.scrollEnabled = false
        style.collectionViewBackColor = UIColor.clear
        let layout = ZFPageCollectionViewLayout()
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 0, 10)
        layout.cols = 4
        layout.rows = 2
        var frame = pageCollectionView.bounds
        frame.size.width = KSCREEN_W
        frame.size.height = kGiftViewH - 30 - 30
        collectionView = ZFPageCollectionView(frame: frame,
                                                  titles: titles,
                                                  style: style,
                                                  isTitleInTop: true,
                                                  layout: layout)
       
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellClass: UICollectionViewCell.self, identifier: KGiftCell)
        pageCollectionView.addSubview(collectionView)
       
    }
}
//MARK:- 请求数据
extension GiftView {
    fileprivate func loadData() {
        giftViewModel.loadGiftListData { (isSuccess) in
            if isSuccess {
                self.collectionView.reloadData()
            }
        }
    }
}


//MARK:- collectionView数据源
extension GiftView : ZFPageCollectionViewDataSource {
    func numberOfSections(in collectionView: ZFPageCollectionView) -> Int {
        return giftViewModel.giftListData.count
    }
    func collectionView(_ collectionView: ZFPageCollectionView, numberOfItemsInSection section: Int) -> Int {
        return giftViewModel.giftListData[section].list.count
    }
   
    func collectionView(_ pageCollectionView: ZFPageCollectionView, _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KGiftCell, for: indexPath)
        cell.backgroundColor = UIColor.randomColor()
        return cell
    }
    func collectionView(_ pageCollectionView: ZFPageCollectionView, _ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

//MARK:- collectionView代理
extension GiftView: ZFPageCollectionViewDelegate {
    
}





