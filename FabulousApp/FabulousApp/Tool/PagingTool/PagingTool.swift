//
//  PagingTool.swift
//  BajieSleep
//
//  Created by 邬文文 on 2020/10/20.
//  Copyright © 2020 邬文文. All rights reserved.
//

import Foundation
import Alamofire

let PAGE_SIZE = 10

//PagingTool是一个记录分页数据的工具模型
class PagingTool<ParaModel: Paging, ResponseModel: Codable> {
    
    //MARK: - Method
    func getPagingData(
        isFromStart:Bool,
        debug: Bool,
        httpMethod: HTTPMethod,
        uri: String,
        paraModel: ParaModel,
        completion : @escaping (Result<PagingResponseModel<ResponseModel>,WebErrorModel>) -> Void) {
        if isFromStart {
            //重置pageTool中的分页数据
            hasMore = true
            totalItems = []
            requestPage = 1
        }
        guard hasMore else {
            return
        }
        var actualParaModel = paraModel
        actualParaModel.pageNum = String(requestPage)
        WebTool.request(debug: debug, showHud: false, httpMethod: httpMethod, uri: uri, paraModel: actualParaModel, responseModelType: RawPagingResponseModel<ResponseModel>.self) { (result) in
            switch result {
            case .success(let dataModel):
                //防止分页请求发起太快，requestPage还未增加
                guard Int(dataModel.current)! == self.requestPage else { return }
                //记录分页数据
                self.hasMore = (Int(dataModel.current)! < Int(dataModel.pages)!)
                self.totalItems += dataModel.records
                self.requestPage += 1
                //创建返回数据
                let responseModel = PagingResponseModel(
                    totalItems: self.totalItems,
                    items: dataModel.records,
                    currentPage: Int(dataModel.current)!,
                    totalPage: Int(dataModel.pages)!,
                    totalCount: Int(dataModel.total)!,
                    isEmpty: self.totalItems.isEmpty,
                    hasMore: self.hasMore
                )
                completion(Result.success(responseModel))
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
    
    //MARK: - Data
    var totalItems:[ResponseModel] = []
    var requestPage = 1
    var hasMore = true
    
}




