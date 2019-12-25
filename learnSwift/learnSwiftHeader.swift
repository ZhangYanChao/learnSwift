//
//  learnSwiftHeader.swift
//  learnSwift
//
//  Created by zyc on 2019/11/20.
//  Copyright © 2019 张言超. All rights reserved.
//

import UIKit

//屏幕-宽-高-bounds
public let kScreenWidth = UIScreen.main.bounds.size.width
public let kScreenHeight = UIScreen.main.bounds.size.height
public let ScreenBounds: CGRect = UIScreen.main.bounds


//navigation
public let NavigationH:CGFloat = 64

//全局整体背景色
public let GlobalBackgroundColor = UIColor.colorWithCustom(r: 239, g: 239, b: 239)

//cell分割线颜色
public let CellDivisionColor = UIColor.lightGray

//Notification-通知
public let GuideViewControllerDidFinish = "GuideViewControllerDidFinish"

/** 判断是否是iPhoneX */
let IsiPhonX = UIScreen.instancesRespond(to: #selector(getter: UIScreen.currentMode)) ? __CGSizeEqualToSize(CGSize(width: 1125, height: 2436), UIScreen.main.currentMode!.size) : false
/** 判断是否是iPhoneXR*/
let IsiPhonXR = UIScreen.instancesRespond(to: #selector(getter: UIScreen.currentMode)) ? __CGSizeEqualToSize(CGSize(width: 828, height: 1792), UIScreen.main.currentMode!.size) : false
/** 判断是否是iPhoneXS*/
let IsiPhonXS = UIScreen.instancesRespond(to: #selector(getter: UIScreen.currentMode)) ? __CGSizeEqualToSize(CGSize(width: 1125, height: 2436), UIScreen.main.currentMode!.size) : false
/** 判断是否是iPhoneXS_MAX*/
let IsiPhonXS_MAX = UIScreen.instancesRespond(to: #selector(getter: UIScreen.currentMode)) ? __CGSizeEqualToSize(CGSize(width: 1242, height: 2688), UIScreen.main.currentMode!.size) : false
/** 是否全面屏*/
let IsFullScreen = (IsiPhonX || IsiPhonXR || IsiPhonXS || IsiPhonXS_MAX) ? true : false

/** 计算多行文字高度 */
func GETSTRHEIGHT(fontSize: CGFloat, width: CGFloat, words: String) -> CGFloat {
    let font = UIFont.systemFont(ofSize: fontSize)
    let rect = NSString(string: words).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
    return rect.height //ceil(rect.height)
}
/** 字体(参数：字号，字体名) */
func FontWithName(_ name:String, _ font:CGFloat) -> UIFont {
    return UIFont.init(name: name, size: font)!
}
/** 时间转字符串 */
func dateToStr(dateFormat:String,date:Date) -> String{
    let formatter = DateFormatter()
    formatter.dateFormat = dateFormat
    let dateStr = formatter.string(from: date)
    return dateStr
}

/** 16进制颜色 */
func RGB16(value: UInt) -> UIColor {
    return UIColor(
        red: CGFloat((value & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((value & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(value & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

/** rgb颜色 */
func RGB_COLOR(r: Float, g: Float, b: Float) -> UIColor{
    return UIColor(red: CGFloat(r / 255.0), green: CGFloat(g / 255.0), blue: CGFloat(b / 255.0), alpha: 1)
}
