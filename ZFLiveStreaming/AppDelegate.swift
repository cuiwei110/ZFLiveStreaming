//
//  AppDelegate.swift
//  ZFLiveStreaming
//
//  Created by 周正飞 on 17/5/9.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        UINavigationBar.appearance().barTintColor = KMAINCOLOR
        UITabBar.appearance().tintColor = UIColor.white
        return true
    }


}

