//
//  String.swift
//  BajieSleep
//
//  Created by 邬文文 on 2020/10/23.
//  Copyright © 2020 邬文文. All rights reserved.
//

import Foundation

extension String {
    
    func combinedAttributesString(attr1: [NSAttributedString.Key: Any], attri2: [NSAttributedString.Key: Any], attr2Range: NSRange) -> NSAttributedString {
        let attrStr = NSMutableAttributedString(string: self, attributes: attr1)
        attrStr.addAttributes(attri2, range: attr2Range)
        return attrStr
    }
    
    
    func heightWithStringAttributes(attributes : [NSAttributedString.Key : Any], fixedWidth : CGFloat) -> CGFloat {
        guard count > 0 && fixedWidth > 0 else { return 0 }
        let size = CGSize.init(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude)
        let rect = self.boundingRect(with: size, options:[.usesLineFragmentOrigin], attributes: attributes, context:nil)
        return rect.height
    }
    
}
