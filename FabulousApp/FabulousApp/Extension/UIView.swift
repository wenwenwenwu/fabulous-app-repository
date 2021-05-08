//
//  View.swift
//  MorningHeadline
//
//  Created by wuwenwen on 2017/12/29.
//  Copyright © 2017年 wenwenwenwu. All rights reserved.
//

import UIKit

extension UIView {
    func removeAllSubviews() {
        subviews.forEach{$0.removeFromSuperview()}
    }
}

extension UIView {
    
    //MARK: - 添加圆角
    func addCorner(cornerRadius: CGFloat) {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
    }
    
    //MARK: - 添加边框
    func addBorder(color: UIColor, width: CGFloat) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }
    
    //MARK: - 添加阴影
    func addShadow(color: UIColor, radius: CGFloat, offset: CGSize, opacity: Float) {
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOffset = CGSize.init(width: offset.width, height: offset.height)
        layer.shadowOpacity = opacity
        layer.masksToBounds = false
    }
}

extension UIView {
    
    var x : CGFloat {
        get {
            frame.origin.x
        }
        set(newVal) {
            var tmpFrame : CGRect = frame
            tmpFrame.origin.x     = newVal
            frame                 = tmpFrame
        }
    }
    
    var y : CGFloat {
        get {
            frame.origin.y
        }
        set(newVal) {
            var tmpFrame : CGRect = frame
            tmpFrame.origin.y     = newVal
            frame                 = tmpFrame
        }
    }
    
    var height : CGFloat {
        get {
            frame.size.height
        }
        set(newVal) {
            var tmpFrame : CGRect = frame
            tmpFrame.size.height  = newVal
            frame                 = tmpFrame
        }
    }
    
    var width : CGFloat {
        get {
            frame.size.width
        }
        set(newVal) {
            var tmpFrame : CGRect = frame
            tmpFrame.size.width   = newVal
            frame                 = tmpFrame
        }
    }
    
    var left : CGFloat {
        get {
            x
        }
        set(newVal) {
            x = newVal
        }
    }
    
    var right : CGFloat {
        get {
            x + width
        }
        set(newVal) {
            x = newVal - width
        }
    }
    
    var top : CGFloat {
        get {
            y
        }
        set(newVal) {
            y = newVal
        }
    }

    var bottom : CGFloat {
        get {
            y + height
        }
        set(newVal) {
            y = newVal - height
        }
    }
    
    var centerX : CGFloat {
        get {
            center.x
        }
        set(newVal) {
            center = CGPoint(x: newVal, y: center.y)
        }
    }
    
    var centerY : CGFloat {
        get {
            center.y
        }
        set(newVal) {
            
            center = CGPoint(x: center.x, y: newVal)
        }
    }
    
    var middleX : CGFloat {
        get {
            width / 2
        }
    }
    
    var middleY : CGFloat {
        get {
            height / 2
        }
    }
    
    var middlePoint : CGPoint {
        get {
            CGPoint(x: middleX, y: middleY)
        }
    }
}
