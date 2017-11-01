//
//  JGCacheManager.swift
//  JGCache
//
//  Created by 李保君 on 2017/11/1.
//  Copyright © 2017年 JGCache. All rights reserved.
//

import UIKit
import ObjectMapper

open class JGCacheManager: NSObject {
    
    /// 单例
    open static let `default` = JGCacheManager.init()
    fileprivate override init() { super.init() }
    
    /// 写入缓存对象
    ///
    /// - Parameters:
    ///   - object: 缓存数据对象
    ///   - cacheKey: cacheKey 的分类。同一对象不同数据进行分类
    /// - Returns: 返回成功或者失败
    open func writeCacheModel<T:Mappable>(object:T, cacheKey:String = "default") -> Bool {
        do {
            let cacheName = T.self
            let url = try JGFileManager.cacheDirectory(isCreateNewFile: true, cacheName: "\(cacheName)_\(cacheKey)")
            let string = object.toJSONString() ?? ""
            try string.write(to: url, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            return false
        }
        return true
    }
    
    /// 获取缓存对象
    ///
    /// - Parameters:
    ///   - class: 对象类型
    ///   - cacheKey:cacheKey 的分类。同一对象不同数据进行分类
    /// - Returns: 返回请求的对象
    open func getCacheModel<T:Mappable>(class:T.Type, cacheKey:String = "default") -> T? {
        do {
            let cacheName = T.self
            let jsonString = try String(contentsOf: JGFileManager.cacheDirectory(isCreateNewFile: false, cacheName: "\(cacheName)_\(cacheKey)"))
            return Mapper<T>().map(JSONString: jsonString) ?? nil
        } catch {
            return nil
        }
    }
    
    /// 移除缓存的对象
    ///
    /// - Parameters:
    ///   - class: 对象类型
    ///   - cacheKey: cacheKey 的分类。同一对象不同数据进行分类
    /// - Returns: 返回成功或者失败
    open func removeCacheModel<T:Mappable>(class:T.Type, cacheKey:String = "default") -> Bool {
        do {
            let cacheName = T.self
            let url = try JGFileManager.cacheDirectory(isCreateNewFile: true, cacheName: "\(cacheName)_\(cacheKey)")
            try FileManager.default.removeItem(at: url)
        } catch {
            return false
        }
        
        return true
    }
}
