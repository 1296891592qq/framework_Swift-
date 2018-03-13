//
//  ObDebug.swift
//  Caixin
//
//  Created by Origin on 2018/1/27.
//  Copyright © 2018年 Yicai.Network. All rights reserved.
//

import Foundation
import ZKProgressHUD

public class Observer {
    
    public enum ObserverOptions: Int {
        case debug, verbose, warning, error
    }
    
    /// 设置全局输出级别
    private static var level: ObserverOptions = ObserverOptions.debug
    
    /// 当前输出
    private(set) var option: ObserverOptions?
    public convenience init(_ option: ObserverOptions?) {
        self.init()
        self.option = option
    }
    private init() {}
    
}

public struct Ob {
    public static var debug: Observer = Observer(Observer.ObserverOptions.debug)
    public static var verbose: Observer = Observer(Observer.ObserverOptions.verbose)
    public static var warning: Observer = Observer(Observer.ObserverOptions.warning)
    public static var error: Observer = Observer(Observer.ObserverOptions.error)
}


extension Observer {
    
    /// 设置全局输出级别
    /// 默认 debug 模式开启
    public static func setLoggerLevel(_ level: ObserverOptions) {
        Observer.level = level
    }
    
    public func printlf<T>(_ messages: T..., file: String = #file, line: Int = #line, function: String = #function) {
        #if DEBUG
            
            var text: String = ""
            switch self.option! {
            case .debug: text = " debug "
            case .verbose: text = "verbose"
            case .warning: text = "warning"
            case .error: text = " error "
            }
            if showLogger() {
                print("**************************************************************")
                print("*                 \(text)  MESSAGE START                     *")
                print("**************************************************************")
                print("file: \(file.components(separatedBy: "/").last ?? "")")
                print("func: \(function)")
                print("line: \(line)")
                for i in 0 ..< messages.count {
                    print("message\(i): \(messages[i])")
                }
                print("**************************************************************")
                print("*                       MESSAGE END                          *")
                print("**************************************************************")
            }
        #endif
    }
    
    
    
    public func toast(text: String?) {
        #if DEBUG
            if showLogger() {
                showMessage(text)
            }
        #endif
    }
    
    private func showLogger() -> Bool {
        var logger: Bool = false
        if Observer.level.rawValue <= self.option!.rawValue {
            logger = true
        } else {
            logger = false
        }
        return logger
    }
    
}
