//
//  GrabView.swift
//  XiaoBie
//
//  Created by wuwenwen on 2018/2/11.
//  Copyright © 2018年 wenwenwenwu. All rights reserved.
//

import UIKit

protocol PageVCDelegate: UIViewController {
    func pageVCDidAppear()
}

protocol PageViewDelegate: AnyObject {
    func pageViewDidChangePage(_ currentPageIndex: Int)
}

class PageView: UIView, UIScrollViewDelegate {
    
    //MARK: - LifeCycle
    init(ownerVC: UIViewController, pageVCArray: [PageVCDelegate]) {
        self.ownerVC = ownerVC
        self.pageVCArray = pageVCArray
        super.init(frame: .zero)
        addSubview(scrollView)
        for item in pageVCArray {
            ownerVC.addChild(item)
            scrollView.addSubview(item.view)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        superview?.layoutSubviews()
        //scrollView
        scrollView.frame = bounds
        scrollView.contentSize = CGSize(width: width * CGFloat(pageVCArray.count), height: height)
        //pageVCArray
        for (index, item) in pageVCArray.enumerated() {
            item.view.frame = CGRect(x: SCREEN_WIDTH * CGFloat(index), y: 0, width: SCREEN_WIDTH, height: height)
        }
        
    }
    
    //MARK: - UIScrollViewDelegate
    //触发selectView选中
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        currentPageIndex = Int(scrollView.contentOffset.x/scrollView.width)
        delegate?.pageViewDidChangePage(currentPageIndex)
    }
    
    //MARK: - Action
    //响应selectView选中
    func select(_ currentPageIndex: Int) {
        self.currentPageIndex = currentPageIndex
        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentOffset = CGPoint.init(x: Int(SCREEN_WIDTH) * self.currentPageIndex, y: 0)
        }
    }
    
    //MARK: - Setup
    func setupPageVCArray() {
        for (index, item) in pageVCArray.enumerated() {
            ownerVC.addChild(item)
            scrollView.addSubview(item.view)
            item.view.frame = CGRect(x: SCREEN_WIDTH * CGFloat(index), y: 0, width: SCREEN_WIDTH, height: height)
        }
    }
    
   
    //MARK: - Component
    lazy var scrollView = CreateTool.scrollViewWith(isPagingEnabled: true, bounces: false, showsVerticalScrollIndicator: false, showsHorizontalScrollIndicator: false, delegate: self)
    
    weak var delegate: PageViewDelegate?
    
    //MARK: - Data
    var ownerVC: UIViewController
    
    var pageVCArray = [PageVCDelegate]()
    
    var currentPageIndex = 0
    
    
}
