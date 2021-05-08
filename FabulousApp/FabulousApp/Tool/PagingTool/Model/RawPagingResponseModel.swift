//
//  RawPagingResponseModel.swift
//  Daoqi
//
//  Created by 邬文文 on 2021/5/6.
//

import Foundation

struct RawPagingResponseModel<T: Codable>: Codable {
    
    var data:[T]
    var last_page: Int //总页数
    var current_page: Int //当前页数
    var total: Int //总条数
    
}
