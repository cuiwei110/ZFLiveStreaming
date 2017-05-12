//
//  HomeViewController.swift
//  ZFLiveStreaming
//
//  Created by 周正飞 on 17/5/9.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }
    
}

//MARK:- 设置UI界面
extension HomeViewController {
    fileprivate func setupUI() {
        setupNavigationBar()
        setupContentView()
    }
    
    /// 设置导航栏
   private func setupNavigationBar() {
    let leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "home-logo"),
                                            style: .plain,
                                            target: self, action: nil)
    leftBarButtonItem.isEnabled = false

    navigationItem.leftBarButtonItem = leftBarButtonItem
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "search_btn_follow"),
                                                        style: .plain,
                                                        target: self,
                                                        action: #selector(favoriteItemClick))
    
    let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 200, height: 32))
    searchBar.placeholder = "主播昵称/房间号/链接"
    searchBar.searchBarStyle = .minimal
    let searchField = searchBar.value(forKey: "_searchField") as? UITextField
    searchField?.textColor = UIColor.white
    navigationItem.titleView = searchBar
    }
    /// 添加pageView
    
    private func setupContentView() {
        let frame = CGRect(x: 0, y: 64, width: SCREEN_W, height: SCREEN_H - 64)
        let types = loadTypes()
        let titles = types.map{ $0.title }
        var childVcs = [UIViewController]()
        for i in 0 ..< titles.count {
            childVcs.append(AnchorViewController(type: types[i]))
        }
        let pageView = ZFPageView(frame: frame,
                                  titles: titles,
                                  childControllers: childVcs,
                                  parentVC: self,
                                  style: ZFPageStyle())
        view.addSubview(pageView)
    }
    
}
//MARK:- 请求数据
extension HomeViewController {
    fileprivate func loadTypes() -> [HomeType] {
        var typesArr = [HomeType]()
        let dataPath = Bundle.main.path(forResource: "types", ofType: "plist")!
      
        let dataArr = NSArray(contentsOfFile: dataPath) as! [[String: AnyObject]]
        for dict in dataArr {
             typesArr.append(HomeType(dict: dict))
        }
        return typesArr
    }
}

//MARK:- 事件响应
extension HomeViewController {
    @objc fileprivate func favoriteItemClick() {
        
    }
}






