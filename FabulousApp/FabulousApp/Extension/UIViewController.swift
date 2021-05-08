//
//  UIViewController.swift
//  BajieManage
//
//  Created by 邬文文 on 2021/3/7.
//

import Foundation

extension UIViewController {
        
    static func resignAllKeyboard() {
        guard let currentVC = currentViewController() else { return }
        resignKeyBoardInView(view: currentVC.view)
    }
    
    static func resignKeyBoardInView(view: UIView) {
        for item in view.subviews {
            if item.subviews.count > 0 {
                resignKeyBoardInView(view: item)
            }
            if item.isKind(of: UITextView.self) || item.isKind(of: UITextField.self) {
                item.resignFirstResponder()
            }
        }
    }
    
    static func currentViewController() -> UIViewController? {
        var window = KEY_WINDOW
        if window.windowLevel != UIWindow.Level.normal{
            let windows = UIApplication.shared.windows
            for  windowTemp in windows{
                if windowTemp.windowLevel == UIWindow.Level.normal{
                    window = windowTemp
                    break
                }
            }
        }
        let vc = window.rootViewController
        return currentViewController(vc)
    }
    
    
    static func currentViewController(_ vc :UIViewController?) -> UIViewController? {
        if vc == nil {
            return nil
        }
        if let presentVC = vc?.presentedViewController {
            return currentViewController(presentVC)
        }
        else if let tabVC = vc as? UITabBarController {
            if let selectVC = tabVC.selectedViewController {
                return currentViewController(selectVC)
            }
            return nil
        }
        else if let naiVC = vc as? UINavigationController {
            return currentViewController(naiVC.visibleViewController)
        }
        else {
            return vc
        }
    }
    
}
