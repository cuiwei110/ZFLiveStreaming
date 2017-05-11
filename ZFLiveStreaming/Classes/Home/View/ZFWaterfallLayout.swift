//
//  ZFWaterfallLayout.swift
//  ZFWaterfall
//
//  Created by 周正飞 on 17/5/11.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit
protocol ZFWaterfallDataSource: class {
    func collectionView(_ collectionView: UICollectionView,_ heightOfIndexPath: IndexPath) -> CGFloat
    func collectionViewColmuns(_ collectionView: UICollectionView) -> Int
}


class ZFWaterfallLayout: UICollectionViewFlowLayout {
    weak var delegate: ZFWaterfallDataSource?
    fileprivate lazy var columns: Int = {
        let colmun =  self.delegate?.collectionViewColmuns(self.collectionView!) ?? 0
        return colmun
    }()
    fileprivate var attributes: [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    
}

extension ZFWaterfallLayout {
    override func prepare() {
        super.prepare()
        if !attributes.isEmpty { return }
        
        var columnsHeight = Array.init(repeating: CGFloat(0), count: columns)
        
        let cellW: CGFloat = (collectionView!.bounds.width - sectionInset.left - sectionInset.right - CGFloat(columns - 1) * minimumInteritemSpacing) / CGFloat(columns)
        for i in 0 ..< collectionView!.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: i, section: 0)
            let attr = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            let minHeight = columnsHeight.min()!
            let minIndex = columnsHeight.index(of: minHeight)!
            
            let cellH: CGFloat = delegate?.collectionView(collectionView!, indexPath) ?? 0
            let cellX: CGFloat = sectionInset.left + (minimumInteritemSpacing + cellW) * CGFloat(minIndex)
            let cellY: CGFloat = minHeight + minimumLineSpacing
            attr.frame = CGRect(x: cellX, y: cellY, width: cellW, height: cellH)
            columnsHeight[minIndex] +=  cellH + minimumLineSpacing
            attributes.append(attr)
        }
    }
}

extension ZFWaterfallLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributes
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 1000)
    }
}
