//
//  Extension.swift
//  MorningHeadline
//
//  Created by wuwenwen on 2017/11/23.
//  Copyright © 2017年 wenwenwenwu. All rights reserved.
//

import UIKit

extension UIButton {

    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let newBounds = modifyBounds()
        return newBounds.contains(point)
    }
    
    //将接触面积不到44 * 44的变为44 * 44(iOS人机交互规范里面规定的最小点触面积)
    private func modifyBounds() -> CGRect {
        let bounds = self.bounds
        let widthDelta = 44.0 - bounds.size.width
        let heightDelta = 44.0 - bounds.size.height
        let isSmallButton = widthDelta>0 && heightDelta>0
        if isSmallButton {
            //insetBy方法返回CGRect,默认中心不变,缩进dx和dy。
            let newBounds = bounds.insetBy(dx: -0.5 * widthDelta, dy: -0.5 * heightDelta)
            return newBounds
        } else {
            return bounds
        }
    }
    
}



