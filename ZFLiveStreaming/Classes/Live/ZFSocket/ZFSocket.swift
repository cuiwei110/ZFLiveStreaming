//
//  ZFSocket.swift
//  SocketClientDemo
//
//  Created by 周正飞 on 17/5/22.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import Foundation
/*
    IM 核心类
    1: 连接服务器,遵守代理后接收服务器返回的消息
    2: 向服务器发送 文本/礼物/进入房间/退出房间的即时消息
 
 */

/*
 发送消息时参数type代表含义
 进入房间: 0
 离开房间: 1
 文本: 2
 礼物: 3
 */


protocol ZFSocketDelegate: class {
    func socket(_ socket: ZFSocket, joinRoom user: UserInfo)
    func socket(_ socket: ZFSocket, leaveRoom user: UserInfo)
    func socket(_ socket: ZFSocket, chatMsg : ChatMessage)
    func socket(_ socket: ZFSocket, giftMsg : GiftMessage)

}

class ZFSocket {
    var client: TCPClient
    weak var delegate: ZFSocketDelegate?
    // 固定的用户信息
    fileprivate var userinfo: UserInfo.Builder = {
       let userinfo = UserInfo.Builder()
        userinfo.name = "周正飞"
        userinfo.level = 100
        userinfo.iconUrl = UserIconURL
        return userinfo
    }()
    init(addr: String, port: Int) {
        client =  TCPClient(addr: addr, port: port)
    }
    
}
extension ZFSocket {
    @discardableResult
    func connectServer() -> Bool {
       return client.connect(timeout: 5).0
    }

    //时刻接受服务器发来的消息
    func startReadMsg() {
        DispatchQueue.global().async {
            while true {
                if let lengthMsg =  self.client.read(4) {
                    //1. 获取消息的长度
                    let lengthData = Data(bytes: lengthMsg)
                    var length = 0
                    (lengthData as NSData).getBytes(&length, length: 4)
                    
                    //2. 根据消息的类型
                    if let typeByes = self.client.read(2) {
                        let typeData = Data(bytes: typeByes)
                        var type = 0
                        (typeData as NSData).getBytes(&type, length: 2)
                        
                        guard let msg = self.client.read(length) else { return }
                        let msgData = Data(bytes: msg)
                        DispatchQueue.main.async {  //回到主线程处理
                            self.handleMsg(type: type, message: msgData)
                        }
                    }
                }
            }
        }
    }
    fileprivate func handleMsg(type: Int, message: Data) {
        switch type {
        case 0:
            let userinfo = try! UserInfo.parseFrom(data: message)
            delegate?.socket(self, joinRoom: userinfo)
        case 1:
            let userinfo = try! UserInfo.parseFrom(data: message)
            delegate?.socket(self, leaveRoom: userinfo)
        case 2:
            let chatMessage = try! ChatMessage.parseFrom(data: message)
            delegate?.socket(self, chatMsg: chatMessage)
        case 3:
            let giftMessage = try! GiftMessage.parseFrom(data: message)
            delegate?.socket(self, giftMsg: giftMessage)
        case 100:
            break
        default:
            print("未知类型")
        }
    }
}
//MARK:- 往服务器发送消息
extension ZFSocket {
    func sendJoinRoom() {
        let msgData = (try! userinfo.build()).data()
        sendMsgToServer(data: msgData, type: 0)
    }
    
    func sendLeaveRoom() {
        let msgData = (try! userinfo.build()).data()
        sendMsgToServer(data: msgData, type: 1)
    }
    
    func sendTextMsg(text: String) {
        let chatMsg = ChatMessage.Builder()
        chatMsg.user = (try! userinfo.build())
        chatMsg.text = text
        let msgData = (try! chatMsg.build()).data()
        sendMsgToServer(data: msgData, type: 2)
    }
   
    func sendGiftMsg(giftName: String, giftUrl: String, giftCount: Int){
        let giftMsg = GiftMessage.Builder()
        giftMsg.user = (try! userinfo.build())
        giftMsg.giftname = giftName
        giftMsg.giftUrl = giftUrl
        giftMsg.giftcount = Int32(giftCount)
        let msgData = (try! giftMsg.build()).data()
        sendMsgToServer(data: msgData, type: 3)
    }
    func sendHeartBeat() {
        let heart = "Boom"
        sendMsgToServer(data: heart.data(using: .utf8)!, type: 100)
    }
    
    private func sendMsgToServer(data:Data, type: Int) {

        // 消息长度
        var length = data.count
        let lengthData = Data(bytes: &length, count: 4)
        //消息类型
        var type = type
        let typeData = Data(bytes: &type, count: 2)
        
        //总消息
        let totalData = lengthData + typeData + data
        client.send(data: totalData)
    }
}


