//
//  PlazaCell.swift
//  FabulousApp
//
//  Created by 邬文文 on 2021/5/12.
//

import Foundation

class PlazaCell: UITableViewCell {
    
    //MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = WHITE_FFFFFF
        contentView.addSubview(scrollView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    //MARK: - Setup
    func setup(imageSize: CGSize, imageRadius: CGFloat, imageSpacing: CGFloat, contentInsets: UIEdgeInsets) {
        self.imageSize = imageSize
        self.imageRadius = imageRadius
        self.imageSpacing = imageSpacing
        //scrollview的上下边距同contentInsets，而左右边距恒为0。contentInsets的左右边距是指添加的首尾图片在contentView中的左右边距
        self.contentInsets = contentInsets
        PlazaCell.cellHeight = imageSize.height + contentInsets.top + contentInsets.bottom
    }
    
    func setup(imageURLs: [URL?]) {
        scrollView.removeAllSubviews() //防止reuse时重复添加
        scrollView.frame = CGRect(
            x: 0,
            y: contentInsets.top,
            width: SCREEN_WIDTH,
            height: imageSize.height
        )
        scrollView.contentSize = CGSize(
            width: contentInsets.left + imageSize.width * CGFloat(imageURLs.count) + imageSpacing * CGFloat(imageURLs.count - 1) + contentInsets.right,
            height: imageSize.height
        )
        contentView.addSubview(scrollView)
        var imageLeft: CGFloat = contentInsets.left
        for item in imageURLs {
            let imageView = CreateTool.imageViewWith()
            imageView.addCorner(cornerRadius: imageRadius)
            imageView.kf.setImage(with: item, placeholder: GRAY_F0F0F0.colorImage(), options: [.transition(.fade(0.4))])
            imageView.frame = CGRect(origin: CGPoint(x: imageLeft, y: 0), size: imageSize)
            scrollView.addSubview(imageView)
            imageViewArray.append(imageView)
            imageLeft += imageSize.width + imageSpacing
        }
    }
    
    //MARK: - Component
    lazy var scrollView = CreateTool.scrollViewWith(backgroundColor: WHITE_FFFFFF, showsHorizontalScrollIndicator: false)
    
    //MARK: - Data
    var imageSize = CGSize.zero
    
    var imageRadius: CGFloat = 0
    
    var imageSpacing: CGFloat = 0
    
    var contentInsets = UIEdgeInsets.zero
    
    static var cellHeight: CGFloat = 0
    
    var imageViewArray = [UIImageView]()
    
    
}
