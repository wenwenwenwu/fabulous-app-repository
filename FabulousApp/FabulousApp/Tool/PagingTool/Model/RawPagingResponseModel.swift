//
//  RawPagingResponseModel.swift
//  Daoqi
//
//  Created by 邬文文 on 2021/5/6.
//

import Foundation

struct RawPagingResponseModel<T: Codable>: Codable {
    
    var records:[T]
    var total: String //总条数
    var size: String //每页
    var current: String //当前页数
    var pages: String //总页数
    
}
