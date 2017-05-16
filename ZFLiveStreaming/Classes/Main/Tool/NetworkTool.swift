//
//  NetworkTool.swift
//  ZFLiveStreaming
//
//  Created by 周正飞 on 17/5/12.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import Foundation
import Alamofire
enum requestMethod : Int{
    case GET = 0
    case POST = 1
}

typealias NetworkCompletion = (_ responseJSON: [String: AnyObject]?, _ error: Error?) ->()

class NetworkTool {
    
    static let shareInstance = NetworkTool()
    private init(){
        
    }
     func request(url: String, method: requestMethod , parameters:[String: Any]?, completion:  @escaping NetworkCompletion){
        let getOrPost = method.rawValue
        Alamofire.request(url, method: getOrPost == 0 ? .get : .post, parameters: parameters).responseJSON { responseJSON in

            let result = responseJSON.result
            // result 枚举中有 存JSON的result.value 和 成功与否的error/isSuccess
            
            guard let resultDict = result.value else {
                completion(nil, result.error)
                return
            }
            completion(resultDict as? [String : AnyObject], result.error)
        }

    }
}

//MARK:- 具体请求
extension NetworkTool {
    /// 加载首页直播数据
    func loadHomeAnchorData(type: HomeType, index: Int, _ completion:@escaping NetworkCompletion) {
        let urlString = HOME_Anchor_URL
        let parameters = ["type": type.type,
                          "index": index,
                          "size": 48] as [String : Any]
        request(url: urlString, method: .GET, parameters: parameters, completion: completion)
    }
}






