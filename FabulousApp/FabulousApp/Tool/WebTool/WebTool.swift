//
//  WebTool.swift
//  BajieManage
//
//  Created by 邬文文 on 2021/2/24.
//

import Foundation
import Alamofire

let BASE_URL = (IS_DISTRIBUTION) ? "https://api.apuxiao.com/pig/v1/cms/" : "https://api.apuxiao.com/pig/v1/cms/"

class WebTool {
    
    //MARK: - 请求数据
    static func request<ParaModel: Codable, ResponseModel: Codable>(debug: Bool = false, httpMethod: HTTPMethod, uri: String, paraModel: ParaModel, responseModelType: ResponseModel.Type, completion : @escaping (Result<ResponseModel,WebErrorModel>) -> Void)  {
        //通过UI加锁
        HudTool.showHud()
        //请求
        var headers: HTTPHeaders?
        headers = [
            "t-token":"6113705e8c81e65f648dadd4cf2c9ebd",
        ]
        AF.request(BASE_URL + uri,
                   method: httpMethod,
                   parameters: paraModel,
                   encoder: httpMethod == .post ? JSONParameterEncoder.default : URLEncodedFormParameterEncoder.default,
                   headers: headers)            
            .responseJSON
            { response in
                //通过UI解锁
                HudTool.dismissHud()
                //处理返回数据并回调
                self.handleResponse(debug: debug, response: response, completion: completion)
            }
    }
    
    //MARK: - 上传
    static func uploadFile<ResponseModel: Codable>(debug: Bool = false, uri: String, fileURL: URL, completion : @escaping (Result<ResponseModel, WebErrorModel>) -> Void){
        //通过UI加锁
        HudTool.showHud()
        //请求
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(fileURL, withName: "file")
        }, to: BASE_URL + uri)
        .responseJSON(completionHandler: { response in
            //通过UI解锁
            HudTool.dismissHud()
            //处理返回数据并回调
            self.handleResponse(debug: debug, response: response, completion: completion)
        })
    }
    
    //MARK: - 下载
    static func downloadFile(urlStr: String, fileName: String, completion: @escaping (URL)->Void) {
        let filePath = BASE_URL + urlStr
        let fileName = fileName
        let destination: DownloadRequest.Destination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent(fileName)
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        //progressHud
        let progressHud = MBProgressHUD.showAdded(to: KEY_WINDOW, animated: true)
        progressHud.mode = MBProgressHUDMode.determinateHorizontalBar
        progressHud.removeFromSuperViewOnHide = true
        //download
        AF.download(URL(string: filePath)!, to: destination)
            .downloadProgress { progress in
                progressHud.progress = Float(progress.fractionCompleted)
            }.responseURL { (response) in
                progressHud.hide(animated: true)
                guard let fileURL = response.fileURL else {
                    HudTool.showInfoHud("文件保存出错")
                    return
                }
                completion(fileURL)
            }
    }
    
    //MARK: - Method
    static private func handleResponse<ResponseModel: Codable>(debug: Bool, response: AFDataResponse<Any>, completion : @escaping ((Result<ResponseModel,WebErrorModel>) -> Void)){
        switch response.result {
        case.success://服务器成功返回的statusCode可能为200或500
            do {
                //JSON解析
                let decoder = JSONDecoder()
                let baseInfoModel = try decoder.decode(ResponseInfoModel.self, from: response.data!)
                switch baseInfoModel.code {
                case 1:
                    if debug { debugPrint(response)}
                    let baseDataModel = try decoder.decode(ResponseDataModel<ResponseModel>.self, from: response.data!)
                    completion(Result.success(baseDataModel.data))
                case 10009:
                    debugPrint(response)
                    kickout() //踢出
                default:
                    debugPrint(response)
                    completion(.failure(WebErrorModel(errMsg: baseInfoModel.msg)))
                }
            } catch {
                debugPrint(response)
                completion(.failure(WebErrorModel(errMsg: "数据解析出错")))
            }
        case .failure:
            debugPrint(response)
            completion(.failure(WebErrorModel(errMsg: "服务器出错")))
        }
    }
    
    static private func kickout(){
        ApplicationTool.showAlertWith(title: "您的登陆信息已经失效，请重新登录！", confirmTitle: "确定", confirmClosure: {
            AccountTool.deleteLoginInfo()
//            MAIN_VC.switchPage()
        })
    }
    
}

