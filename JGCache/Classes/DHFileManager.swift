//
//  DHFileManager.swift
//  DoctorHealth
//
//  Created by Frank Li on 2017/10/25.
//  Copyright © 2017年 doctorworker. All rights reserved.
//

import Foundation

class DHFileManager {
    class func documentDirectory() -> URL {
        let URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return URL
    }
    
    class func libraryDirectory() -> URL {
        let URL = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first!
        return URL
    }
    
    class func cachesDirectory() -> URL {
        let URL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        return URL
    }
}
