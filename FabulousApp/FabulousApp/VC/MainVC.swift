//
//  MainVC.swift
//  微度报修
//
//  Created by wuwenwen on 2019/1/7.
//  Copyright © 2019 wenwenwenwu. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    static let `default` = MainVC()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        switchPage()
    }
    
    override var childForStatusBarStyle: UIViewController? {
        children.first
    }
    
    //MARK: - Method
    func switchPage() {
//        //清空当前页面
//        if let childVC = MAIN_VC.children.first{
//            childVC.removeFromParent()
//            childVC.view.removeFromSuperview()
//        }
//        //切换页面
//        if let loginInfoModel = AccountTool.loginInfo {
//            switch loginInfoModel.userEnterTypeEnum {
//            case .生态链合伙人信息补全:
//                add(ChainCompletionVC())
//            case .直营团队和星火合伙人信息补全:
//                add(OtherCompletionVC())
//            case .生态链合伙人支付加盟费:
//                add(ChainInitialFeeVC())
//            case .生态链合伙人已支付加盟费:
//                add(AlreadyDepositVC())
//            case .主页面:
//                add(TabBarVC(), withNav: false)
//            }
//        } else {
//            add(EnterVC())
//        }
    }
    
    func add(_ vc: UIViewController, withNav: Bool = true) {
        var destinationVC = vc
        if withNav {
            destinationVC = NavigationVC(rootViewController: destinationVC)
        }
        addChild(destinationVC)
        UIView.transition(with: view, duration: TRANSITION_ANIMATION_TIME, options: .transitionCrossDissolve) {
            self.view.addSubview(destinationVC.view)
        }
    }
    
    //MARK: - Data
    let TRANSITION_ANIMATION_TIME: TimeInterval = 0.6
    
}
