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

    }
}

