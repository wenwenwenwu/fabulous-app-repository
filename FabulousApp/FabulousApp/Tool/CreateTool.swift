//
//  CreateTool.swift
//  hyr
//
//  Created by wuwenwen on 2018/6/26.
//  Copyright © 2018年 WeiDu. All rights reserved.
//

import UIKit


class CreateTool {
    
    static func viewWith(color: UIColor) -> UIView {
        let view = UIView()
        view.backgroundColor = color
        return view
    }
    
    static func labelWith(font: UIFont? = nil, textColor: UIColor? = nil, backGroundColor: UIColor? = nil, numberOfLines: Int? = nil, textAlignment: NSTextAlignment? = nil, text: String? = nil) -> UILabel {
        let label = UILabel()
        if let font = font {//存在就设置,否则保持默认状态
            label.font = font
        }
        if let textColor = textColor {
            label.textColor = textColor
        }
        if let backGroundColor = backGroundColor {
            label.backgroundColor = backGroundColor
        }
        if let numberOfLines = numberOfLines {
            label.numberOfLines = numberOfLines
        }
        if let textAlignment = textAlignment {
            label.textAlignment = textAlignment
        }
        if let text = text {
            label.text = text
        }
        return label
    }
    
    //通过范型，UIButton的子类也能通过该方法创建
    static func normalButtonWith<T: UIButton>(font: UIFont? = nil, titleColor: UIColor? = nil, title: String? = nil, image: UIImage? = nil, backGroundImage: UIImage? = nil, target: Any? = nil, action: Selector? = nil) -> T {
        let button = T.init(type: .custom)
        if let font = font {
            button.titleLabel?.font = font
        }
        if let titleColor = titleColor {
            button.setTitleColor(titleColor, for: .normal)
        }
        if let title = title {
            button.setTitle(title, for: .normal)
        }
        if let image = image {
            button.setImage(image, for: .normal)
        }
        if let backGroundImage = backGroundImage {
            button.setBackgroundImage(backGroundImage, for: .normal)
        }
        if let action = action {
            button.addTarget(target, action: action, for: .touchUpInside)
        }
        button.adjustsImageWhenHighlighted = false
        return button
    }
    
    static func tableViewWith(style: UITableView.Style, backgroundColor: UIColor? = nil, backgroundView: UIView? = nil, dataSource: UITableViewDataSource, delegate: UITableViewDelegate) -> UITableView {
        let tableView = UITableView.init(frame: CGRect.zero, style: style)
        if let backgroundColor = backgroundColor {
            tableView.backgroundColor = backgroundColor
        }
        if let backgroundView = backgroundView {
            tableView.backgroundView = backgroundView
        }
        tableView.dataSource = dataSource
        tableView.delegate = delegate
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()//plain模式的tableviw不显示多余部分
        return tableView
    }
    
    static func imageViewWith(image: UIImage? = nil, contentMode: UIView.ContentMode = .scaleAspectFill) -> UIImageView {
        let imageView = UIImageView.init(image: image)
        imageView.contentMode = contentMode
        imageView.clipsToBounds = true
        return imageView
    }
    
    static func textViewWith(font: UIFont, textColor: UIColor, backGroundColor: UIColor? = nil, delegate: UITextViewDelegate? = nil) -> UITextView {
        let textView = UITextView()
        textView.showsVerticalScrollIndicator = false
        textView.font = font
        textView.textColor = textColor
        if let backGroundColor = backGroundColor {
            textView.backgroundColor = backGroundColor
        }
        if let delegate = delegate {
            textView.delegate = delegate
        }
        return textView
    }
    
    static func textFieldWith(font: UIFont, textColor: UIColor, delegate: UITextFieldDelegate? = nil) -> UITextField {
        let textField = UITextField()
        textField.font = font
        textField.textColor = textColor
        if let delegate = delegate {
            textField.delegate = delegate
        }
        return textField
    }
    
    static func scrollViewWith(backgroundColor: UIColor? = nil, isPagingEnabled: Bool = false, bounces: Bool = true, showsVerticalScrollIndicator: Bool = true, showsHorizontalScrollIndicator: Bool = true, delegate: UIScrollViewDelegate? = nil)->UIScrollView {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = backgroundColor
        scrollView.isPagingEnabled = isPagingEnabled
        scrollView.bounces = bounces
        scrollView.showsVerticalScrollIndicator = showsVerticalScrollIndicator
        scrollView.showsHorizontalScrollIndicator = showsHorizontalScrollIndicator
        scrollView.delegate = delegate
        return scrollView
    }
    
    static func cellWith<T: UITableViewCell>(className: T.Type, tableView: UITableView) -> T {
        let classNameStr = String.init(describing: className)
        var cell = tableView.dequeueReusableCell(withIdentifier: classNameStr) as? T
        if (cell == nil) {
            cell = T.init(style: .default, reuseIdentifier: classNameStr)
            cell?.selectionStyle = .none
        }
        return cell!
    }
    
    static func stackViewWith(backgroundColor: UIColor? = nil, arrangedSubviews: [UIView]? = nil, axis: NSLayoutConstraint.Axis, aligment: UIStackView.Alignment, distribution: UIStackView.Distribution, space: CGFloat? = nil) -> UIStackView {
        let stackView: UIStackView
        if let arrangedSubviews = arrangedSubviews {
            stackView = UIStackView.init(arrangedSubviews: arrangedSubviews)
        } else {
            stackView = UIStackView()
        }
        if let backgroundColor = backgroundColor {
            stackView.backgroundColor = backgroundColor
        } 
        stackView.axis = axis
        stackView.alignment = aligment
        stackView.distribution = distribution
        if let space = space {
            stackView.spacing = space
        }
        return stackView
        
    }
    
    static func imageButtonItemWith(image: UIImage, target: Any, action: Selector) -> UIBarButtonItem {
        let buttonItem = UIBarButtonItem.init(image: image.withRenderingMode(.alwaysOriginal), style: .plain, target: target, action: action)
        return buttonItem
    }
    
    static func tapGestureWith(target: Any?, action: Selector?) -> UITapGestureRecognizer {
        let tapGesture = UITapGestureRecognizer(target: target, action: action)
        return tapGesture
    }
    
}


