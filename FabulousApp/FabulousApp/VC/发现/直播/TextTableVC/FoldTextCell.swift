//
//  FoldTextCell.swift
//  FabulousApp
//
//  Created by 邬文文 on 2021/5/31.
//

import Foundation

protocol FoldTextCellDelegate: AnyObject {
    func foldTextCellDidTapOpenClose(index: Int)
}

class FoldTextCell: UITableViewCell, UITextViewDelegate {
    
    //MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.white
        contentView.addSubview(textView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: rem(0), left: rem(20), bottom: rem(20), right: rem(20)))
        }
    }
    
    //MARK: - UITextViewDelegate
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if URL.scheme == "didOpenClose" {
            guard let delegate = delegate else { return false }
            print("可以")
            delegate.foldTextCellDidTapOpenClose(index: index)
        }
        return true
    }
    
    //MARK: - Action
    
    
    
    //MARK: - Setup
    func setupText(model: TextModel, index: Int) {
        var suffixStr = ""
        var contentStr = model.text
        var height = model.actualHeight
        if model.actualHeight > model.foldHeight {
            if model.isOpen {
                suffixStr = TextModel.foldStr
                contentStr += suffixStr
                height = model.actualHeight
            } else {
                suffixStr = TextModel.openStr
                contentStr = truncateStr(str: contentStr, suffixStr: suffixStr)
                height = model.foldHeight
            }
        }
        let attStr = NSMutableAttributedString(string: contentStr, attributes: TextModel.attributes)
//        var linkTextAttributes:[NSAttributedString.Key:Any]
        if !suffixStr.isEmpty {
            let range3 = NSString.init(string: contentStr).range(of: suffixStr)
            attStr.addAttribute(.foregroundColor, value: UIColor.systemBlue, range: range3)

            let charSet = NSMutableCharacterSet()
            charSet.formUnion(with: CharacterSet.urlQueryAllowed)
            charSet.addCharacters(in: "#")
            let linkStr = "didOpenClose://".addingPercentEncoding(withAllowedCharacters: charSet as CharacterSet)!
            attStr.addAttribute(.link, value: "didOpenClose://", range: range3)
//            let linkStr = "didOpenClose://\(suffixStr)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed)!
//            attStr.addAttribute(.link, value: linkStr, range: range3)
            
        }
        textView.attributedText = attStr
        
        
        
        
        
        
    }
    
    
    
    //MARK: - Method
    func truncateStr(str: String, suffixStr: String) -> String {
        let strCount = str.count
        let suffixCount = suffixStr.count
        for item in stride(from: strCount, to: 0, by: -suffixCount) {
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
    lazy var textView = CreateTool.textViewWith(backGroundColor: UIColor.yellow, delegate: self)
    
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
