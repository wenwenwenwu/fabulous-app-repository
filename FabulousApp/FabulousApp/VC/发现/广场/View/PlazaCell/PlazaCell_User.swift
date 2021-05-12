//
//  PlazaCell_User.swift
//  FabulousApp
//
//  Created by 邬文文 on 2021/5/12.
//

import Foundation

class PlazaCell_User: PlazaCell {
    
    //MARK: - Setup
    func setupUserLayout() {
        setup(imageSize: CGSize(width: rem(116), height: rem(140)), imageRadius: rem(10), imageSpacing: rem(8), padding: UIEdgeInsets(top: rem(0), left: rem(10), bottom: rem(0), right: rem(10)))
    }
    
    func setup(modelArray: [PlazaOUserInfoItemModel]) {
        let imageURLArray = modelArray.map { $0.avatarURL }
        setup(imageURLs: imageURLArray)
        for (index, item) in imageViewArray.enumerated() {
            //nameLabel
            let nameLabel = CreateTool.labelWith(font: FONT_11_BOLD, textColor: WHITE_FFFFFF, text: modelArray[index].nickname)
            item.addSubview(nameLabel)
            //roleLabel
            let roleLabel = CreateTool.labelWith(font: FONT_10, textColor: GRAY_F0F0F0, text: modelArray[index].roleName.first)
            item.addSubview(roleLabel)
            nameLabel.snp.makeConstraints { (make) in
                make.left.equalTo(roleLabel)
                make.bottom.equalTo(roleLabel.snp.top).offset(-3)
            }
            roleLabel.snp.makeConstraints { (make) in
                make.left.equalTo(rem(10))
                make.bottom.equalToSuperview().offset(rem(-20))
            }
        }
    }
    
}
