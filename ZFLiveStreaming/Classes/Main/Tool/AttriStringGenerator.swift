//
//  AttriStringGenerator.swift
//  ZFLiveStreaming
//
//  Created by 周正飞 on 17/5/24.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit
import Kingfisher

/*
  富文本生成器.直播间发送即时消息的代码抽取
 */
class AttriStringGenerator{
    
    // 加入/离开房间
    class func joinOrLeaveRoomAttriString(userName: String, isJoin: Bool) -> NSAttributedString {
        let messageStr = userName + (isJoin ? " 加入了房间" : " 离开了房间")
        let attriStr = NSMutableAttributedString(string: messageStr)
        attriStr.addAttributes([NSForegroundColorAttributeName: KMAINButtonColor], range: NSRange(location: 0, length: userName.characters.count))
        return attriStr
    }
    
    // 发送聊天消息
    class func chatMessageAttriString(userName: String, chatText: String) -> NSAttributedString {
        
        let chatMessageStr = userName + ": " + chatText
        let attributeStr = NSMutableAttributedString(string: chatMessageStr)
        // 名字添加颜色
        attributeStr.addAttributes([NSForegroundColorAttributeName:KMAINButtonColor], range: NSRange(location: 0, length: userName.characters.count))

        // 匹配表情[哈哈]
        let pattern = "\\[.*?\\]"
        if let regex = try? NSRegularExpression(pattern: pattern, options: []) {
            let results = regex.matches(in: chatMessageStr, options: [], range: NSRange(location: 0, length: chatMessageStr.characters.count))
            for result in results.reversed() {
                let emotionName =  (chatMessageStr as NSString).substring(with: result.range)
                guard let emotionImage = UIImage(named: emotionName) else {
                    continue
                }
                let emotionAttacthment = NSTextAttachment()
                emotionAttacthment.image = emotionImage
                emotionAttacthment.bounds = CGRect(x: 0, y: -3, width: KLiveRoomNormalFont.lineHeight, height: KLiveRoomNormalFont.lineHeight)
                let emotionAttri = NSAttributedString(attachment: emotionAttacthment)
                attributeStr.replaceCharacters(in: result.range, with: emotionAttri)
            }
        }
        return attributeStr
    }
    
    class func giftMessageAttriString(userName: String, giftName: String, giftUrl: String) -> NSAttributedString {
        let giftMsgStr = userName + " 送给主播一个 " + giftName + " "
        let attributeStr = NSMutableAttributedString(string: giftMsgStr)
        
        // 名字添加颜色
        attributeStr.addAttributes([NSForegroundColorAttributeName:KMAINButtonColor], range: NSRange(location: 0, length: userName.characters.count))
        let giftNameRange = (giftMsgStr as NSString).range(of: giftName)
        
        // 礼物名字添加颜色
        attributeStr.addAttributes([NSForegroundColorAttributeName:UIColor.cyan], range: giftNameRange)
        
        // 添加礼物图片
        let giftAttachment = NSTextAttachment()
        let giftImage = KingfisherManager.shared.cache.retrieveImageInMemoryCache(forKey: giftUrl)
        giftAttachment.image = giftImage
        giftAttachment.bounds = CGRect(x: 5, y: -3, width: KLiveRoomNormalFont.lineHeight, height: KLiveRoomNormalFont.lineHeight)
        let giftAttriStr = NSAttributedString(attachment: giftAttachment)
        attributeStr.append(giftAttriStr)
        
        return attributeStr
    }
}
