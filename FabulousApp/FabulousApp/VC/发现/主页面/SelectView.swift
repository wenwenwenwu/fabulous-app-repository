//
//  SelectViewNew.swift
//  XiaoBie
//
//  Created by wuwenwen on 2018/3/15.
//  Copyright © 2018年 wenwenwenwu. All rights reserved.
//

import UIKit

protocol SelectViewDelegate: AnyObject {
    func selectViewDidTapButton(_ currentIndex: Int)
}

class SelectView: UIView {

    //MARK: - Init
    init(titleArray: [String]) {
        self.titleArray = titleArray
        super.init(frame: .zero)
        backgroundColor = WHITE_FFFFFF
        addSubview(scrollView)
        for item in titleArray {
            let button = createButton(title: item)
            scrollView.addSubview(button)
            buttonArray.append(button)
        }
        scrollView.addSubview(slideView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(rem(40))
        }
        scrollView.frame = CGRect(x: scrollViewLeft, y: 0, width: scrollViewWidth, height: height)
        scrollView.contentSize = CGSize(width: scrollViewContentWidth, height: height)
        var buttonLeft: CGFloat = 0
        for item in buttonArray {
            item.frame = CGRect(x: buttonLeft, y: 0, width: buttonWidth, height: height)
            buttonLeft += buttonWidth
        }
        slideView.frame = CGRect(x: buttonArray[currentIndex].x, y: height - rem(4), width: buttonWidth, height: rem(4))
    }
    
    //MARK: - Action
    @objc func chanelButtonAction(_ sender: UIButton) {
        //重新选中
        for item in buttonArray {
            item.isSelected = false
        }
        sender.isSelected = true
        //滑动滑块
        currentIndex = sender.tag
        UIView.animate(withDuration: 0.3) {
            self.layoutSubviews()
        }
        delegate?.selectViewDidTapButton(currentIndex)
    }
    
    //MARK: - Setup
    func setup(_ currentIndex: Int) {
        self.currentIndex = currentIndex
        let button = buttonArray[currentIndex]
        button.sendActions(for: UIControl.Event.touchUpInside)
    }
    
    //MARK: - Method
    func createButton(title: String) -> UIButton {
        let button = CreateTool.normalButtonWith(font: FONT_14, titleColor: BLACK_000000, title: title, target: self, action: #selector(chanelButtonAction(_:)))
        let index = titleArray.firstIndex(of: title)!
        button.setTitleColor(UIColor.systemBlue, for: .selected)
        button.isSelected = index == currentIndex
        button.tag = index
        return button
    }
        
    //MARK: - Component
    lazy var scrollView = CreateTool.scrollViewWith(backgroundColor: WHITE_FFFFFF, showsHorizontalScrollIndicator: false)
    
    lazy var slideView = CreateTool.viewWith(color: UIColor.systemBlue)
    
    weak var delegate: SelectViewDelegate?
        
    //MARK: - Data
    var titleArray: [String]
    
    var scrollViewContentWidth: CGFloat {
        return CGFloat(titleArray.count) * buttonWidth
    }
    
    var scrollViewLeft: CGFloat {
        let scrollViewLeft = scrollViewContentWidth > SCREEN_WIDTH ? 0 : (SCREEN_WIDTH - scrollViewContentWidth) / 2
        return scrollViewLeft
    }
    
    var scrollViewWidth: CGFloat {
        scrollViewContentWidth > SCREEN_WIDTH ? SCREEN_WIDTH : scrollViewContentWidth
    }
    
    var currentIndex = 0
    
    var buttonArray: [UIButton] = []
    
    let buttonWidth: CGFloat = rem(60)
        
}
