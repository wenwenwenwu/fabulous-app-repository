//
//  BlankView.swift
//  BajieManage
//
//  Created by 邬文文 on 2021/3/2.
//

import UIKit

class BlankView: UIView {
    
    enum StatusType {
        case empty
        case noData
        case wrongData(String)
    }
    
    //MARK: - LifeCycle
    init(backgroundColor: UIColor = GRAY_F0F0F0) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        addSubview(infoLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        infoLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
    
    //MARK: - Method
    func hide() {
        isHidden = true
    }
    
    func showNoData() {
        infoLabel.text = "数据为空"
        isHidden = false
    }
    
    func showError(_ error: WebErrorModel) {
        infoLabel.text = error.errMsg
        isHidden = false
    }
    
    //MARK: - Component
    lazy var infoLabel = CreateTool.labelWith(font: FONT_14, textColor: BLACK_000000)

}
