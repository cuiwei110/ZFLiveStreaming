//
//  ChatContentView.swift
//  ZFLiveStreaming
//
//  Created by 周正飞 on 17/5/24.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit
private let cellID = "cellID"
class ChatContentView: UIView {
    fileprivate lazy var tableView = UITableView()
    fileprivate lazy var messageArr = [NSAttributedString]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
//MARK:- 设置UI
extension ChatContentView {
    fileprivate func setupUI() {
        tableView = UITableView(frame: bounds, style: .plain)
        tableView.backgroundColor = UIColor.clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(UINib(nibName: "ChatContentCell", bundle: nil), forCellReuseIdentifier: cellID)
        addSubview(tableView)
    }
}
//MARK:- 对外提供的添加消息方法
extension ChatContentView {
    func insertMessage(_ message: NSAttributedString) {
        messageArr.append(message)
        tableView.reloadData()
        //滚动到最后一行
        let lastIndexPath = IndexPath(row: messageArr.count - 1, section: 0)
        tableView.scrollToRow(at: lastIndexPath, at: .bottom, animated: false)
    }
}
//MARK:- 数据源
extension ChatContentView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! ChatContentCell
        cell.contentLabel.attributedText = messageArr[indexPath.row]
        
        return cell
    }
}






