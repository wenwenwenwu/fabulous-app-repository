//
//  ZoomHeader.swift
//  FabulousApp
//
//  Created by 邬文文 on 2021/5/8.
//

import Foundation

class ZoomHeader: UIView {
    
    //MARK: - LifeCycle
    init() {
        super.init(frame: .zero)
        addSubview(backImageView)
        backImageView.frame = CGRect(origin: .zero, size: backImageSize) 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Component
    lazy var backImageView = CreateTool.imageViewWith(image: #imageLiteral(resourceName: "header_2"))
            
    //MARK: - Data
    var backImageSize: CGSize {
        return CGSize(width: SCREEN_WIDTH, height: SCREEN_WIDTH * backImageView.height / backImageView.width)
    }
    
    var offsetY: CGFloat = 0 {
        didSet {
            if offsetY < 0 { //下拉为负
                let backImageWidth = backImageSize.width
                let backImageHeight = backImageSize.height
                let expectedBackImageHeight = backImageHeight + abs(offsetY)
                let zoomRatio = expectedBackImageHeight / backImageHeight
                backImageView.frame = CGRect(x: -backImageWidth * (zoomRatio - 1) * 0.5, y: offsetY, width: backImageWidth * zoomRatio, height: expectedBackImageHeight)
            }else {
                backImageView.frame = CGRect(origin: .zero, size: backImageSize)
            }
        }
    }
    
}
