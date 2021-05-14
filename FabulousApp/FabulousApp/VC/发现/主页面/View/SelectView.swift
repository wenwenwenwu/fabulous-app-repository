//
//  SelectViewNew.swift
//  XiaoBie
//
//  Created by wuwenwen on 2018/3/15.
//  Copyright © 2018年 wenwenwenwu. All rights reserved.
//

import UIKit

protocol SelectViewDelegate: AnyObject {
    func selectViewDidTapButton(_ currentTitleIndex: Int)
}

class SelectView: UIView {

    //MARK: - Init
    init(titleArray: [String]) {
        self.titleArray = titleArray
        super.init(frame: .zero)
        addSubview(scrollView)
        for item in titleArray {
            let button = createButton(title: item)
            scrollView.addSubview(button)
            buttonArray.append(button)
        }
        scrollView.addSubview(slideBar)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        scrollView.frame = CGRect(x: scrollViewLeft, y: 0, width: scrollViewWidth, height: height)
        scrollView.contentSize = CGSize(width: scrollViewContentWidth, height: height)
        var buttonLeft: CGFloat = 0
        for item in buttonArray {
            item.frame = CGRect(x: buttonLeft, y: 0, width: buttonWidth, height: height)
            buttonLeft += buttonWidth
        }
        slideBar.frame = CGRect(x: buttonArray[currentTitleIndex].x, y: height - rem(4), width: buttonWidth, height: rem(4))
    }
    
    //MARK: - Action
    @objc func tapButtonAction(_ sender: UIButton) {
        self.currentTitleIndex = sender.tag //titleIndex
        selectButton(withSliderBarMove: true)
        //触发PageView翻页
        delegate?.selectViewDidTapButton(currentTitleIndex)
    }
    
    //响应PageView翻页
    func select(_ currentTitleIndex: Int) {
        self.currentTitleIndex = currentTitleIndex
        selectButton(withSliderBarMove: false)
    }
    
    //响应PageView滑动
    func moveSliderBar(_ scrollRatio: CGFloat) {
        slideBar.x = scrollViewContentWidth * scrollRatio
    }
        
    //MARK: - Method
    func createButton(title: String) -> UIButton {
        let button = CreateTool.normalButtonWith(font: FONT_18_BOLD, titleColor: BLACK_000000, title: title, target: self, action: #selector(tapButtonAction(_:)))
        let titleIndex = titleArray.firstIndex(of: title)!
        button.setTitleColor(UIColor.systemPink, for: .selected)
        button.isSelected = titleIndex == currentTitleIndex
        button.tag = titleIndex
        return button
    }
    
    func selectButton(withSliderBarMove: Bool) {
        for (index, item) in buttonArray.enumerated() {
            item.isSelected = (index == currentTitleIndex)
        }
        if withSliderBarMove {
            UIView.animate(withDuration: 0.3) { [unowned self] in
                slideBar.frame = CGRect(x: buttonArray[currentTitleIndex].x, y: height - rem(4), width: buttonWidth, height: rem(4))
            }
        }
    }
    
    //MARK: - Component
    lazy var scrollView = CreateTool.scrollViewWith(backgroundColor: WHITE_FFFFFF, showsHorizontalScrollIndicator: false)
    
    lazy var slideBar = CreateTool.viewWith(color: UIColor.systemPink)
    
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
    
    var currentTitleIndex = 0
    
    var buttonArray: [UIButton] = []
    
    let buttonWidth: CGFloat = rem(60)
        
}
