//
//  ViewController.swift
//  FabulousApp
//
//  Created by 邬文文 on 2021/5/8.
//

import UIKit

class ViewController: UIViewController, PageVCDelegate {
    func pageVCDidAppear() {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: CGFloat(arc4random() % 256) / 256.0, green: CGFloat(arc4random() % 256) / 256.0, blue: CGFloat(arc4random() % 256) / 256.0, alpha: 1)
//        view.backgroundColor = UIColor.lightGray
        
//        let backView = UIView.init(frame: .init(x: 80, y: 20, width: 100, height: 100))
//        backView.backgroundColor = UIColor.cyan
//        backView.addCorner(cornerRadius: 50)
//        view.addSubview(backView)
        
//        let lk = CarvedLabel(font: UIFont.systemFont(ofSize: 32, weight: .bold), backGroundColor: WHITE_FFFFFF, numberOfLines: 0, textAlignment: .center, text: "猴子请来的救兵")
//        let lk = CarvedLabel(backGroundColor: WHITE_FFFFFF,numberOfLines: 3, textAlignment: .center , text: "猴子请来的狗猴子请来的狗猴子请来的狗猴子请来的狗猴子请来的狗猴子请来的狗")
//
//        lk.frame = CGRect(x: 20, y: 20, width: 200, height: 100)
//        view.addSubview(lk)
//
//        let coverView = UIView.init(frame: .init(x: 80, y: 20, width: 100, height: 100))
//        coverView.backgroundColor = UIColor.cyan.withAlphaComponent(0.1)
//        coverView.addCorner(cornerRadius: 50)
//
//        view.addSubview(coverView)
    }


}

