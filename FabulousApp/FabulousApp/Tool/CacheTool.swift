//
//  CacheTool.swift
//  BajieSleep
//
//  Created by 邬文文 on 2020/8/13.
//  Copyright © 2020 邬文文. All rights reserved.
//

import Foundation

enum CacheKey: String {
    case verifyButtonDidEnterBackgroundTime
    case loginInfo
}

class CacheTool {
    
    static func save<T: Codable>(value: T, forKey: CacheKey) {
        do {
            //归档
            let encoder = JSONEncoder()
            let data = try encoder.encode(value)
            //存本地
            UserDefaults.standard.set(data, forKey: forKey.rawValue)
            UserDefaults.standard.synchronize()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    static func retrieve<T: Codable>(valueType: T.Type, forKey: CacheKey) -> T? {
        if let data = UserDefaults.standard.object(forKey: forKey.rawValue) as? Data {
            //解档
            do {
                let decoder = JSONDecoder()
                let value = try decoder.decode(T.self, from: data)
                return value
            } catch let error {
                print(error.localizedDescription)
                return nil
            }
        } else {
            return  UserDefaults.standard.value(forKey: forKey.rawValue) as? T
        }
    }
    
    static func delete(forKey: CacheKey) {
        UserDefaults.standard.removeObject(forKey: forKey.rawValue)
        UserDefaults.standard.synchronize()
    }
    
}

extension CacheTool {
    
    static func saveFile(data: Data, name: String) -> URL {
        let filePath = "\(CACHE_PATH)/\(name)"
        FileManager.default.createFile(atPath: filePath, contents: data, attributes: nil)
        return URL(fileURLWithPath:filePath) //返回文件路径
    }
    
    static func deleteFile(forPath: URL) {
        do {
            try FileManager.default.removeItem(at: forPath)
            print("成功删除\(forPath)")
        } catch {
            print("删除失败\(forPath)")
        }
    }
    
    static let CACHE_PATH = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
    
}


