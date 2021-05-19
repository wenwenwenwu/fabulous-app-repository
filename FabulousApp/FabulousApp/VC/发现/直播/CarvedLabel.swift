//
//  LoukongText.swift
//  FabulousApp
//
//  Created by 邬文文 on 2021/5/17.
//

import Foundation

class CarvedLabel: UILabel {
    
    //MARK: - LifeCycle
    init(font: UIFont? = nil, backGroundColor: UIColor? = nil, numberOfLines: Int? = nil, textAlignment: NSTextAlignment? = nil, text: String? = nil) {
        self.label = CreateTool.labelWith(font: font, backGroundColor: backGroundColor, numberOfLines: numberOfLines, textAlignment: textAlignment, text: text)
        super.init(frame: .zero)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawText(in rect: CGRect) {
        //获取图形上下文
        guard let context = UIGraphicsGetCurrentContext() else { return }
        //保存
        context.saveGState()
        //设置图形混合模式
        /**
         Apple额外定义的枚举
         R: Result, 表示混合结果
         S: Source, 表示源颜色(Sa对应透明度值: 0.0-1.0)
         D: Destination, 表示目标颜色(Da对应透明度值: 0.0-1.0)
         */
        context.setBlendMode(.destinationOut) //R = D*(1 - Sa)
        //绘制一个同样大小的label
        label.frame = CGRect(origin: .zero, size: rect.size)
        label.layer.draw(in: context)
        //重新保存
        context.restoreGState()
    }
    
    //MARK: - Data
    var label: UILabel
    
}
