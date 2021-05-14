//
//  MineNavBar.swift
//  FabulousApp
//
//  Created by 邬文文 on 2021/5/14.
//

import Foundation

class MineNavBar: UIView {
    
    //MARK: - LifeCycle
    init() {
        super.init(frame: .zero)
        addSubview(contentView)
        contentView.addSubview(nameLabel)
        contentView.alpha = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        nameLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(rem(-10))
        }
        
    }
    
    //MARK: - Setup
    func setup(offsetY: CGFloat,realHeaderHeight: CGFloat) {
        if offsetY > 0 { //上滑
            if abs(offsetY) - realHeaderHeight > rem(-20) { //不知为何取不到0
                contentView.alpha = 1
            }
        } else {
            contentView.alpha = 0
        }
    }
    
    //MARK: - Component
    lazy var contentView = CreateTool.viewWith(color: .clear)

    lazy var nameLabel = CreateTool.labelWith(font: FONT_18_BOLD, textColor: WHITE_FFFFFF, text: "大白牙")
    
    
    
}
