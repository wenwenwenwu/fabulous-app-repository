//
//  Constant.swift
//  ChunXi
//
//  Created by wuwenwen on 2018/4/9.
//  Copyright © 2018年 wenwenwenwu. All rights reserved.
//

import UIKit
import SnapKit

//MARK: - 全局对象常量
let APP_DELEGATE = UIApplication.shared.delegate as! AppDelegate
let KEY_WINDOW = UIApplication.shared.windows.first(where: { $0.isKeyWindow })!
let MAIN_VC = TabBarVC()

//MARK: - 尺寸常量
let SCREEN_BOUNDS: CGRect = UIScreen.main.bounds
let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT: CGFloat = UIScreen.main.bounds.size.height

//MARK: - 颜色常量
let WHITE_FFFFFF = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
let GRAY_F0F0F0 = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
let GRAY_666666 = #colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
let BLACK_000000 = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)



//MARK: - 字体常量
let FONT_12 = UIFont.systemFont(ofSize: rem(12))
let FONT_14 = UIFont.systemFont(ofSize: rem(14))


//MARK: - 通知常量
extension Notification.Name{
    
    static var UPDATE_PROGRESS_LIST: Notification.Name {
        Notification.Name("updateProgressList")
    }
    
}

//MARK: - 业务常量








