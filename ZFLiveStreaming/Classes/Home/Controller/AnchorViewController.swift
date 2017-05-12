//
//  AnchorViewController.swift
//  ZFLiveStreaming
//
//  Created by 周正飞 on 17/5/11.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit
private let kEdgeMargin : CGFloat = 8
fileprivate let cellID = "cellID"
class AnchorViewController: UIViewController {
    
    fileprivate var hometype: HomeType!
    fileprivate var anchorListVM = AnchorListVM()
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = ZFWaterfallLayout()
        layout.delegate = self
        layout.minimumLineSpacing = kEdgeMargin
        layout.minimumInteritemSpacing = kEdgeMargin
          layout.sectionInset = UIEdgeInsets(top: kEdgeMargin, left: kEdgeMargin, bottom: kEdgeMargin, right: kEdgeMargin)
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    convenience init(type: HomeType) {
        self.init()
        self.hometype = type
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        loadData()

    }
}

//MARK:- 设置UI
extension AnchorViewController {
    fileprivate func setupUI() {
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.register(UINib(nibName: "AnchorCell", bundle: Bundle.main), forCellWithReuseIdentifier: cellID)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor = UIColor.white
        view.addSubview(collectionView)
        
    }
    
}

//MARK:- 请求数据
extension AnchorViewController {
    fileprivate func loadData() {
        anchorListVM.loadData(type: hometype, index: 0) { (isSuccess) in
            self.collectionView.reloadData()
        }
    }
}

//MARK:- CollectionView 代理数据源
extension AnchorViewController: UICollectionViewDelegate, UICollectionViewDataSource,ZFWaterfallDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return anchorListVM.anchorVMs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! AnchorCell
        cell.anchorViewModel = anchorListVM.anchorVMs[indexPath.item]

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, _ heightOfIndexPath: IndexPath) -> CGFloat {
        return heightOfIndexPath.item % 2 == 0 ? KSCREEN_W * 2 / 3 : KSCREEN_W / 2
    }
    
}




