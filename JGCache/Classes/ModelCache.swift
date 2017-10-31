//
//  modelCache.swift
//  DoctorHealth
//
//  Created by Frank Li on 2017/10/25.
//  Copyright © 2017年 doctorworker. All rights reserved.
//

import Foundation
import ObjectMapper

extension Mappable {
    private static func cacheDirectory(isCreateFile:Bool, name:String) throws -> URL {
        let url:URL = DHFileManager.documentDirectory().appendingPathComponent("\(name)_Data")
        if isCreateFile && !FileManager.default.fileExists(atPath: url.path) {
            let attr: [FileAttributeKey: Any] = [FileAttributeKey(rawValue: FileAttributeKey.protectionKey.rawValue): FileProtectionType.complete]
            let ret = FileManager.default.createFile(atPath: url.path, contents: nil, attributes: attr)
            if ret {
                return url
            } else {
                throw NSError.init(domain: "fail", code: 10001, userInfo: ["fail" : "文件创建失败"])
            }
        }
        return url
    }
    
    static func getCacheModel<T:Mappable>(class:T.Type) -> T? {
        do {
            let jsonString = try String(contentsOf: cacheDirectory(isCreateFile: false, name: "\(self)"))
            return Mapper<T>().map(JSONString: jsonString) ?? nil
        } catch {
            return nil
        }
    }
    
    func writeCacheModel() -> Bool {
        do {
            let modelType = type(of: self) 
            let url = try Self.cacheDirectory(isCreateFile: true, name: "\(modelType)")
            let string = self.toJSONString() ?? ""
            try string.write(to: url, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            return false
        }
        return true
    }
    
    static func removeCacheModel() -> Bool {
        do {
            let url = try Self.cacheDirectory(isCreateFile: true, name: "\(self)")
            try FileManager.default.removeItem(at: url)
        } catch {
            return false
        }
        
        return true
    }
}
