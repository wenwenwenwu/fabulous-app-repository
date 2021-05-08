//
//  ValidateToolEnum.swift
//  BajieSleep
//
//  Created by 邬文文 on 2020/9/24.
//  Copyright © 2020 邬文文. All rights reserved.
//

import Foundation

enum ValidateTool {
    case phoneNumber(_:String)
    case characterAndNumber(_:String)
    case idCard(_: String)
    
    var isValid: Bool {
        var regularExpression: String! //正则表达式
        var value: String! //待校验值
        switch self {
        case let .phoneNumber(str):
            regularExpression = "^(13[0-9]|14[5|6|7|8|9]|15[0|1|2|3|5|6|7|8|9]|16[2|5|6|7]|17[0|1|2|3|5|6|7|8]|18[0-9]|19[0|1|2|3|5|6|7|8|9])+\\d{8}$"
            value = str
        case let .characterAndNumber(str):
            regularExpression = "^[A-Za-z0-9]+$"
            value = str
        case let .idCard(str):
            regularExpression = "^(\\d{15}$|^\\d{18}$|^\\d{17}(\\d|X|x))$"
            value = str
        }
        //谓词。可以根据正则表达式对值进行校验
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return predicate.evaluate(with: value)        
    }
}
