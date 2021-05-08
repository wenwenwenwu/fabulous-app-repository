//
//  PagingResponseModel.swift
//  Daoqi
//
//  Created by 邬文文 on 2021/5/6.
//

import Foundation

struct PagingResponseModel<T: Codable>: Codable {
   
    var totalItems: [T]
    var items: [T]
    var currentPage: Int
    var totalPage: Int
    var totalCount: Int
    var isEmpty: Bool
    var hasMore: Bool
    var description: String {
        "currentPage:\(currentPage), totalPage:\(totalPage), totalCount:\(totalCount)"
    }
    
}
