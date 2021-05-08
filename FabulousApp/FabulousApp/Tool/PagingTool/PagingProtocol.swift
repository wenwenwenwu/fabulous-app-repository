//
//  PagingProtocol.swift
//  FabulousApp
//
//  Created by 邬文文 on 2021/5/8.
//

import Foundation

protocol Paging: Codable {
    var page: Int { get set } //由pagingTool对象设置并提交后台
}

