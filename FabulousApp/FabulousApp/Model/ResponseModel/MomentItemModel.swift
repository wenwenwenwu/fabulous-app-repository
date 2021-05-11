//
//  MomentModel.swift
//  FabulousApp
//
//  Created by 邬文文 on 2021/5/10.
//

import Foundation

struct MomentItemModel: Codable {
        
    var id: String
    var title: String?
    var content: String?
    var cover: MomentItemCoverItemModel
    var user: MomentItemUserModel
    

}

struct MomentItemCoverItemModel: Codable {
    
    var url: String
    var width: CGFloat
    var height: CGFloat
    
    var realURL: URL? {
        return URL(string: url)
    }
    
    var heightWidthRatio: CGFloat {
        return width == 0 ? 1 : height / width
    }
}

struct MomentItemUserModel: Codable {
    
    var avatar: String
    var nickname: String
    
    var avatarURL: URL? {
        return URL(string: avatar)
    }
}

