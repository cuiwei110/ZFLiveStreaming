//
//  AnchorCell.swift
//  ZFLiveStreaming
//
//  Created by 周正飞 on 17/5/12.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit
import SDWebImage
class AnchorCell: UICollectionViewCell {

    var anchorViewModel: AnchorVM? {
        didSet {
            guard let anchorViewModel = anchorViewModel else { return }
            
            nameLabel.text = anchorViewModel.nickName
            
            onlinePeopleLabel.text = anchorViewModel.onlineNumber
            
            albumImageView.sd_setImage(with: URL(string: anchorViewModel.avatorUrl))
            
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

}
