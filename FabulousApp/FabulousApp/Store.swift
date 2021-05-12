//
//  Store.swift
//  BajieSleep
//
//  Created by 邬文文 on 2020/10/20.
//  Copyright © 2020 邬文文. All rights reserved.
//

import Foundation

struct Store {
    
    //MARK: - 动态
    private static let momentListPagingTool = PagingTool<MomentParaModel,MomentItemModel>()
    static func momentListPagingRequest(isFromStart: Bool, completion : @escaping ((Result<PagingResponseModel<MomentItemModel>,WebErrorModel>) -> Void)){
        let paraModel = MomentParaModel()
        momentListPagingTool.getPagingData(isFromStart: isFromStart, debug: false, httpMethod: .get, uri: "content/query", paraModel: paraModel, completion: completion)
    }
    
    //MARK: - 广场
    static func plazaInfoRequest(completion : @escaping (Result<PlazaModel,WebErrorModel>) -> Void){
        WebTool.request(debug: false, httpMethod: .get, uri: "collocation/getColInfo", paraModel: BlankRequestModel.default, responseModelType: PlazaModel.self, completion: completion)
    }
    
}





