//
//  ChartToolView.swift
//  ZFLiveStreaming
//
//  Created by 周正飞 on 17/5/18.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit
protocol ChatToolViewDelegate: class {
    func toolViewSendClick(_ toolView: ChatToolView, _ message: String)
}
class ChatToolView: UIView, LoadNibable {

    @IBOutlet weak var sendButton: UIButton!
    
    @IBOutlet weak var inputTextField: UITextField!
    weak var delegate : ChatToolViewDelegate?
    fileprivate lazy var emotionButton: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
    
    fileprivate lazy var emotionView: EmotionView = EmotionView(frame: CGRect(x: 0, y: 0, width: KSCREEN_W, height: KEmotionViewH))
   
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
}

//MARK:- 设置UI
extension ChatToolView {
    fileprivate func setupUI() {
        emotionButton.setImage(UIImage(named: "chat_btn_emoji"), for: .normal)
        emotionButton.setImage(UIImage(named: "chat_btn_keyboard"), for: .selected)
        emotionButton.addTarget(self, action: #selector(emotionClick(_:)), for: .touchUpInside)
        inputTextField.rightView = emotionButton
        inputTextField.rightViewMode = .always
        inputTextField.allowsEditingTextAttributes = true
        
        // 点击键盘中的表情
        emotionView.emotionClicked = {[weak self] emotion in
            if emotion.emotionName.contains("delete") {
                self?.inputTextField.deleteBackward()
            } else {
                let inputRange = self?.inputTextField.selectedTextRange
                self?.inputTextField.replace(inputRange!, withText: emotion.emotionName)
                
            }
        }
        
    }
}

//MARK:- 事件响应
extension ChatToolView {
    // 发送按钮
    @IBAction func sendClick(_ sender: UIButton) {
        delegate?.toolViewSendClick(self, inputTextField.text!)
        inputTextField.text = nil
        
    }
    // 表情键盘切换按钮
    @objc fileprivate func emotionClick(_ button: UIButton) {
        button.isSelected = !button.isSelected
        let inputRange = inputTextField.selectedTextRange
        inputTextField.resignFirstResponder()
        inputTextField.inputView =  inputTextField.inputView == nil ?  emotionView :  nil
        inputTextField.becomeFirstResponder()
        inputTextField.selectedTextRange = inputRange
    }
    
    // 输入框内容变化
    @IBAction func editChanged(_ sender: UITextField) {
        sendButton.isEnabled = sender.text!.characters.count > 0
    }

}





