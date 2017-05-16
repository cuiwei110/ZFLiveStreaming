//
//  AnchorListVM.swift
//  ZFLiveStreaming
//
//  Created by 周正飞 on 17/5/12.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit
import YYModel
import SVProgressHUD
class AnchorListVM: NSObject {
    var anchorVMs =  [AnchorVM]()

}

//MARK:- 请求数据
extension AnchorListVM {
    
    func loadData(type: HomeType, index: Int, finished: @escaping (_ isSuccess: Bool)->() ) {
        NetworkTool.shareInstance.loadHomeAnchorData(type: type, index: index) { (dict, error) in
            // 错误校验
            guard error == nil else{
                SVProgressHUD.showError(withStatus: "请求出错")
                finished(false)
                return
            }
            guard let rootDict = dict else {
                finished(false)
                return
            }
            let messageDict = rootDict["message"] as! [String: Any]
            let anchorDictArr = messageDict["anchors"] as! [[String: Any]]
            let anchorArr = NSArray.yy_modelArray(with: AnchorModel.self, json: anchorDictArr) as![AnchorModel]
            //ViewModel数组赋值
            self.anchorVMs = anchorArr.map{ AnchorVM(anchor: $0) }
            finished(true)
    
        }
    }
}
