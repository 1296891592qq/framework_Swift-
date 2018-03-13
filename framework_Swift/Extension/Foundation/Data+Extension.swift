//
//  Data+Extension.swift
//  smart_Swift
//
//  Created by Origin on 2018/3/9.
//  Copyright © 2018年 mac. All rights reserved.
//

import Foundation

extension Data {
    
    public var string: String {
        return String(data: self, encoding: String.Encoding.utf8) ?? ""
    }
    
}
