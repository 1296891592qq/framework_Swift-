//
//  Toaster.swift
//  Caixin
//
//  Created by Origin on 2018/1/27.
//  Copyright © 2018年 Yicai.Network. All rights reserved.
//

import Foundation
import ZKProgressHUD

public class Toaster {
    
    public enum ProgressHUDType {
        case none
        case info
        case error
        case success
        case loading
        case progress
        case hide
    }
    
    
    private static func setProgressHUDStyle() {
        ZKProgressHUD.setMaskStyle(.hide)
        ZKProgressHUD.setAnimationShowStyle(.fade)
        ZKProgressHUD.setAnimationStyle(.circle)
        ZKProgressHUD.setEffectStyle(.dark)
        ZKProgressHUD.setEffectAlpha(1)
        ZKProgressHUD.setFont(UIFont.pingfang(15, .light))
    }
    
    
    
    public static func show(_ text: String?, _ percent: CGFloat?, _ type: ProgressHUDType, _ delay: TimeInterval) {
        
        setProgressHUDStyle()
        DispatchQueue.main.async {
            switch type {
            case .none:
                ZKProgressHUD.showMessage(text)
                ZKProgressHUD.dismiss(delay)
            case .info:
                ZKProgressHUD.showImage(#imageLiteral(resourceName: "info"), status: text)
                ZKProgressHUD.dismiss(delay)
            case .error:
                ZKProgressHUD.showImage(#imageLiteral(resourceName: "error"), status: text)
                ZKProgressHUD.dismiss(delay)
            case .success:
                ZKProgressHUD.showImage(#imageLiteral(resourceName: "success"), status: text)
                ZKProgressHUD.dismiss(delay)
            case .loading:
                ZKProgressHUD.show(text)
            case .progress:
                ZKProgressHUD.showProgress(percent)
                if (percent! >= 1.cg) {
                    ZKProgressHUD.dismiss()
                }
            case .hide:
                ZKProgressHUD.dismiss()
            }
        }
    }
}

/// 显示字符串
///
/// - Parameter text: 配字符串
public func showMessage(_ text: String?, _ delay: TimeInterval = 1) {
    
    Toaster.show(text, nil, Toaster.ProgressHUDType.none, delay)
    
}


/// 显示info
///
/// - Parameter text: 配字符串
public func showInfo(_ text: String?, _ delay: TimeInterval = 1) {
    
    Toaster.show(text, nil, Toaster.ProgressHUDType.info, delay)
}


/// 显示成功
///
/// - Parameter text: 配字符串
public func showSuccess(_ text: String?, _ delay: TimeInterval = 1) {
    
    Toaster.show(text, nil, Toaster.ProgressHUDType.success, delay)
}


/// 显示错误
///
/// - Parameter text: 配字符串
public func showError(_ text: String?, _ delay: TimeInterval = 1) {
    
    Toaster.show(text, nil, Toaster.ProgressHUDType.error, delay)
}


/// 显示加载中
public func showLoading(_ text: String, _ delay: TimeInterval = 1) {
    
    Toaster.show(text, nil, Toaster.ProgressHUDType.loading, delay)
}


/// 显示加载
public func showLoading() {
    
    Toaster.show(nil, nil, Toaster.ProgressHUDType.loading, 0)
    
}


public func showProgress(_ percent: CGFloat) {
    
    Toaster.show(nil, percent, Toaster.ProgressHUDType.progress, 0)
    
}



/// 隐藏加载视图
public func hideCurrentHUD() {
    
    Toaster.show(nil, nil, Toaster.ProgressHUDType.hide, 0)
}
