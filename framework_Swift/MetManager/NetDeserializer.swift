//
//  NetDeserializer.swift
//  smart_Swift
//
//  Created by Origin on 2018/3/9.
//  Copyright © 2018年 mac. All rights reserved.
//

import Foundation
import HandyJSON
import Moya
import RxSwift
/// 使用 RxSwift
extension PrimitiveSequence where TraitType == MaybeTrait, ElementType == Response {
    
    public func filterStatusSuccess() -> Maybe<ElementType> {
        return filter({ (response) -> Bool in
            return response.filterStatusSuccess()
        })
    }
    
    public func mapObject<T: HandyJSON>(_ type: T.Type) -> Maybe<T> {
        return flatMap({ (response) -> Maybe<T> in
            return Maybe.just(T.deserialize(from: response.data.string, designatedPath: "content") ?? T())
        })
    }
    
    /// 这个字段根据你公司的返回决定, 可使用可不适用, 若是固定 直接适用上面那个方法
    public func mapObject<T: HandyJSON>(_ type: T.Type, _ path: String = "content") -> Maybe<T> {
        return flatMap({ (response) -> Maybe<T> in
            return Maybe.just(T.deserialize(from: response.data.string, designatedPath: "content") ?? T())
        })
    }

    public func mapArray<T: HandyJSON>(_ type: T.Type) -> Maybe<[T]> {
        return flatMap({ (response) -> Maybe<[T]> in
            return Maybe.just((([T].deserialize(from: response.data.string, designatedPath: "content") as? [T]) ?? [T]()))
        })
    }
    
    
    public func mapArray<T: HandyJSON>(_ type: T.Type, _ path: String = "content") -> Maybe<[T]> {
        return flatMap({ (response) -> Maybe<[T]> in
            return Maybe.just((([T].deserialize(from: response.data.string, designatedPath: path) as? [T]) ?? [T]()))
        })
    }
    
    
}

public extension Response {
    
    public func filterStatusSuccess() -> Bool {
        if let res = ResponseBean.deserialize(from: self.data.string) {
            /// 根据后台字段判断是否成功若成功则会进入下一步, 没有成功则该请求会被拦截, 后面的请求都不会走
            /// Moya 会自动发送 onCompleted() 事件. 有后续处理会在onCompleted 方法块内处理 参考示例 (LoginViewController)
            return true
        }
        /// 解析失败, 直接失败
        return false
    }
    
}


public extension Response {
    
    public func mapObject<T: HandyJSON>(_ type: T.Type) throws -> T {
        guard let t = T.deserialize(from: self.data.string) else {
            throw BaseNetError.DeserializerError
        }
        return t
    }
    
    public func mapArray<T: HandyJSON>(_ type: T.Type) throws -> [T] {
        guard let t = [T].deserialize(from: self.data.string) else {
            throw BaseNetError.DeserializerError
        }
        return t as! [T]
    }
    
}


/// 解析请求
public extension Task {
    
    
    /// 默认请求, 不传任何参数
    public static func `default`() -> Task {
        let bean = RequestBean()
        bean.content = SampleData()
        return Task.requestParameters(parameters: bean.toJSON()!, encoding: JSONEncoding.default)
    }
    
    public static func request(_ requestBean: HandyJSON) -> Task {
        let bean = RequestBean()
        bean.content = requestBean
        return Task.requestParameters(parameters: bean.toJSON()!, encoding: JSONEncoding.default)
    }

    
}
