//
//  AccountTool.swift
//  BajieSleep
//
//  Created by 邬文文 on 2020/8/13.
//  Copyright © 2020 邬文文. All rights reserved.
//

import Foundation

class AccountTool {

    //MARK: - Method
    static func saveLoginInfo(_ loginInfoModel: LoginInfoModel) {
        CacheTool.save(value: loginInfoModel, forKey: .loginInfo)
    }
    
    static func deleteLoginInfo() {
        CacheTool.delete(forKey: .loginInfo)
    }
    
    //MARK: - Data
    static var loginInfo: LoginInfoModel? {
        if let loginInfoModel = CacheTool.retrieve(valueType: LoginInfoModel.self, forKey: .loginInfo) {
            return loginInfoModel
        }else {
            return nil
        }
    }

    static var isLogin: Bool {
        loginInfo != nil
    }
    
}

