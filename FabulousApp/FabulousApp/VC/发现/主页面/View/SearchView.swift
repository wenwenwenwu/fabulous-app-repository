//
//  SearchView.swift
//  FabulousApp
//
//  Created by 邬文文 on 2021/5/13.
//

class SearchView: UIView, UITextFieldDelegate {
    
    //MARK: - LifeCycle
    init() {
        super.init(frame: .zero)
        backgroundColor = WHITE_FFFFFF
        addSubview(grayContainer)
        grayContainer.addSubview(searchIcon)
        grayContainer.addSubview(textField)
        deleteButton.isHidden = true
        grayContainer.addSubview(deleteButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        grayContainer.snp.makeConstraints { (make) in
            make.height.equalTo(rem(34))
            make.left.equalTo(rem(10))
            make.right.equalTo(rem(-10))
            make.centerY.equalToSuperview()
        }
        searchIcon.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: rem(16), height: rem(15)))
            make.centerY.equalToSuperview()
            make.left.equalTo(rem(6))
        }
        textField.snp.makeConstraints { (make) in
            make.left.equalTo(searchIcon.snp.right).offset(rem(5))
            make.top.bottom.equalToSuperview()
            make.right.equalTo(deleteButton.snp.left)
        }
        deleteButton.snp.makeConstraints { (make) in
            make.width.size.equalTo(rem(18))
            make.right.equalTo(rem(-11))
            make.centerY.equalToSuperview()
        }
    }
    
    //MARK: - Action
    @objc func textfieldDidBeginEditing() {
        deleteButton.isHidden = false
    }
    
    @objc func textfieldDidEndEdit() { //点击键盘“完成按钮”
        textField.resignFirstResponder()
        deleteButton.isHidden = textField.text!.isEmpty
    }
    
    @objc func deleteButtonAction() {
        textField.text = ""
        textfieldDidEndEdit()
    }
    
    
    
    //MARK: - Setup
    func setupTextfieldPlaceholder(_ text: String) {
        textField.attributedPlaceholder = NSAttributedString.init(string: "搜索\(text)", attributes: [.foregroundColor : GRAY_666666, .font: FONT_14])
    }
    
    //MARK: - Component
    lazy var grayContainer: UIView = {
        let view = CreateTool.viewWith(color: GRAY_F0F0F0)
        view.addCorner(cornerRadius: rem(10))
        return view
    }()
    
    lazy var searchIcon = CreateTool.imageViewWith(image: #imageLiteral(resourceName: "search-dark"))
    
    lazy var textField: UITextField = {
        let textField = CreateTool.textFieldWith(font: FONT_14, textColor: BLACK_000000)
        textField.attributedPlaceholder = NSAttributedString.init(string: "搜索全部", attributes: [.foregroundColor : GRAY_666666, .font: FONT_14])
        textField.addTarget(self, action: #selector(textfieldDidBeginEditing), for: UIControl.Event.editingDidBegin)
        textField.addTarget(self, action: #selector(textfieldDidEndEdit), for: UIControl.Event.editingDidEnd)
        return textField
    }()
    
    lazy var deleteButton: UIButton = {
        let button = CreateTool.normalButtonWith(backGroundImage: #imageLiteral(resourceName: "search-dark"), target: self, action: #selector(deleteButtonAction))
        return button
    }()
    
    //MARK: - Data
    var keyword = ""
    
}
