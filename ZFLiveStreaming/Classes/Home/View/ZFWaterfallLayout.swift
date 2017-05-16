//
//  ZFWaterfallLayout.swift
//  ZFWaterfall
//
//  Created by 周正飞 on 17/5/11.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit
@objc protocol ZFWaterfallDataSource: class {
    func collectionView(_ collectionView: UICollectionView,_ heightOfIndexPath: IndexPath) -> CGFloat
    @objc optional func collectionViewColmuns(_ collectionView: UICollectionView) -> Int
}

class ZFWaterfallLayoutAttributes: UICollectionViewLayoutAttributes {
    var photoHeight: CGFloat = 0
    
    override func copy(with zone: NSZone?) -> Any {
        let copy = super.copy(with: zone) as! ZFWaterfallLayoutAttributes
        copy.photoHeight = photoHeight
        return copy
    }
    override func isEqual(_ object: Any?) -> Bool {
        if let attributes = object as? ZFWaterfallLayoutAttributes{
            if attributes.photoHeight == photoHeight {
                return super.isEqual(object)
            }
        }
      return false
    }
}



class ZFWaterfallLayout: UICollectionViewFlowLayout {
    weak var delegate: ZFWaterfallDataSource?
  
    
    fileprivate lazy var columnsHeight: [CGFloat] = {
        let columns =  self.delegate?.collectionViewColmuns?(self.collectionView!) ?? 2
        return Array.init(repeating: CGFloat(0), count: columns)
    }()

    fileprivate var attributes: [ZFWaterfallLayoutAttributes] = [ZFWaterfallLayoutAttributes]()
    fileprivate var maxH: CGFloat = 0
    
}

extension ZFWaterfallLayout {
    
    
    override func prepare() {
        super.prepare()
        if !attributes.isEmpty { return }
        
        let columns =  self.delegate?.collectionViewColmuns?(self.collectionView!) ?? 2

        let cellW: CGFloat = (collectionView!.bounds.width - sectionInset.left - sectionInset.right - CGFloat(columns - 1) * minimumInteritemSpacing) / CGFloat(columns)
        for i in 0 ..< collectionView!.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: i, section: 0)
            let attr = ZFWaterfallLayoutAttributes(forCellWith: indexPath)
            let minHeight = columnsHeight.min()!
            let minIndex = columnsHeight.index(of: minHeight)!
            
            let cellH: CGFloat = delegate?.collectionView(collectionView!, indexPath) ?? 0
            let cellX: CGFloat = sectionInset.left + (minimumInteritemSpacing + cellW) * CGFloat(minIndex)
            let cellY: CGFloat = minHeight + minimumLineSpacing
            attr.frame = CGRect(x: cellX, y: cellY, width: cellW, height: cellH)
            columnsHeight[minIndex] +=  cellH + minimumLineSpacing
            attr.photoHeight = cellH
            attributes.append(attr)
        }
        maxH = columnsHeight.max()! + sectionInset.bottom - minimumInteritemSpacing
    }
}

extension ZFWaterfallLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributes
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: maxH)
    }
    override class var layoutAttributesClass : AnyClass {
        return ZFWaterfallLayoutAttributes.self
    }
}
