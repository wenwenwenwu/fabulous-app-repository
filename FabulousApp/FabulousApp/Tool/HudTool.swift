//
//  HudTool.swift
//  BajieSleep
//
//  Created by 邬文文 on 2020/8/18.
//  Copyright © 2020 邬文文. All rights reserved.
//

import UIKit

class HudTool {
    
    static func showHud() {
        let hud = MBProgressHUD.showAdded(to: KEY_WINDOW, animated: true)
        hud.bezelView.style = MBProgressHUDBackgroundStyle.solidColor
        hud.bezelView.color=UIColor.clear
    }
    
    static func dismissHud() {
        MBProgressHUD.hide(for: KEY_WINDOW, animated: true)
    }
    
    //showInfoHud不能在showHud和dismissHud中间使用，否则可能dismiss掉infoHud。可以结合completion使用
    static func showInfoHud(_ info : String, completion: @escaping ()->Void = {}){
        let infoHud = MBProgressHUD.showAdded(to: KEY_WINDOW, animated: true)
        infoHud.mode = MBProgressHUDMode.text
        infoHud.detailsLabel.text = info
        infoHud.detailsLabel.font = UIFont.boldSystemFont(ofSize: 15)
        infoHud.detailsLabel.textColor = WHITE_FFFFFF
        infoHud.bezelView.style = .solidColor
        infoHud.bezelView.color = UIColor.gray
        infoHud.margin = 10
        infoHud.bezelView.layer.cornerRadius = 10;
        infoHud.offset = CGPoint(x: 0, y: 40)
        infoHud.hide(animated: true, afterDelay: 1.5)
        infoHud.completionBlock = completion
    }
    
}

