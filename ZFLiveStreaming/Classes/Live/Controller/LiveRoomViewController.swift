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
    // 聊天工具栏
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    fileprivate lazy var chatToolView:ChatToolView = ChatToolView.loadFromNib()
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
        setupChatView()
    }
    // 背景
    private func setupBlurView() {
        let blur = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.frame = backImageView.bounds
        backImageView.addSubview(blurView)
    }
    // 聊天工具栏
    private func setupChatView() {
        chatToolView.frame = CGRect(x: 0, y: KSCREEN_H, width: KSCREEN_W, height: KChatToolViewH)
        chatToolView.autoresizingMask = [.flexibleTopMargin,.flexibleBottomMargin, .flexibleLeftMargin , .flexibleRightMargin]
        chatToolView.delegate = self
        view.addSubview(chatToolView)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(_:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
}

//MARK:- 按钮的触发
extension LiveRoomViewController: EmitterAnimate {
    
    @IBAction func closeClick(_ sender: Any) {
      _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func peopleClick(_ sender: Any) {
        
    }
    @IBAction func followClick(_ sender: UIButton) {
        
    }
    
    @IBAction func bottomBtnsClick(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            chatToolView.inputTextField.becomeFirstResponder()
        case 1:
            print("分享")
        case 2:
            print("礼物")
        case 3:
            print("更多")
        case 4:
            switchEmitter(sender)
        default:
            print("未处理按钮")
        
        }
    }
  
}



//MARK:- 点击事件响应
extension LiveRoomViewController: ChatToolViewDelegate {
    // 聊天框点击发送
    func toolViewSendClick(_ toolView: ChatToolView, _ message: String) {
        print(message)
    }
    
    
    // 粒子效果开启关闭
    fileprivate func switchEmitter(_ button: UIButton) {
        button.isSelected = !button.isSelected
        if button.isSelected {
            startEmitter(CGPoint(x:button.center.x , y: view.bounds.height - button.bounds.height))
        }else {
            stopEmitter()
        }
    }
    
    // 键盘变化
    @objc fileprivate func keyboardWillChangeFrame(_ note: NSNotification) {
        
        let duration = note.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
        let endFrame = (note.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let chatToolY = endFrame.origin.y - KChatToolViewH
        UIView.animate(withDuration: duration) { 
            self.chatToolView.frame.origin.y = chatToolY
        }
        if endFrame.origin.y >= KSCREEN_H {
            chatToolView.frame.origin.y = KSCREEN_H
        }
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        chatToolView.inputTextField.resignFirstResponder()
    }
    
}








