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
    
    var isOpen = false
    
    var actualHeight: CGFloat {
        guard !text.isEmpty else { return rem(0) }
        return text.heightWithStringAttributes(attributes: TextModel.attributes, fixedWidth: TextModel.width)
    }
    
    var foldHeight: CGFloat { //五行的高度
        guard !text.isEmpty else { return rem(0) }
        return String().heightWithStringAttributes(attributes: TextModel.attributes, fixedWidth: TextModel.width * TextModel.foldRowCount)
    }
    
    static let width = SCREEN_WIDTH - rem(40)
    
    static let foldRowCount: CGFloat = 5
    
    static let attributes: [NSAttributedString.Key : Any] = [.font: FONT_14, .foregroundColor: UIColor.orange]
    
    static let openStr = "...展开"
    
    static let foldStr = "合上"
    
}

