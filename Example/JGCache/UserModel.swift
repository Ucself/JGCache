//
//  UserModel.swift
//  JGCache_Example
//
//  Created by 李保君 on 2017/11/1.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit
import ObjectMapper

class UserModel: Mappable {

    var id:String = ""
    var name:String = ""
    
    init() {}
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
}
