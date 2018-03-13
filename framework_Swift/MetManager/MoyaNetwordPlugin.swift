//
//  MoyaNetwordPlugin.swift
//  smart_Swift
//
//  Created by Origin on 2018/3/9.
//  Copyright © 2018年 mac. All rights reserved.
//

import Foundation
import Moya
import Result

public class MoyaNetwordPlugin: PluginType {
    
    /// 在请求发送前处理
    /// 比如  弹窗什么的
    public func willSend(_ request: RequestType, target: TargetType) {
        
    }
    
    
    /// 接收到参数
    /// 比如  关闭弹窗什么的
    public func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        
    }
    
}
