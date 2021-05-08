//
//  LoginInfoModel.swift
//  BajieSleep
//
//  Created by 邬文文 on 2020/8/18.
//  Copyright © 2020 邬文文. All rights reserved.
//

import Foundation

struct LoginInfoModel: Codable {
    
    var token: String
    var uid: Int
    var userType: Int
    var supply: Bool
    var payment: Int
    
    
}

