//
//  MomentCell.swift
//  FabulousApp
//
//  Created by 邬文文 on 2021/5/10.
//

import UIKit

class MomentCell: UICollectionViewCell {
    
    //MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = WHITE_FFFFFF
        contentView.addSubview(coverView)
        contentView.addSubview(avatarView)
        contentView.addSubview(nickNameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        coverView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(rem(-40))
        }
        avatarView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: rem(20), height: rem(20)))
            make.top.equalTo(coverView.snp.bottom).offset(rem(10))
        }
        nickNameLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(avatarView)
            make.left.equalTo(avatarView.snp.right).offset(rem(5))
        }
        
    }
    
    //MARK: - Setup
    func setup(model: MomentItemModel) {
        coverView.kf.setImage(with: model.cover.realURL, placeholder: GRAY_F0F0F0.colorImage(), options: [.transition(.fade(0.4))])
        avatarView.kf.setImage(with: model.user.avatarURL)
        nickNameLabel.text = model.user.nickname
    }
    
    //MARK: - Component
    lazy var coverView: UIImageView = {
        let avatarView = CreateTool.imageViewWith()
        avatarView.addCorner(cornerRadius: rem(4))
        return avatarView
    }()
    
    lazy var avatarView: UIImageView = {
        let avatarView = CreateTool.imageViewWith()
        avatarView.addCorner(cornerRadius: rem(10))
        return avatarView
    }()
    
    lazy var nickNameLabel = CreateTool.labelWith(font: FONT_12, textColor: GRAY_666666)
}

