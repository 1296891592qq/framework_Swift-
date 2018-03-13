//
//  Common.swift
//  News
//
//  Created by mac on 2018/3/7.
//  Copyright © 2018年 mac. All rights reserved.
//

import UIKit

// bounds
let kScreenBounds = UIScreen.main.bounds

// 屏幕宽度
let kScreenH = UIScreen.main.bounds.height
// 屏幕高度
let kScreenW = UIScreen.main.bounds.width
//适配iPhoneX
let is_iPhoneX = (kScreenW == 375.0 && kScreenH == 812.0 ? true : false)
let kNavibarH: CGFloat = is_iPhoneX ? 88.0 : 64.0
let kTabbarH: CGFloat = is_iPhoneX ? 49.0+34.0 : 49.0
let kStatusbarH: CGFloat = is_iPhoneX ? 44.0 : 20.0
let iPhoneXBottomH: CGFloat = 34.0
let iPhoneXTopH: CGFloat = 24.0

// MARK:- 常量
struct MetricGlobal {
    static let padding: CGFloat = 10.0
    static let margin: CGFloat = 10.0
}

// MARK:- 常用按钮颜色
// 颜色参考 http://www.sioe.cn/yingyong/yanse-rgb-16/

// 纯白色
let kThemeWhiteColor = UIColor.withHex(hexInt:0xFFFFFF)
// 纯红色
let kThemeRedColor = UIColor.withHex(hexInt: 0xFF0000)
// 主题色
let kThemeMainColor = UIColor.withHex(hexInt:0x00AE0E9)
// 主标题文字颜色
let kThemeMainTextColor = UIColor.withHex(hexInt:0x333333)
// 次标题文字颜色
let kThemeSubTextColor = UIColor.withHex(hexInt:0x666666)
// 辅助文字颜色
let kThemeAssistTextColor = UIColor.withHex(hexInt:0x999999)
// 分割线颜色
let kThemeLineColor = UIColor.withHex(hexInt:0xE6E6E6)
// 页面颜色
let kThemePageColor = UIColor.withHex(hexInt:0xF9F9F9)


let kThemeMistyRoseColor = UIColor.withHex(hexInt:0xFFE4E1)  // 薄雾玫瑰
let kThemeGainsboroColor = UIColor.withHex(hexInt:0xF3F4F5)  // 亮灰色
let kThemeOrangeRedColor = UIColor.withHex(hexInt:0xFF4500)  // 橙红色
let kThemeLimeGreenColor = UIColor.withHex(hexInt:0x32CD32)  // 酸橙绿



