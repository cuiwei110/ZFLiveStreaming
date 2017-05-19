//
//  GiftCollectionCell.swift
//  ZFLiveStreaming
//
//  Created by 周正飞 on 17/5/19.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class GiftCollectionCell: UICollectionViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    var giftPackeVM: GiftPackageVM? {
        didSet {
            guard let giftPackeVM = giftPackeVM else { return }
            iconImageView.sd_setImage(with: giftPackeVM.iconImageUrl)
            subjectLabel.text = giftPackeVM.subjectStr
            priceLabel.text = giftPackeVM.priceStr
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
      
        setBackselectView()
    }

    private func setBackselectView() {
        let backView = UIView()
        backView.layer.cornerRadius = 5
        backView.layer.borderWidth = 2
        
        backView.layer.borderColor = KMAINButtonColor.cgColor
        backView.backgroundColor = UIColor.black
        selectedBackgroundView = backView
    }
}
