//
//  AlertButton.swift
//  Caixin
//
//  Created by Origin on 2018/1/27.
//  Copyright © 2018年 Yicai.Network. All rights reserved.
//

import UIKit

/// MARK: - 按钮主题
public struct AlertButtonTheme {
    public var textColor: UIColor
    public var textFont: UIFont
    
    public init(textColor: UIColor = UIColor.black,
                textFont: UIFont = UIFont.systemFont(ofSize: 16)) {
        self.textColor = textColor
        self.textFont = textFont
    }
    
    
}

public enum AlertButtonStyle {
    case cancel
    case `default`
    case destructive
}


public class AlertButton {
    public var theme: AlertButtonTheme  = AlertButtonTheme()
    public var image: UIImage?
    public var text: String?
    public var style: AlertButtonStyle
    
    public init(image: UIImage? = nil,
                text: String? = nil,
                theme: AlertButtonTheme? = nil,
                style: AlertButtonStyle = .default) {
        self.image = image
        self.text = text
        if let theme = theme {
            self.theme = theme
        }
        self.style = style
    }
    
    /// 根据主题色生成按钮
    public func createButton(_ tag: Int) -> UIButton {
        let btn = UIButton(type: .system)
        btn.setTitle(text, for: .normal)
        btn.tag = tag
        btn.setImage(image, for: .normal)
        btn.setTitleColor(theme.textColor, for: .normal)
        btn.titleLabel?.font = theme.textFont
        
        return btn
    }
}
