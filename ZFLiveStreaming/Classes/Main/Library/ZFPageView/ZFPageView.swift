//
//  ZFPageView.swift
//  ZFPageView
//
//  Created by 周正飞 on 17/5/10.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit
fileprivate let SCREEN_W: CGFloat = UIScreen.main.bounds.width
fileprivate let SCREEN_H: CGFloat = UIScreen.main.bounds.height

class ZFPageView: UIView {
    
    fileprivate let titles: [String]
    fileprivate let titleStyle: ZFPageStyle
    fileprivate let childControllers: [UIViewController]
    fileprivate let parentVC: UIViewController
    
    init(frame: CGRect, titles: [String], childControllers: [UIViewController], parentVC: UIViewController,style: ZFPageStyle = ZFPageStyle()) {
        self.titleStyle = style
        self.titles = titles
        self.childControllers = childControllers
        self.parentVC = parentVC
        super.init(frame: frame)
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

//MARK:- 设置UI
extension ZFPageView {
    fileprivate func setupUI() {
        // title
        let titleView = ZFTitleView(frame: CGRect(x: 0, y: 0, width: bounds.width,
                                    height: titleStyle.titleViewHeight),
                                    style: titleStyle,
                                    titles: titles)
        titleView.backgroundColor = UIColor.green
        addSubview(titleView)
        
        //内容
        let contentFrame = CGRect(x: 0, y: titleView.frame.maxY, width: bounds.width, height: bounds.height - titleView.bounds.height)
        let contentView = ZFContentView(frame:contentFrame,
                                        childControllers: childControllers,
                                        parentVC: parentVC)

        contentView.backgroundColor = UIColor.orange
        addSubview(contentView)
        
        //设置标题view和内容视图的关系
        titleView.delegage = contentView
        contentView.delegate = titleView
    }
}





