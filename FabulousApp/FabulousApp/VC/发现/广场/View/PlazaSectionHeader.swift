//
//  PlazaSectionHeader.swift
//  FabulousApp
//
//  Created by 邬文文 on 2021/5/12.
//

import Foundation

class PlazaSectionHeader: UIView {
    
    //MARK: - LifeCycle
    init() {
        super.init(frame: .zero)
        backgroundColor = WHITE_FFFFFF
        addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(rem(10))
            make.top.equalToSuperview()
        }
    }
    
    //MARK: - Setup
    func setup(title: String) {
        titleLabel.text = title
    }
    
    //MARK: - Component
    lazy var titleLabel = CreateTool.labelWith(font: FONT_14, textColor: GRAY_666666)
        
    //MARK: - Data
    var title = ""
    
}
