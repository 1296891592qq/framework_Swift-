//
//  BaseBean.swift
//  smart_Swift
//
//  Created by Origin on 2018/3/9.
//  Copyright © 2018年 mac. All rights reserved.
//

import Foundation
import HandyJSON

public class ResponseBean: HandyJSON {
    
    public var content: Any?
    
    public required init() { }
}

public class RequestBean: HandyJSON {
    public var content: Any?
    
    public required init() {}
}


public enum BaseNetError: Error {
    case DeserializerError
}

public class SampleData: HandyJSON {
    public required init() {}
}
