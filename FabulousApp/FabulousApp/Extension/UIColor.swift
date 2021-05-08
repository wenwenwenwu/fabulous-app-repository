//
//  UIColor.swift
//  BajieSleep
//
//  Created by 邬文文 on 2020/8/13.
//  Copyright © 2020 邬文文. All rights reserved.
//

import UIKit

extension UIColor {
    
    func colorImage() -> UIImage {
        let rect = CGRect.init(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        let ctx = UIGraphicsGetCurrentContext()
        ctx?.setFillColor(cgColor)
        ctx?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()//size为(1,1)的矢量图
        return image!
    }
}
