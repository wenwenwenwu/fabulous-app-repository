//
//  SelectViewNew.swift
//  FabulousApp
//
//  Created by 邬文文 on 2021/5/17.
//

import Foundation

protocol SelectViewNewDelegate: AnyObject {
    func selectViewDidTapButton(_ currentTitleIndex: Int)
}

class SelectViewNew: UIView {

    //MARK: - Init
    init(titleArray: [String]) {
        self.titleArray = titleArray
        super.init(frame: .zero)
        addSubview(scrollView)
        scrollView.addSubview(bottomSliderBar)
        for item in titleArray {
            let button = createButton(title: item)
            scrollView.addSubview(button)
            buttonArray.append(button)
        }
        scrollView.addSubview(topSlideBar)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        scrollView.frame = CGRect(x: scrollViewLeft, y: 0, width: scrollViewWidth, height: height)
        scrollView.contentSize = CGSize(width: scrollViewContentWidth - rem(CGFloat(buttonArray.count)), height: height)
        var buttonLeft: CGFloat = 0
        for item in buttonArray {
            item.frame = CGRect(x: buttonLeft, y: 0, width: buttonWidth, height: height)
            buttonLeft += buttonWidth - rem(1)
        }
        let sliderBarTop = (height - sliderBarHeight) / 2
        bottomSliderBar.frame = CGRect(x: buttonArray[currentTitleIndex].x, y: sliderBarTop, width: buttonWidth, height: sliderBarHeight)
        topSlideBar.frame = CGRect(x: buttonArray[currentTitleIndex].x, y: sliderBarTop, width: buttonWidth, height: sliderBarHeight)
    }
    
    //MARK: - Action
    @objc func tapButtonAction(_ sender: UITapGestureRecognizer) {
        self.currentTitleIndex = sender.view!.tag //titleIndex
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
        bottomSliderBar.x = scrollViewContentWidth * scrollRatio
        topSlideBar.x = scrollViewContentWidth * scrollRatio
    }
        
    //MARK: - Method
    func createButton(title: String) -> UILabel {
        let labelButton = CarvedLabel(font: FONT_14, backGroundColor: WHITE_FFFFFF, textAlignment: .center, text: title)
        labelButton.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapButtonAction(_:)))
        
        labelButton.addGestureRecognizer(tapGesture)
        let titleIndex = titleArray.firstIndex(of: title)!
        labelButton.tag = titleIndex
        return labelButton
    }
    
    func selectButton(withSliderBarMove: Bool) {
        let currentX = buttonArray[currentTitleIndex].x - scrollView.contentOffset.x //选中button目前在屏幕中的X
        let expetionX = (SCREEN_WIDTH - buttonWidth) / 2 //期待选中button在屏幕中的X
        let move = currentX - expetionX //scrollView需要滚动的距离
        var contentOffsetX = scrollView.contentOffset.x + move
        if contentOffsetX <= 0 { contentOffsetX = 0 } //不允许右移
        if contentOffsetX >= scrollView.contentSize.width - SCREEN_WIDTH { //
            contentOffsetX = scrollView.contentSize.width - SCREEN_WIDTH
        }
        UIView.animate(withDuration: 0.3) { [unowned self] in
            scrollView.contentOffset = CGPoint(x: contentOffsetX, y: 0)
        }        

    }
    
    //MARK: - Component
    lazy var scrollView = CreateTool.scrollViewWith(backgroundColor: .lightGray, bounces: false, showsHorizontalScrollIndicator: false)
    
    lazy var topSlideBar: UIView = {
        let view = CreateTool.viewWith(color: UIColor.cyan.withAlphaComponent(0.1))
        view.addCorner(cornerRadius: sliderBarHeight / 2)
        return view
    }()
    
    lazy var bottomSliderBar: UIView = {
        let view = CreateTool.viewWith(color: UIColor.cyan)
        view.addCorner(cornerRadius: rem(10))
        return view
    }()
    
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
    
    var buttonArray: [UILabel] = []
    
    let buttonWidth: CGFloat = rem(80)
    
    let sliderBarHeight = rem(25)
        
}
