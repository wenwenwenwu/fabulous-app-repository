//
//  NavigationVC.swift
//  XiaoBie
//
//  Created by wuwenwen on 2018/2/6.
//  Copyright © 2018年 wenwenwenwu. All rights reserved.
//

import UIKit

class NavigationVC: UINavigationController,UINavigationBarDelegate {
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = WHITE_FFFFFF
        setupNavigationBar()
    }
    
    override var childForStatusBarStyle: UIViewController? {
        topViewController
    }
    
    
    //MARK: - Action
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        //添加自定义返回按钮
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: #imageLiteral(resourceName: "arrow-left").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backButtonAction(animated:)))
        //隐藏tabbar
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }else {
            viewController.navigationItem.leftBarButtonItem = nil
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    @objc func backButtonAction(animated: Bool) {
        popViewController(animated: true)
    }
    
    //MARK: - Method
    func changeNavBarColor(_ color: UIColor){
        //背景
        navigationBar.setBackgroundImage(color.colorImage(), for: UIBarMetrics.default)
        //边线
        navigationBar.shadowImage = color.colorImage()
    }
    
    //MARK: - Setup
    func setupNavigationBar() {
        //标题
//        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: GRAY_4C5264, NSAttributedString.Key.font: FONT_16]
        changeNavBarColor(WHITE_FFFFFF)
    }
    
    
}

