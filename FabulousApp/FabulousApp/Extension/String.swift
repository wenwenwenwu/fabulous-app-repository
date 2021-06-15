//
//  String.swift
//  BajieSleep
//
//  Created by 邬文文 on 2020/10/23.
//  Copyright © 2020 邬文文. All rights reserved.
//

import Foundation

extension String {
    
    func sizeWithAttributes(attributes : [NSAttributedString.Key : Any], fixedWidth : CGFloat = CGFloat.greatestFiniteMagnitude) -> CGSize {
        guard count > 0 else { return .zero }
        let size = CGSize.init(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude)
        let rect = self.boundingRect(with: size, options:[.usesLineFragmentOrigin], attributes: attributes, context:nil)
        return rect.size
    }
   
}
