//
//  LiveRoomViewController.swift
//  ZFLiveStreaming
//
//  Created by 周正飞 on 17/5/16.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit
private let KChatContentViewH: CGFloat = 200
class LiveRoomViewController: UIViewController {
    fileprivate lazy var socket: ZFSocket = {
        let socket = ZFSocket(addr: "192.168.31.119", port: 7878)
        socket.connectServer()
        socket.startReadMsg()
        socket.delegate = self
        return socket
    }()
    @IBOutlet weak var backImageView: UIImageView!
 
    @IBOutlet weak var avatorImageView: UIImageView!
    
    // 聊天工具栏
    fileprivate lazy var chatToolView:ChatToolView = ChatToolView.loadFromNib()
    // 送礼物视图
    fileprivate lazy var giftView: GiftView = {
        let giftView = GiftView.loadFromNib()
        giftView.frame = CGRect(x: 0, y: KSCREEN_H, width: KSCREEN_W, height: kGiftViewH)
        giftView.delegate = self
        return giftView
    }()
    // 礼物动画展示视图
    fileprivate lazy var giftContainnerView: ZFGiftContainerView = {
        let giftContainerView = ZFGiftContainerView(frame: CGRect(x: 0, y: self.avatorImageView.frame.maxY + 70, width: self.view.bounds.width / 2, height: 100))
        return giftContainerView
    }()
    //  聊天内容视图
    fileprivate  var chatContentView:ChatContentView!
   
    fileprivate var heartTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        // 发送进入房间的消息
        socket.sendJoinRoom()
        // 开启心跳
        addHeartBeatTimer()
        

    }
    deinit {
        NotificationCenter.default.removeObserver(self)
        heartTimer?.invalidate()
        heartTimer = nil
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        socket.sendLeaveRoom()
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    
}
//MARK:- 设置UI
extension LiveRoomViewController {
    fileprivate func setupUI() {
        setupBlurView()
        setupChatView()
        setupChatContentView()
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
    // 聊天消息视图
    private func setupChatContentView() {
        chatContentView = ChatContentView(frame: CGRect(x: 5, y: KSCREEN_H - KChatToolViewH - KChatContentViewH, width: KSCREEN_W, height: KChatContentViewH))
        view.addSubview(chatContentView)
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
            showGiftView()
        case 3:
            print("更多")
        case 4:
            switchEmitter(sender)
        default:
            print("未处理按钮")
        
        }
    }
    private func showGiftView() {
        view.addSubview(giftView)
        UIView.animate(withDuration: 0.25) { 
            self.giftView.frame.origin.y = KSCREEN_H - kGiftViewH
        }
    }
  
}



//MARK:- 点击事件响应
extension LiveRoomViewController: ChatToolViewDelegate, GiftViewDelegate {
    
    // 聊天框点击发送
    func toolViewSendClick(_ toolView: ChatToolView, _ message: String) {
        DispatchQueue.global().async {
            self.socket.sendTextMsg(text: message)
        }
    }
    // 发送了礼物
    func sendGift(giftView: GiftView, giftModel: GiftPackageVM) {
        let giftCount = 1
        DispatchQueue.global().async {
            self.socket.sendGiftMsg(giftName: giftModel.subjectStr, giftUrl: giftModel.iconImageUrl!.absoluteString, giftCount: giftCount)
        }
        
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
        let chatToolY = endFrame.origin.y >= KSCREEN_H ? KSCREEN_H : endFrame.origin.y - KChatToolViewH
        let chatContentY = endFrame.origin.y >= KSCREEN_H ? KSCREEN_H - KChatToolViewH - KChatContentViewH : endFrame.origin.y - KChatToolViewH - KChatContentViewH
        UIView.animate(withDuration: duration) { 
            self.chatToolView.frame.origin.y = chatToolY
            self.chatContentView.frame.origin.y = chatContentY
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        chatToolView.inputTextField.resignFirstResponder()
        UIView.animate(withDuration: 0.25) { 
            self.giftView.frame.origin.y = KSCREEN_H
        }
    }
    
}

//MARK:- 收到即时消息
extension LiveRoomViewController: ZFSocketDelegate {
    func socket(_ socket: ZFSocket, joinRoom user: UserInfo) {
        let attriStr = AttriStringGenerator.joinOrLeaveRoomAttriString(userName: user.name, isJoin: true)
        chatContentView.insertMessage(attriStr)
    }
    func socket(_ socket: ZFSocket, leaveRoom user: UserInfo) {
        let attriStr = AttriStringGenerator.joinOrLeaveRoomAttriString(userName: user.name, isJoin: false)
        chatContentView.insertMessage(attriStr)
    }
    func socket(_ socket: ZFSocket, chatMsg: ChatMessage) {
        let attriStr = AttriStringGenerator.chatMessageAttriString(userName: chatMsg.user.name, chatText: chatMsg.text)
        chatContentView.insertMessage(attriStr)
    }
    func socket(_ socket: ZFSocket, giftMsg: GiftMessage) {
        let attriStr = AttriStringGenerator.giftMessageAttriString(userName: giftMsg.user.name, giftName: giftMsg.giftname, giftUrl: giftMsg.giftUrl)
        chatContentView.insertMessage(attriStr)
        let giftAniModel = ZFGiftAnimateModel(senderName: giftMsg.user.name, senderURL: giftMsg.user.iconUrl, giftName: giftMsg.giftname, giftURL: giftMsg.giftUrl)
        view.addSubview(giftContainnerView)

        giftContainnerView.showWithGiftAniModel(giftAniModel)
        
    }
}

//MARK:- 发送即时消息
extension LiveRoomViewController {
    fileprivate func addHeartBeatTimer() {
        heartTimer = Timer(fireAt: Date(), interval: 9, target: self, selector: #selector(headerBeat), userInfo: nil, repeats: true)
        RunLoop.main.add(heartTimer!, forMode: .commonModes)
    }
    @objc private func headerBeat() {
        socket.sendHeartBeat()
    }
    
}




