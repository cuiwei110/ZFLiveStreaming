//
//  EmitterAnimate.swift
//  ZFLiveStreaming
//
//  Created by 周正飞 on 17/5/16.
//  Copyright © 2017年 周正飞. All rights reserved.
//

import UIKit

/// 提供粒子动画的协议
protocol EmitterAnimate {
    
}

extension EmitterAnimate where Self: UIViewController{
    
    func startEmitter(_ point: CGPoint){
        let emitter = CAEmitterLayer()
        emitter.emitterPosition = point
        emitter.preservesDepth = true //三维效果
        
        var cells = [CAEmitterCell]()
        for i in 0 ..< 5{
            let cell = CAEmitterCell()
            
            // 速度
            cell.velocity = 150
            cell.velocityRange = 100
            
            //方向
            cell.emissionLongitude = -(CGFloat)(M_PI_2)
            cell.emissionRange = CGFloat(M_PI_2 * 0.2)
            
            //弹出个数
            cell.birthRate = 4
            
            // 生命
            cell.lifetime = 3
            cell.lifetimeRange = 1.5
            
            // 透明度
            cell.alphaSpeed = -0.4
            
            // 大小
            cell.scale = 0.7
            cell.scaleRange = 0.2
        
            cell.contents = UIImage(named: "good\(i)_30x30")?.cgImage
            cells.append(cell)
        }
        emitter.emitterCells = cells
        view.layer.addSublayer(emitter)
    }
    
    func stopEmitter() {
        view.layer.sublayers?.filter({ $0.isKind(of: CAEmitterLayer.self)}).first?.removeFromSuperlayer()
    }
    
}
