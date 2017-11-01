//
//  ViewController.swift
//  JGCache
//
//  Created by 李保君 on 10/31/2017.
//  Copyright (c) 2017 李保君. All rights reserved.
//

import UIKit
import JGCache

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId")
        
        switch indexPath.row {
        case 0:
            cell?.textLabel?.text = "write default"
        case 1:
            cell?.textLabel?.text = "get default"
        case 2:
            cell?.textLabel?.text = "remove default"
        case 3:
            cell?.textLabel?.text = "write for key Li"
        case 4:
            cell?.textLabel?.text = "get for key Li"
        case 5:
            cell?.textLabel?.text = "remove for key Li"
            
        default:
            break
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let userDefault = UserModel.init()
            userDefault.id = "我是default的id"
            userDefault.name = "我是default的name"
            //写入缓存
            if JGCacheManager.default.writeCacheModel(object: userDefault) {
                print("👉userDefault write Successful")
            }
            else {
                print("👉userDefault write failure")
            }
        case 1:
            //读取缓存
            if let userDefault = JGCacheManager.default.getCacheModel(class: UserModel.self) {
                print("👉userDefault get id -> \(userDefault.id);name -> \(userDefault.name)")
            }
            else {
                print("👉userDefault get nil")
            }
            
        case 2:
            //移除缓存
            if JGCacheManager.default.removeCacheModel(class: UserModel.self) {
                print("👉userDefault remove Successful")
            }
            else {
                print("👉userDefault remove failure")
            }
        case 3:
            let userLi = UserModel.init()
            userLi.id = "我是Li的id"
            userLi.name = "我是Li的name"
            //写入缓存
            if JGCacheManager.default.writeCacheModel(object: userLi, cacheKey:"Li") {
                print("👉for key Li write Successful")
            }
            else {
                print("👉for key Li write failure")
            }
        case 4:
            //读取缓存
            if let userLi = JGCacheManager.default.getCacheModel(class: UserModel.self, cacheKey:"Li") {
                print("👉for key Li get id -> \(userLi.id);name -> \(userLi.name)")
            }
            else {
                print("👉for key Li get nil")
            }
        case 5:
            //移除缓存
            if JGCacheManager.default.removeCacheModel(class: UserModel.self, cacheKey:"Li") {
                print("👉for key Li remove Successful")
            }
            else {
                print("👉for key Li remove failure")
            }
            
        default:
            break
        }
    }
    

    @IBAction func writeButtonClick(_ sender: Any) {
        
        _ = JGCacheManager.default.writeCacheModel(object: UserModel())
    }
    
    @IBAction func readButtonClick(_ sender: Any) {
        if let user:UserModel = JGCacheManager.default.getCacheModel(class: UserModel.self) {
            print("user.id -> \(user.id) \n user.name -> \(user.name)")
        }
        
    }
    
    @IBAction func clearButtonClick(_ sender: Any) {
        _ = JGCacheManager.default.removeCacheModel(class: UserModel.self)
    }
    
}

