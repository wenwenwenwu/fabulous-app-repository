//
//  MomentModel.swift
//  FabulousApp
//
//  Created by 邬文文 on 2021/5/10.
//

import Foundation

struct MomentItemModel: Codable {
    
    var createTime: String
    var updateTime: String
    var status: Int
    var id: String
    var title: String?
    var content: String
    var urls: String
    var userId: String
    var cover: MomentItemCoverItemModel
    var typeCode: String
    var likes: Int
    var typeIds: Int
    var tagIds: String?
    var location: String?
    var collCount: Int
    var commentCount: Int
    var shareCount: Int
    var readCount: Int
    var hot: Int
    var collect: Bool
    var cTags: [MomentItemTagItemModel]
    var type: String
    var like: Bool

}

struct MomentItemCoverItemModel: Codable {
    
    var url: String
    var width: Int
    var height: Int
    
}

struct MomentItemTagItemModel: Codable {
    
    var createTime: String?
    var updateTime: String?
    var id: Int
    var title: String
    var momentCount: Int?
    var queryCount: Int?
    
}

