//
//  FoldTextCell.swift
//  FabulousApp
//
//  Created by 邬文文 on 2021/5/31.
//

import Foundation
import YYText

protocol FoldTextCellDelegate: AnyObject {
    func foldTextCellDidTapOpenClose(toOpen: Bool, index: Int)
}

class FoldTextCell: UITableViewCell {
    
    //MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.white
        contentView.addSubview(foldLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        foldLabel.snp.makeConstraints { (make) in
            make.top.top.equalTo(rem(20))
            make.left.equalTo(rem(20))
            make.right.equalTo(rem(-20))
            make.bottom.equalTo(rem(-20))
        }
    }

    //MARK: - Setup
    func setupText(model: TextModel, index: Int) {
        var suffixStr = ""
        var contentStr = model.text
        if model.actualHeight > model.foldHeight {
            if model.isOpen {
                suffixStr = TextModel.foldStr
                contentStr += suffixStr
            } else {
                suffixStr = TextModel.openStr
                contentStr = truncateStr(str: contentStr, suffixStr: suffixStr)
            }
        }
        let attStr = NSMutableAttributedString(string: contentStr, attributes: TextModel.attributes)
        if !suffixStr.isEmpty {
            let suffixRange = NSString.init(string: contentStr).range(of: suffixStr)
            attStr.addAttribute(.foregroundColor, value: UIColor.systemBlue, range: suffixRange)
            attStr.yy_setTextHighlight(suffixRange, color: .systemBlue, backgroundColor: nil) { [unowned self] _, _, _, _ in
                delegate?.foldTextCellDidTapOpenClose(toOpen: !model.isOpen, index: index)
            }

        }
        
        foldLabel.attributedText = attStr
        
    }
    
    //MARK: - Method
    func truncateStr(str: String, suffixStr: String) -> String {
        let strCount = str.count
        let suffixCount = suffixStr.count
        for item in stride(from: strCount - suffixCount, to: 0, by: -suffixCount) {
            let lastIndex = str.index(str.startIndex, offsetBy: item)
            var tempStr = String(str[..<lastIndex])
            let tempStrSize = tempStr.sizeWithAttributes(attributes: TextModel.attributes)
            if tempStrSize.width < TextModel.foldRowCount * TextModel.width {
                tempStr += suffixStr
                let tempStrWithSuffixSize = tempStr.sizeWithAttributes(attributes: TextModel.attributes )
                if tempStrWithSuffixSize.width < TextModel.foldRowCount * TextModel.width {
                    return tempStr
                }
            }
        }
        return str
    }
    
    //MARK: - Component
    lazy var foldLabel: YYLabel = {
        let label = YYLabel()
        label.backgroundColor = UIColor.systemGreen
        label.numberOfLines = 0
        return label
    }()
    
    weak var delegate: FoldTextCellDelegate?
    
    //MARK: - Data
    var index = 0
    
}

extension String {
    
    func sizeWithAttributes(attributes : [NSAttributedString.Key : Any]) -> CGSize {
        guard count > 0 else { return .zero }
        let size = CGSize.init(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        let rect = self.boundingRect(with: size, options:[.usesLineFragmentOrigin], attributes: attributes, context:nil)
        return rect.size
    }
    
}
