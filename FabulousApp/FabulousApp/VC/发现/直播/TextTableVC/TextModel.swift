//
//  TextModel.swift
//  FabulousApp
//
//  Created by 邬文文 on 2021/5/31.
//

import Foundation

struct TextModel: Codable {
    
    init(text: String, isOpen: Bool = false) {
        self.text = text
        self.isOpen = isOpen
    }
    
    var text: String
    
    var isOpen: Bool
    
    var actualHeight: CGFloat {
        guard !text.isEmpty else { return rem(0) }
        let actualHeight = text.sizeWithAttributes(attributes: TextModel.attributes, fixedWidth: TextModel.textWidth).height
        return actualHeight
    }
    
    var foldHeight: CGFloat { 
        guard !text.isEmpty else { return rem(0) }
        let foldRowHeight = "一行文字".sizeWithAttributes(attributes: TextModel.attributes, fixedWidth: TextModel.textWidth).height
        let foldHeight = foldRowHeight  * TextModel.foldRowCount
        return foldHeight
    }
    
    //label的宽度为SCREEN_WIDTH - rem(40),但是label的文字还有默认的缩进rem(5)
    static let textWidth = SCREEN_WIDTH - rem(40) - rem(5)
    
    static let foldRowCount: CGFloat = 5
    
    static let attributes: [NSAttributedString.Key : Any] = [.font: FONT_14, .foregroundColor: UIColor.systemPink]
    
    static let openStr = " ...展开"
    
    static let foldStr = " 合上"
    
}

