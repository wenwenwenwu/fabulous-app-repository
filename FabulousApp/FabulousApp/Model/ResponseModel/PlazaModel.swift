//
//  PlazaModel.swift
//  FabulousApp
//
//  Created by 邬文文 on 2021/5/12.
//

import Foundation

struct PlazaModel: Codable {
    
    var needs: PlazaItemModel<PlazaNeedsInfoItemModel>
    var publish: PlazaItemModel<PlazaPublishInfoItemModel>
    var styleWoman: PlazaItemModel<PlazaWomanInfoItemModel>
    var styleMan: PlazaItemModel<PlazaManInfoItemModel>
    var blogger: PlazaBloggerModel
    var oUser: PlazaItemModel<PlazaOUserInfoItemModel>

}

struct PlazaItemModel<T: Codable>: Codable {
    
    var name: String
    var info: [T]
    
}

struct PlazaNeedsInfoItemModel: Codable {
    
        var id: String
        var name: String
        var type: String
        var extProps: PlazaNeedsInfoItemExtPropModel
        var extValue: String
        var remark: String?

}

struct PlazaNeedsInfoItemExtPropModel: Codable {
    
    var man: String
    var woman: String
    
    var manURL: URL? {
        return URL(string: man)
    }
    
    var womanURL: URL? {
        return URL(string: woman)
    }

}

struct PlazaPublishInfoItemModel: Codable {
    
        var id: String
        var name: String
        var type: String
        var extProps: PlazaPublishInfoItemExtPropModel
        var remark: String

}

struct PlazaPublishInfoItemExtPropModel: Codable {
    
    var icon: String
    
    var iconURL: URL? {
        return URL(string: icon)
    }
    
}

struct PlazaWomanInfoItemModel: Codable {
    
        var id: String
        var name: String
        var brief: String
        var type: String
        var extProps: PlazaPublishInfoItemExtPropModel
        var extValue: String
        var remark: String

}

struct PlazaManInfoItemModel: Codable {
    
        var id: String
        var name: String
        var sex: String
        var type: String
        var extProps: PlazaPublishInfoItemExtPropModel
        var extValue: String
        var remark: String

}

struct PlazaBloggerModel: Codable {
    
    var womanBlogger: String
    var manBlogger: String
    
    var womanBloggerURL: URL? {
        return URL(string: womanBlogger)
    }
    
    var manBloggerURL: URL? {
        return URL(string: manBlogger)
    }
}

struct PlazaOUserInfoItemModel: Codable {
    
    var id: String
    var nickname: String
    var avatar: String
    var roles: String
    var roleName: [String]
    
    var avatarURL: URL? {
        return URL(string: avatar)
    }
    
}

