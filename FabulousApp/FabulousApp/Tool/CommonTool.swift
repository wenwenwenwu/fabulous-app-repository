//
//  Tool.swift
//  Daoqi
//
//  Created by 邬文文 on 2021/5/6.
//

import Foundation

//MARK: - 全局方法
func rem(_ number: CGFloat) -> CGFloat {
    number * (SCREEN_WIDTH / 375)
}

func prettyJSON<T: Codable>(_ model: T) -> String {
    do {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try encoder.encode(model)
        return String(data: data, encoding: .utf8)!
    } catch  {
        return "\(model)"
    }
}

//打印信息所属文件、方法及行数
func smartPrint(_ message: Any = "", filePath: String = #file, function:String = #function, rowCount: Int = #line) {
    #if DEBUG
    let fileName = (filePath as NSString).lastPathComponent.replacingOccurrences(of: ".swift", with: "")
    print("\(fileName) -> \(function) -> \(rowCount)\n\(message)")
    #endif
}
