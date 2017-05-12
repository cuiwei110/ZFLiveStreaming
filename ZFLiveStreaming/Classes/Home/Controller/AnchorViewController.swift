//
//  AnchorViewController.swift
//  ZFLiveStreaming
//
//  Created by 周正飞 on 17/5/11.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class AnchorViewController: UIViewController {
    
    fileprivate var hometype: HomeType!
    fileprivate var anchorListVM = AnchorListVM()
    fileprivate lazy var collectionView = {
        
    }()
    
    convenience init(type: HomeType) {
        self.init()
        self.hometype = type
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        view.backgroundColor = UIColor.randomColor()
       
    }
}

//MARK:- 设置UI
extension AnchorViewController {
    
    
}

//MARK:- 请求数据
extension AnchorViewController {
    fileprivate func loadData() {
        anchorListVM.loadData(type: hometype, index: 0) { (isSuccess) in
            
        }
    }
}






