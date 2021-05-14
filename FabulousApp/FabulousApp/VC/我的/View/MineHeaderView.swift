//
//  MineHeaderView.swift
//  FabulousApp
//
//  Created by 邬文文 on 2021/5/14.
//

import Foundation

class MineHeaderView: UIView {
    
    //MARK: - LifeCycle
    init() {
        super.init(frame: .zero)
        backgroundColor = .clear
        addSubview(heartIconView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heartIconView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: rem(30), height: rem(30)))
            make.right.equalTo(rem(-30))
            make.bottom.equalTo(rem(-30))
        }
    }
    
    //MARK: - Setup
    func setup(offsetY: CGFloat,realHeaderHeight: CGFloat) {
        if offsetY > 0 { //上滑
            heartIconView.alpha = (realHeaderHeight - abs(offsetY)) / realHeaderHeight
        }
    }
    
    //MARK: - Component
    lazy var heartIconView = CreateTool.imageViewWith(image: #imageLiteral(resourceName: "aixin"))
    
    
    //MARK: - Data
    var heartIconSize: CGSize {
        return heartIconView.frame.size
    }
    
}
