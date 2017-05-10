//
//  BaseNavigationController.swift
//  ZFLiveStreaming
//
//  Created by 周正飞 on 17/5/9.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
