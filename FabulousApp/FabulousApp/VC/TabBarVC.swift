//
//  TabBarVC.swift
//  MapDemo
//
//  Created by wuwenwen on 2017/8/22.
//  Copyright © 2017年 wenwenwenwu. All rights reserved.
//

import UIKit
import Kingfisher

class TabBarVC: UITabBarController, UITabBarControllerDelegate {
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [discoverNav,liveNav,addNav,messageNav,mineNav]
        tabBar.backgroundImage = UIColor.white.colorImage() //背景
        tabBar.shadowImage = UIColor.white.colorImage() //边线
        tabBar.addSubview(publishImageView) //凸起
        delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        /**
         小知识：
         UITabBarController有N个子控制器,其UITabBar内部就会有N个UITabBarButton与之对应
         UITabBarButton在UITabBar中的位置是均分的，UITabBarButton的高度恒为48(UITabBar的高度)
         UITabBarButton类是UIView，但无法直接获得。它⾥面的内容由对应子控制器的UITabBarItem来设定(它不是UIView)
         */
        //图片设计尺寸为UITabBarButton宽度，UITabBarButton的高度+13.5，因此y要设置为-13.5
        let buttonWidth = UIScreen.main.bounds.width / CGFloat(viewControllers!.count)
        publishImageView.frame = CGRect(x: buttonWidth * 2, y: -13.5, width: buttonWidth, height: 48 + 13.5)
    }
    
    //MARK: - UITabBarControllerDelegate
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        //监听将要点击事件
        guard let _ = tabBarController.tabBar.selectedItem!.title else {
            let cache = ImageCache.default
            cache.clearCache {
                print("已清空全部缓存")
            }
            
            return false
        }
        return true
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let itemIndex = tabBar.items!.firstIndex(of: item)
        guard itemIndex != 2 else { return } //点击中间忽略
        selectedIndex = tabBar.items!.firstIndex(of: item)!
        selectedTabbarButton.layer.add(bounceAnimation, forKey: nil)
        

    }
    
    //MARK: - Method
    func navWith(vc: UIViewController, title: String, image: UIImage, selectedImage: UIImage) -> UINavigationController {
        let nav = NavigationVC(rootViewController: vc)
        let item = UITabBarItem(title:title,
                               image:image.withRenderingMode(.alwaysOriginal),
                               selectedImage:selectedImage.withRenderingMode(.alwaysOriginal))
        item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -2)
        item.setTitleTextAttributes([.foregroundColor : UIColor.systemGray, .font : UIFont.systemFont(ofSize: 10)], for: .normal)
        item.setTitleTextAttributes([.foregroundColor : UIColor.red, .font : UIFont.systemFont(ofSize: 10)], for: .selected)
        nav.tabBarItem = item
        return nav
    }
    
    //MARK: - Component    
    lazy var discoverNav = navWith(vc: MomentListVC(), title: "发现", image: #imageLiteral(resourceName: "tabbar_icon_find"), selectedImage: #imageLiteral(resourceName: "tabbar_icon_findsel"))
    
    lazy var liveNav = navWith(vc: ViewController(), title: "直播", image: #imageLiteral(resourceName: "tabbar_icon_room"), selectedImage: #imageLiteral(resourceName: "tabbar_icon_roomsel"))
    
    lazy var addNav = ViewController()
    
    lazy var messageNav = navWith(vc: ViewController(), title: "消息", image: #imageLiteral(resourceName: "tabbar_icon_msg"), selectedImage: #imageLiteral(resourceName: "tabbar_icon_msgsel"))
    
    lazy var mineNav = navWith(vc: MineVC(), title: "我的", image: #imageLiteral(resourceName: "tabbar_icon_mine"), selectedImage: #imageLiteral(resourceName: "tabbar_icon_minesel"))
    
    lazy var publishImageView = CreateTool.imageViewWith(image: #imageLiteral(resourceName: "tabbar_icon_addbg"),contentMode: .center) //为了适配选择center
    
    let bounceAnimation: CAKeyframeAnimation = {
        let animation = CAKeyframeAnimation.init(keyPath: "transform")
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.duration = 0.3
        animation.isRemovedOnCompletion = true
        animation.fillMode = CAMediaTimingFillMode.forwards
        var values: [NSValue] = []
        values.append(NSValue.init(caTransform3D: CATransform3DMakeScale(0.9, 0.9, 0.9)))
        values.append(NSValue.init(caTransform3D: CATransform3DMakeScale(1.1, 1.1, 1.1)))
        values.append(NSValue.init(caTransform3D: CATransform3DMakeScale(1.0, 1.0, 1.0)))
        animation.values = values
        return animation
    }()
    
    //MARK: - Data
    var selectedTabbarButton: UIView {
        //获取UITabBarButton的方法
        var tabBarButtonArray = [UIView]()
        for item in tabBar.subviews {
            if item.isKind(of: NSClassFromString("UITabBarButton")!) {
                tabBarButtonArray.append(item)
            }
        }
        return tabBarButtonArray[selectedIndex]
    }
        
}


