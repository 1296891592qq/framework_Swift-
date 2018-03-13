//
//  AlertInput.swift
//  Caixin
//
//  Created by Origin on 2018/1/27.
//  Copyright © 2018年 Yicai.Network. All rights reserved.
//

import UIKit

public struct AlertInputTheme {
    public var textColor: UIColor
    public var textFont: UIFont
    public var textAligment: NSTextAlignment
    public var leftImage: UIImage?
    public var rightImage: UIImage?
    public var rightViewMode: UITextFieldViewMode
    public var leftViewMode: UITextFieldViewMode
    
    public init(textColor: UIColor = UIColor.black,
                textFont: UIFont = UIFont.systemFont(ofSize: 14),
                textAligment: NSTextAlignment = .left,
                leftImage: UIImage? = nil,
                rightImage: UIImage? = nil,
                leftViewMode: UITextFieldViewMode = .always,
                rightViewMode: UITextFieldViewMode = .whileEditing) {
        self.textColor = textColor
        self.textFont = textFont
        self.textAligment = textAligment
        self.leftImage = leftImage
        self.rightImage = rightImage
        self.leftViewMode = leftViewMode
        self.rightViewMode = rightViewMode
    }
}

public class AlertInput {
    public var placeholder: String?
    public var theme: AlertInputTheme = AlertInputTheme()
    
    public convenience init(_ placeholder: String? = nil,
                            theme: AlertInputTheme? = nil) {
        self.init()
        self.placeholder = placeholder
        if let theme = theme {
            self.theme = theme
        }
    }
    
    public func createInput() -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.textColor = theme.textColor
        textField.font = theme.textFont
        textField.textAlignment = theme.textAligment
        if let leftImage = theme.leftImage {
            let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
            let leftImageView = UIImageView(image: leftImage)
            leftImageView.frame = CGRect(x: 0, y: 0, width: 18, height: 18)
            leftImageView.contentMode = .scaleAspectFit
            leftImageView.center = leftView.center
            leftView.addSubview(leftImageView)
            textField.leftView = leftView
            textField.leftViewMode = theme.leftViewMode
        } else {
            let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 40))
            textField.leftView = leftView
            textField.leftViewMode = theme.leftViewMode
        }
        if let rightImage = theme.rightImage {
            let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 220, height: 40))
            let rightImageView = UIImageView(image: rightImage)
            rightImageView.frame = CGRect(x: 0, y: 0, width: 18, height: 18)
            rightImageView.contentMode = .scaleAspectFit
            rightImageView.center = rightView.center
            rightView.addSubview(rightImageView)
            textField.rightView = rightView
            textField.rightViewMode = theme.rightViewMode
        } else {
            textField.clearButtonMode = .whileEditing
        }
        
        return textField
    }
}
