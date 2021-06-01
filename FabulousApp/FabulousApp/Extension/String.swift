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

extension String {
     
    //Range转换为NSRange
    func nsRange(from range: Range<String.Index>) -> NSRange {
        let from = range.lowerBound.samePosition(in: utf16)!
        let to = range.upperBound.samePosition(in: utf16)!
        return NSRange(location: utf16.distance(from: utf16.startIndex, to: from),
                       length: utf16.distance(from: from, to: to))
    }
     
    //Range转换为NSRange
    func range(from nsRange: NSRange) -> Range<String.Index>? {
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location,
                                     limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: nsRange.length,
                                   limitedBy: utf16.endIndex),
            let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self)
            else { return nil }
        return from ..< to
    }
}
