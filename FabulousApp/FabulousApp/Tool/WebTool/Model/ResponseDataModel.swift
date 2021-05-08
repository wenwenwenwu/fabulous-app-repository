//
//  ResponseDataModel.swift
//  Daoqi
//
//  Created by 邬文文 on 2021/5/6.
//

import Foundation

struct ResponseDataModel<T: Codable>: Codable {
    
    var data: T
    
}
