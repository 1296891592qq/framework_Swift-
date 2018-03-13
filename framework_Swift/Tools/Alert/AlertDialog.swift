//
//  AlertDialog.swift
//  Caixin
//
//  Created by Origin on 2018/1/27.
//  Copyright © 2018年 Yicai.Network. All rights reserved.
//

import Foundation
import UIKit

public let AlertWidth: CGFloat = 270
public let AlertMaxHeight: CGFloat = UIScreen.main.bounds.size.height - 180

public let ActionSheetWidth: CGFloat = UIScreen.main.bounds.size.width - 40
public let ActionSheetMaxHeight: CGFloat = UIScreen.main.bounds.size.height - 180

public struct AlertDialogTheme {
    public var titleColor: UIColor
    public var detailColor: UIColor
    public var titleAligment: NSTextAlignment
    public var detailAligment: NSTextAlignment
    public var titleFont: UIFont
    public var detailFont: UIFont
    
    public init(titleColor: UIColor = UIColor.black,
                detailColor: UIColor = UIColor.black,
                titleFont: UIFont = UIFont.systemFont(ofSize: 16),
                detailFont: UIFont = UIFont.systemFont(ofSize: 14),
                titleAligment: NSTextAlignment = .center,
                detailAligment: NSTextAlignment = .center) {
        self.titleColor = titleColor
        self.detailColor = detailColor
        self.titleFont = titleFont
        self.detailFont = detailFont
        self.titleAligment = titleAligment
        self.detailAligment = detailAligment
    }
}


public class AlertDialog: UIViewController {
    
    /// 弹窗样式
    public enum AlertDialogStyle {
        case alert
        case actionSheet
    }
    
    /// 主题
    private(set) var theme: AlertDialogTheme = AlertDialogTheme()
    /// 样式
    private(set) var style: AlertDialogStyle = .alert
    /// 标题
    private(set) var titleStr: String?
    /// 消息详情
    private(set) var message: String?
    /// 自定义内容视图
    private(set) var contentView: UIView?
    /// 输入框
    private(set) var inputs: [AlertInput] = [AlertInput]()
    /// 按钮
    private(set) var buttons: [AlertButton] = [AlertButton]()
    /// 当前选择的输入框
    private var currentTextField: UITextField?
    private var keyboardShow = false
    
