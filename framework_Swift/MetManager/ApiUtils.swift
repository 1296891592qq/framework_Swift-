//
//  ApiUtls.swift
//  smart_Swift
//
//  Created by Origin on 2018/3/9.
//  Copyright © 2018年 mac. All rights reserved.
//

import Foundation
import Moya

public class ApiUtils {
    
    public var mParams: [String: Any?]?
    
    /// 添加参数
    public func update(_ key: String, _ value: Any?) -> ApiUtils {
        
        if mParams == nil {
            mParams = [String: Any?]()
        }
        mParams?.updateValue(value, forKey: key)
        return self
    }
    
    
    /// 构建
    ///
    /// - Parameter enecypt: 是否加密 后续处理
    public func builder(_ enecypt: Bool = false) -> Task {
        let bean = RequestBean()
        bean.content = mParams
        return Task.requestParameters(parameters: bean.toJSON()!, encoding: JSONEncoding.default)
    }
    

    /// 批量添加 参数
    public func update(_ values: [String: Any?]) -> ApiUtils {
        if mParams == nil {
            mParams = [String: Any?]()
        }
        
        for (key, value) in values {
            mParams?.updateValue(value, forKey: key)
        }
        
        return self
    }
    
}
