//
//  JGFileManager.swift
//  JGCache
//
//  Created by 李保君 on 2017/11/1.
//  Copyright © 2017年 JGCache. All rights reserved.
//

import UIKit

class JGFileManager: NSObject {
    
    /// 获取缓存的文件路径
    ///
    /// - Parameters:
    ///   - isCreateNewFile: 是否创建新文件覆盖
    ///   - cacheName: 缓存文件名
    ///   - pathURL: 缓存文件路径，默认在document 下
    /// - Returns: 返回URL
    /// - Throws: 是否有异常返回
    class func cacheDirectory(isCreateNewFile:Bool,
                              cacheName:String,
                              pathURL:URL = JGFileManager.documentDirectory()) throws -> URL {
        //获取UUID
        let uuid:String = UIDevice.current.identifierForVendor?.uuidString ?? ""
        //文件夹路径
        let urlFolder:URL = pathURL.appendingPathComponent("\(uuid)_JGCache", isDirectory: true)
        if !FileManager.default.fileExists(atPath: urlFolder.path){
            try FileManager.default.createDirectory(at: urlFolder, withIntermediateDirectories: true, attributes: nil)
        }
        //文件路径
        let urlFile:URL = urlFolder.appendingPathComponent("\(cacheName)_Data", isDirectory: false)
        if isCreateNewFile && !FileManager.default.fileExists(atPath: urlFile.path) {
            let attr: [FileAttributeKey: Any] = [FileAttributeKey(rawValue: FileAttributeKey.protectionKey.rawValue): FileProtectionType.complete]
            let ret = FileManager.default.createFile(atPath: urlFile.path, contents: nil, attributes: attr)
            if ret {
                return urlFile
            } else {
                throw NSError.init(domain: "com.JGCache.error", code: 10001, userInfo: [NSLocalizedDescriptionKey: "file create fail."])
            }
        }
        return urlFile
    }
    //MARK: Directory URL
    /// document URL
    ///
    /// - Returns: document URL
    class func documentDirectory() -> URL {
        let URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return URL
    }
    
    /// library URL
    ///
    /// - Returns: library URL
    class func libraryDirectory() -> URL {
        let URL = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first!
        return URL
    }
    
    /// caches URL
    ///
    /// - Returns: caches URL
    class func cachesDirectory() -> URL {
        let URL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        return URL
    }
}
