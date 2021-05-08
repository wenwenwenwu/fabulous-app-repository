//
//  ApplicaationTool.swift
//  BajieManage
//
//  Created by 邬文文 on 2021/2/22.
//

import Foundation

class ApplicationTool {
    
    static func makePhoneCall(phoneNumber: String) {
        UIApplication.shared.open(URL.init(string: "tel://\(phoneNumber)")!, options: [:], completionHandler: nil)
    }
    
    static func showAlertWith(title: String? = nil, message: String? = nil, confirmTitle: String? = nil, cancelTitle: String? = nil, cancelClosure: @escaping ()->Void = {}, confirmClosure: @escaping ()->Void = {}) -> Void {//前4个负责显隐，后两个负责功能
        //创建alert
        let alertVC = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        //确定按钮
        if let confirmTitle = confirmTitle {
            let confirmAction = UIAlertAction.init(title: confirmTitle, style: UIAlertAction.Style.default, handler: { (action) in
                confirmClosure()
            })
            alertVC.addAction(confirmAction)
        }
        //取消按钮
        if let cancelTitle = cancelTitle {
            let cancelAction = UIAlertAction.init(title: cancelTitle, style: UIAlertAction.Style.cancel) { (_) in
                cancelClosure()
            }
            alertVC.addAction(cancelAction)
        }
        //呈现
        MAIN_VC.present(alertVC, animated: true, completion: nil)
    }
    
    static func showActionWith(functionTitles: [String], cancelTitle: String? = nil, cancelClosure: @escaping () -> Void = {}, titleClosure: @escaping (String) -> Void) -> Void {
        //创建actionSheet
        let actionVC = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        //功能按钮
        for item in functionTitles {
            let alertAction = UIAlertAction.init(title: item, style: UIAlertAction.Style.default, handler: { (action) in
                titleClosure(item)
            })
            actionVC.addAction(alertAction)
        }
        //取消按钮
        if let cancelTitle = cancelTitle {
            let cancelAction = UIAlertAction.init(title: cancelTitle, style: UIAlertAction.Style.cancel) { (_) in
                cancelClosure()
            }
            actionVC.addAction(cancelAction)
        }
        //呈现
        MAIN_VC.present(actionVC, animated: true, completion: nil)
    }
    
    static func presentDocumentMenu (url: URL, view: UIView) {
        documentVC = UIDocumentInteractionController.init(url: url)
        documentVC.presentOptionsMenu(from: view.bounds, in: view, animated: true)
    }
    
    static var documentVC: UIDocumentInteractionController!
}
