//
//  BaseService.swift
//  smart_Swift
//
//  Created by Origin on 2018/3/9.
//  Copyright © 2018年 mac. All rights reserved.
//

import Foundation
import Moya

public extension TargetType {
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    
    public var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    // 发布版本
    public var baseURL: URL {
        return URL(string: "https://s1.zoneonetech.com:1443/")! /// 基础 URL
    }
    
    public var mqttPort: Int {
        return 8243
    }
    
    public var mqttHost: String {
        return "s1.zoneonetech.com"
    }
    
    
    
//    // 测试版本
//    public var baseURL: URL {
//        return URL(string: "http://192.168.1.191:3000/")! /// 基础 URL
//    }
//
//    public var mqttPort: Int {
//        return 8243
//    }
//
//    public var mqttHost: String {
//        return "192.168.1.191"
//    }
    
}
