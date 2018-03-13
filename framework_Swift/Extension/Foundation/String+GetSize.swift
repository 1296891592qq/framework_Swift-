//
//  String+GetSize.swift
//  smart_Swift
//
//  Created by mac on 2018/3/8.
//  Copyright © 2018年 mac. All rights reserved.
//

import UIKit

extension String {
    
    // MARK: - 获取字符串大小
    func getSize(fontSize: CGFloat) -> CGSize {
        
        let str = self as NSString
        
        let size = CGSize(width: kScreenW, height: CGFloat(MAXFLOAT))
        return str.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: fontSize)], context: nil).size
    }
    
    // MARK:- 获取字符串大小
    func getSize(font: UIFont) -> CGSize {
        let str = self as NSString
        
        let size = CGSize(width: kScreenW, height: CGFloat(MAXFLOAT))
        return str.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil).size
    }
    
}
