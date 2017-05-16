//
//  LiveRoomViewController.swift
//  ZFLiveStreaming
//
//  Created by 周正飞 on 17/5/16.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class LiveRoomViewController: UIViewController {

    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var avatorImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    
}
//MARK:- 设置UI
extension LiveRoomViewController {
    fileprivate func setupUI() {
        setupBlurView()
    }
    private func setupBlurView() {
        let blur = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.frame = backImageView.bounds
        backImageView.addSubview(blurView)
    }
}

//MARK:- 事件响应
extension LiveRoomViewController {
    
    @IBAction func closeClick(_ sender: Any) {
      _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func peopleClick(_ sender: Any) {
        
    }
    @IBAction func followClick(_ sender: UIButton) {
        
    }
    
    @IBAction func bottomBtnsClick(_ sender: UIButton) {
    }
    
}








