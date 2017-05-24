//
//  AnchorCell.swift
//  ZFLiveStreaming
//
//  Created by 周正飞 on 17/5/12.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit
class AnchorCell: UICollectionViewCell {
    var phoneHeight: CGFloat?
    var anchorViewModel: AnchorVM? {
        didSet {
            guard let anchorViewModel = anchorViewModel else { return }
            
            nameLabel.text = anchorViewModel.nickName
            
            onlinePeopleLabel.text = anchorViewModel.onlineNumber
            
//            SDWebImageManager.shared().loadImage(with: URL(string: anchorViewModel.avatorUrl), options: [], progress: nil) { (image, _, _, _, _, _) in
//                let targetSize = CGSize(width: self.bounds.width, height: self.phoneHeight!)
//                self.albumImageView.image = image
//            }
        albumImageView.zf_setImage(with: anchorViewModel.avatorUrl, "home_pic_default")
            
                // 解决了 图片拉伸问题后发现内存暴涨!!!
                // 此方法用在给ImageView赋值的时候会减少内存,用在SDWebImage回调这里会增加内存
//                self.albumImageView.image = image?.compressImage()
    
//                self.albumImageView.image = image?.cirImage(8, self.albumImageView.bounds.size)
                
                
            
            
            liveImageView.isHidden = !anchorViewModel.isLiving
            
            
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var onlinePeopleLabel: UILabel!
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var liveImageView: UIImageView!
 
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    // 从这里获取到在layout里设置的每一个cell布局中的height属性
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        if let layoutAttributes = layoutAttributes as? ZFWaterfallLayoutAttributes {
            phoneHeight = layoutAttributes.photoHeight
        }
    }

}
