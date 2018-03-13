//
//  UIFont+Extension.swift
//  Caixin
//
//  Created by Origin on 2017/12/15.
//  Copyright © 2017年 Yicai.Network. All rights reserved.
//

import UIKit

extension UIFont {
    
    public enum FontOption {
        case bold
        case medium
        case regular
        case light
        
        public var value: String {
            switch self {
            case .bold: return isLaterThaniOS9() ? "PingFang-SC-Bold" : ".PingFang-SC-Bold"
            case .medium: return isLaterThaniOS9() ? "PingFangSC-Medium" : ".PingFang-SC-Medium"
            case .regular: return isLaterThaniOS9() ? "PingFangSC-Regular" : ".PingFang-SC-Regular"
            case .light: return isLaterThaniOS9() ? "PingFangSC-Light" : ".PingFang-SC-Light"
            }
        }
    }
    
    
    
    public static func pingfang(_ size: CGFloat, _ option: UIFont.FontOption) -> UIFont {
        
        if UIScreen.main.bounds.size.width == 375 {
            return UIFont(name: option.value, size: size)!
        }
        else if UIScreen.main.bounds.size.width == 320 {
            return UIFont(name: option.value, size: size - 1.5)!
        }
        else {
            return UIFont(name: option.value, size: size + 0.5)!
        }
    }
    
    
    private static func isLaterThaniOS9() -> Bool {
        
        if #available(iOS 9.0, *) {
            return true
        }
        return false
    }
    
}