    private var alertView: UIView = UIView()
    private lazy var contentScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        return scrollView
    }()
    
    private(set) var clickListner: ((_ alertDialog: AlertDialog, _ index: Int) -> Void)?
    
    public static func builder(_ theme: AlertDialogTheme? = nil) -> AlertDialog {
        return self.init(nibName: nil, bundle: nil, theme)
    }
    
    public required init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, _ theme: AlertDialogTheme?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        if let theme = theme {
            self.theme = theme
        }
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
//        builderSubviews()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @discardableResult
    public func update(style: AlertDialogStyle) -> AlertDialog {
        self.style = style
        return self
    }
    
    @discardableResult
    public func update(title: String?) -> AlertDialog {
        self.titleStr = title
        return self
    }
    
    @discardableResult
    public func update(message: String?) -> AlertDialog {
        self.message = message
        return self
    }
    
    private func isAlert() -> Bool { return self.style == .alert }
    /// 构建视图
    private func builderSubviews() {
        
        /// step1. 计算高度
        var viewHeight: CGFloat = 10
        
        /// 1. 标题高度
        var titleHeight: CGFloat = 0
        if let title = self.titleStr {
            var size = CGSize.zero
            if isAlert() {
                size = title.size(theme.titleFont, CGSize(width: AlertWidth-20, height: 0))
            } else {
                size = title.size(theme.titleFont, CGSize(width: ActionSheetWidth-20, height: 0))
            }
            let label = UILabel()
            label.text = title
            label.font = theme.titleFont
            label.textColor = theme.titleColor
            label.textAlignment = theme.titleAligment
            label.numberOfLines = 0
            label.frame = CGRect(x: 10, y: 10, width: isAlert() ? AlertWidth-20 : ActionSheetWidth-20, height: size.height)
            alertView.addSubview(label)
            titleHeight = size.height
            viewHeight += titleHeight + 10
        }
        
        /// 2. 滚动视图高度
        var scrollHeight: CGFloat = 0
        var messageHight: CGFloat = 0
        if let message = self.message {
            var size = CGSize.zero
            if isAlert() {
                size = message.size(theme.detailFont, CGSize(width: AlertWidth-20, height: 0))
            } else {
                size = message.size(theme.detailFont, CGSize(width: ActionSheetWidth-20, height: 0))
            }
            
            let label = UILabel()
            label.text = message
            label.font = theme.detailFont
            label.textColor = theme.detailColor
            label.textAlignment = theme.detailAligment
            label.numberOfLines = 0
            label.frame = CGRect(x: 10, y: 0, width: size.width, height: size.height)
            contentScrollView.addSubview(label)

            
            messageHight = size.height
            /// 滚动视图高度
            scrollHeight += size.height
        }
        
        /// 3. 自定义视图高度
        if let contentView = self.contentView {
            scrollHeight += 10 /// 默认距离顶部视图距离为10
            let size = contentView.frame.size
            contentView.frame = CGRect(x: 0, y: scrollHeight, width: AlertWidth, height: size.height)
            contentScrollView.addSubview(contentView)
            scrollHeight += size.height
            scrollHeight += 10
        }
        
        print(scrollHeight)
        
        /// 4. 输入框高度
        if inputs.count > 0 {
            scrollHeight += 10 /// 默认距离顶部视图距离为10
            
            for i in 0 ..< inputs.count {
                let input = inputs[i]
//                let subview = UIView(frame: CGRect(x: 10, y: scrollHeight, width: AlertWidth-20, height: 50))
                
                let textfield = input.createInput()
                textfield.delegate = self
                textfield.layer.borderWidth = 0.5
                textfield.layer.borderColor = UIColor.lightGray.cgColor
                textfield.layer.cornerRadius = 4
                textfield.frame = CGRect(x: 10, y: 2.5 + scrollHeight, width: (isAlert() ? AlertWidth : ActionSheetWidth) - 20, height: 45)
                
//                subview.addSubview(textfield)
                contentScrollView.addSubview(textfield)
                scrollHeight += 50
            }
            
//            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
//            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        }
        
        print(scrollHeight)
        

        
        /// 按钮高度
        var buttonHeight: CGFloat = 0
        var containsCancel: Bool = false
        if buttons.count > 0 {
            if isAlert() {
                if buttons.count <= 2 {
                    buttonHeight = 50
                } else {
                    buttonHeight = 50 * CGFloat(buttons.count)
                }
            } else {
                /// 判断是否包含取消按钮
                /// actionSheet 默认包含一个取消按钮
                for btn in buttons {
                    if btn.style == .cancel {
                        containsCancel = true
                    }
                }
                /// 如果包含取消按钮 则去除此按钮之后 计算高度
                if containsCancel {
                    buttonHeight = CGFloat(buttons.count - 1) * 60
                } else {
                    buttonHeight = CGFloat(buttons.count) * 60
                }
            }
        }
        
        if isAlert() {
            if titleHeight + 30 + scrollHeight + buttonHeight > AlertMaxHeight {
                contentScrollView.contentSize = CGSize(width: AlertWidth, height: scrollHeight)
                contentScrollView.frame = CGRect(x: 0, y: viewHeight, width: AlertWidth, height: AlertMaxHeight - viewHeight - buttonHeight - 10)
                viewHeight = AlertMaxHeight
            } else {
                contentScrollView.contentSize = CGSize(width: AlertWidth, height: scrollHeight)
                contentScrollView.frame = CGRect(x: 0, y: viewHeight, width: AlertWidth, height: scrollHeight)
                viewHeight = titleHeight + scrollHeight + buttonHeight + 30
            }
        } else {
            print(titleHeight + 30 + scrollHeight + buttonHeight)
            if viewHeight + 30 + scrollHeight + buttonHeight > ActionSheetMaxHeight {
                contentScrollView.contentSize = CGSize(width: ActionSheetWidth, height: scrollHeight)
                contentScrollView.frame = CGRect(x: 0, y: viewHeight, width: ActionSheetWidth, height: ActionSheetMaxHeight - viewHeight - buttonHeight - 10)
                viewHeight = ActionSheetMaxHeight
            } else {
                contentScrollView.contentSize = CGSize(width: ActionSheetWidth, height: scrollHeight)
                contentScrollView.frame = CGRect(x: 0, y: viewHeight, width: ActionSheetWidth, height: scrollHeight)
                viewHeight = titleHeight + scrollHeight + buttonHeight + 30
            }
        }
        
        alertView.addSubview(contentScrollView)
        
        if buttons.count > 0 {
            if isAlert() {
                for i in 0 ..< buttons.count {
                    let btn = buttons[i]
                    let button = btn.createButton(i)
                    button.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
                    /// 添加线
                    if buttons.count <= 2 {
                        button.frame = CGRect(x: CGFloat(i) * AlertWidth/CGFloat(buttons.count), y: contentScrollView.frame.maxY + 10, width: AlertWidth/CGFloat(buttons.count), height: 50)
                    } else {
                        button.frame = CGRect(x: 0, y: contentScrollView.frame.maxY + 10 + CGFloat(i) * 50, width: AlertWidth, height: 50)
                    }
                    /// 添加顶部线
                    let line = UIView(frame: CGRect(x: 0, y: 0, width: button.frame.width, height: 0.4))
                    line.backgroundColor = UIColor.lightGray
                    button.addSubview(line)
                    alertView.addSubview(button)
                }
                
            } else {
                var cancelButton: AlertButton = AlertButton(image: nil, text: "取消", theme: AlertButtonTheme(textColor: UIColor.blue, textFont: UIFont.systemFont(ofSize: 15)), style: .cancel)
                var finalButtons = [AlertButton]()
                for btn in buttons {
                    if btn.style != .cancel {
                        finalButtons.append(btn)
                    } else {
                        cancelButton = btn
                    }
                }
                
                for i in 0 ..< finalButtons.count {
                    let btn = finalButtons[i]
                    let button = btn.createButton(i)
                    button.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
                    button.frame = CGRect(x: 0, y: contentScrollView.frame.maxY + 10 + CGFloat(i) * 60, width: ActionSheetWidth, height: 60)
                    /// 添加顶部线
                    let line = UIView(frame: CGRect(x: 0, y: 0, width: button.frame.width, height: 0.4))
                    line.backgroundColor = UIColor.lightGray
                    button.addSubview(line)
                    alertView.addSubview(button)
                }
                
                if containsCancel {
                    let bottomView = UIView(frame: CGRect(x: 20, y: UIScreen.main.bounds.size.height - 70, width: ActionSheetWidth, height: 60))
                    bottomView.backgroundColor = UIColor.white
                    bottomView.layer.cornerRadius = 10
                    let button = cancelButton.createButton(finalButtons.count)
                    button.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
                    button.frame = CGRect(x: 0, y: 0, width: bottomView.frame.width, height: bottomView.frame.height)
                    bottomView.addSubview(button)
                    view.addSubview(bottomView)
                } else {
                    
                }
                
            }
        }
        
        
        
        
        /// 判断整体高度
        
        /// 初始化视图
        alertView.backgroundColor = UIColor.white
        alertView.layer.cornerRadius = 10
        alertView.frame = CGRect(x: 0, y: 0, width: isAlert() ? AlertWidth : ActionSheetWidth, height: viewHeight)
        if isAlert() {
            alertView.center = self.view.center
        } else {
            alertView.center = CGPoint(x: self.view.center.x, y: UIScreen.main.bounds.size.height-80-viewHeight/2)
        }
        self.view.addSubview(alertView)
        
    }
    
    /// 添加按钮
    ///
    /// - Parameters:
    ///   - text: 标题
    ///   - image: 图片
    ///   - theme: 主题
    ///   - handle: 操作
    ///   - style: 按钮样式
    @discardableResult
    public func add(button text: String? = nil, image: UIImage? = nil, theme: AlertButtonTheme? = nil, style: AlertButtonStyle = .default) -> AlertDialog {
        let button = AlertButton(image: image, text: text, theme: theme, style: style)
        buttons.append(button)
        return self
    }
    
    @discardableResult
    public func add(input placeholder: String? = nil, theme: AlertInputTheme? = nil) -> AlertDialog {
        let input = AlertInput(placeholder, theme: theme)
        inputs.append(input)
        return self
    }
    
    @discardableResult
    public func onClickListener(click: ((_ alertDialog: AlertDialog, _ index: Int) -> Void)?) -> AlertDialog {
        self.clickListner = click
        return self
    }
    
    @discardableResult
    public func show() -> AlertDialog {
        builderSubviews()
        return self
    }
    

    public func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @objc private func buttonClick(_ button: UIButton) {
        self.clickListner?(self, button.tag)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

extension AlertDialog: UITextFieldDelegate {
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
         self.currentTextField = textField
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        let userInfo = notification.userInfo
        let rect = (userInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue) as! CGRect
        let changeY = rect.size.height
        let duration = userInfo?[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        let option = UIViewKeyframeAnimationOptions(rawValue: UInt((userInfo?[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).intValue << 16))
        
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: option, animations: {
            if let currentTF = self.currentTextField {
                let alertFrame = self.view.convert(currentTF.frame, to: self.alertView)
                print(alertFrame.maxY + (UIScreen.main.bounds.size.height - self.alertView.frame.size.height)/2)
                print(rect)
                print(alertFrame.maxY + (UIScreen.main.bounds.size.height - self.alertView.frame.size.height)/2 > rect.origin.y-20)
                if alertFrame.maxY + (UIScreen.main.bounds.size.height - self.alertView.frame.size.height)/2 > rect.origin.y-20 && self.keyboardShow {
                    self.alertView.frame.origin.y = (rect.origin.y - ( alertFrame.maxY + (UIScreen.main.bounds.size.height - self.alertView.frame.size.height)/2) + 60)
                }
            }
        }, completion: { success in
            self.keyboardShow = true
        })
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        let userInfo = notification.userInfo
        let rect = (userInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue) as! CGRect
        let changeY = rect.size.height
        let duration = userInfo?[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        let option = UIViewKeyframeAnimationOptions(rawValue: UInt((userInfo?[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).intValue << 16))
        
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: option, animations: {
            self.alertView.center = self.view.center
        }, completion: nil)
    }
    
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

// MARK: - 添加按钮
extension AlertDialog {
    
 
    @discardableResult
    public func add(cancel text: String? = nil, image: UIImage? = nil, theme: AlertButtonTheme? = nil) -> AlertDialog {
        add(button: text, image: image, theme: theme, style: .cancel)
        return self
    }
    
    @discardableResult
    public func add(default text: String? = nil, image: UIImage? = nil, theme: AlertButtonTheme? = nil) -> AlertDialog {
        add(button: text, image: image, theme: theme, style: .default)
        return self
    }
    
    @discardableResult
    public func add(destructive text: String? = nil, image: UIImage? = nil, theme: AlertButtonTheme? = nil) -> AlertDialog {
        add(button: text, image: image, theme: theme, style: .destructive)
        return self
    }
}


extension String {
    
    public func size(_ font: UIFont, _ size: CGSize = .zero) -> CGSize {
        return self.boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil).size
    }
}
