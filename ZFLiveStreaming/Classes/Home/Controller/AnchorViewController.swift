//
//  AnchorViewController.swift
//  ZFLiveStreaming
//
//  Created by 周正飞 on 17/5/11.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class AnchorViewController: UIViewController {
    
    var hometype: HomeType!
    var anchorListVM = AnchorListVM()
    convenience init(type: HomeType) {
        self.init()
        self.hometype = type
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.randomColor()
        anchorListVM.loadData(type: hometype, index: 0) { (isSuccess) in
            
        }
    }


}
