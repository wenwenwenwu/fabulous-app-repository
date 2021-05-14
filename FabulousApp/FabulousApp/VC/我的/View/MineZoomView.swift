//
//  MineZoomView.swift
//  FabulousApp
//
//  Created by 邬文文 on 2021/5/8.
//

import Foundation

class MineZoomView: UIView {
    
    //MARK: - LifeCycle
    init(backImage: UIImage) {
        self.backImage = backImage
        super.init(frame: .zero)
        addSubview(backImageView)
        addSubview(contentView)
        contentView.addSubview(avatarView)
        contentView.addSubview(nameLabel)
        backImageView.frame = CGRect(origin: .zero, size: backImageSize) //会实时变动，不能在layoutSubviews中设置
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        avatarView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: rem(70), height: rem(70)))
            make.centerX.equalToSuperview()
            make.top.equalTo(rem(120))
        }
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(avatarView.snp.bottom).offset(rem(20))
            make.centerX.equalToSuperview()
        }
    }
    
    //MARK: - Setup
    func setup(offsetY: CGFloat, realHeaderHeight: CGFloat) {
        if offsetY < 0 { //下拉
            let backImageWidth = backImageSize.width
            let backImageHeight = backImageSize.height
            let expectedBackImageHeight = backImageHeight + abs(offsetY)
            let zoomRatio = expectedBackImageHeight / backImageHeight
            backImageView.frame = CGRect(x: -backImageWidth * (zoomRatio - 1) * 0.5, y: 0, width: backImageWidth * zoomRatio, height: expectedBackImageHeight)
        }else { //上滑
            backImageView.frame = CGRect(origin: .init(x: 0, y: -offsetY * 0.3), size: backImageSize)
            contentView.alpha = (realHeaderHeight - abs(offsetY)) / realHeaderHeight
        }
    }
    
    //MARK: - Component
    lazy var backImageView = CreateTool.imageViewWith(image: backImage)
    
    lazy var contentView = CreateTool.viewWith(color: .clear)
    
    var avatarView: UIImageView = {
        let view = CreateTool.imageViewWith(image: #imageLiteral(resourceName: "avatar"))
        view.addCorner(cornerRadius: rem(35))
        view.addBorder(color: UIColor.orange, width: rem(3))
        return view
    }()
    
    lazy var nameLabel = CreateTool.labelWith(font: FONT_18_BOLD, textColor: WHITE_FFFFFF, text: "大白牙")
            
    //MARK: - Data
    var backImage: UIImage
        
    var backImageSize: CGSize {
        return CGSize(width: SCREEN_WIDTH, height: SCREEN_WIDTH * backImageView.height / backImageView.width)
    }
    
}
