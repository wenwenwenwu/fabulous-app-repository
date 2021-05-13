//
//  PlazaCell_Type.swift
//  FabulousApp
//
//  Created by 邬文文 on 2021/5/12.
//

import Foundation

class PlazaCell_Type: PlazaCell {
    
    //MARK: - Setup
    func setupSceneTypeLayout() {
        setup(imageSize: CGSize(width: rem(94), height: rem(97)), imageRadius: rem(5), imageSpacing: rem(8), contentInsets: UIEdgeInsets(top: rem(0), left: rem(10), bottom: rem(20), right: rem(10)))
    }
    
    func setupGoalTypeLayout() {
        setup(imageSize: CGSize(width: rem(89), height: rem(92)), imageRadius: rem(5), imageSpacing: rem(8), contentInsets: UIEdgeInsets(top: rem(0), left: rem(10), bottom: rem(20), right: rem(10)))
    }
    
    func setup(modelArray: [PlazaTypeCellModel]) {
        let imageURLArray = modelArray.map { $0.imageURL }
        setup(imageURLs: imageURLArray)
        for (index, item) in imageViewArray.enumerated() {
            let titleLabel = CreateTool.labelWith(font: FONT_12, textColor: WHITE_FFFFFF, backGroundColor: WHITE_FFFFFF.withAlphaComponent(0.3), textAlignment: .center, text: modelArray[index].title)
            item.addSubview(titleLabel)
            titleLabel.snp.makeConstraints { (make) in
                make.left.bottom.right.equalToSuperview()
                make.height.equalTo(rem(20))
            }
        }
    }
    
}
