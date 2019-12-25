//
//  UIView+YCAdd.swift
//  learnSwift
//
//  Created by zyc on 2019/12/23.
//  Copyright © 2019 张言超. All rights reserved.
//

import UIKit

extension UIView{
    
    func yc_left() -> CGFloat {
        return self.frame.origin.x
    }
    func setYc_left(ycleft:CGFloat) -> Void{
        var frame:CGRect = self.frame
        frame.origin.x = ycleft
        self.frame = frame
    }
    
    func yc_top() -> CGFloat {
        return self.frame.origin.y
    }
    func setYc_top(yctop:CGFloat) -> Void{
        var frame:CGRect = self.frame
        frame.origin.y = yctop
        self.frame = frame
    }
    
    func yc_right() -> CGFloat {
        return self.frame.origin.x + self.frame.size.width
    }
    func setYc_right(ycright:CGFloat) -> Void{
        var frame:CGRect = self.frame
        frame.origin.x = ycright - frame.size.width
        self.frame = frame
    }

    func yc_bottom() -> CGFloat {
        return self.frame.origin.y + self.frame.size.height
    }
    func setYc_bottom(ycbottom:CGFloat) -> Void{
        var frame:CGRect = self.frame
        frame.origin.y = ycbottom - frame.size.height
        self.frame = frame
    }
    
    func yc_width() -> CGFloat {
        return self.frame.size.width
    }
    func setYc_width(ycwidth:CGFloat) -> Void {
        var frame:CGRect = self.frame
        frame.size.width = ycwidth
        self.frame = frame
    }
    
    func yc_height() -> CGFloat {
        return self.frame.size.height
    }
    func setYc_height(ycheight:CGFloat) -> Void {
        var frame:CGRect = self.frame
        frame.size.height = ycheight
        self.frame = frame
    }
    
    func yc_centerX() -> CGFloat {
        return self.center.x
    }
    func setYc_centerX(yccenterX:CGFloat) -> Void {
        self.center = CGPoint.init(x: yccenterX, y: self.center.y)
    }
    
    func yc_centerY() -> CGFloat {
        return self.center.y
    }
    func setYc_centerY(yccenterY:CGFloat) -> Void {
        self.center = CGPoint.init(x: self.center.x, y: yccenterY)
    }
    
    func yc_origin() -> CGPoint {
        return self.frame.origin
    }
    func setYc_origin(ycorigin:CGPoint) -> Void {
        var frame:CGRect = self.frame
        frame.origin = ycorigin
        self.frame = frame
    }
    
    func yc_originX() -> CGFloat {
        return self.frame.origin.x
    }
    func setYc_originX(ycoriginX:CGFloat) -> Void {
        var frame:CGRect = self.frame
        frame.origin.x = ycoriginX
        self.frame = frame
    }
    func yc_originY() -> CGFloat {
        return self.frame.origin.y
    }
    func setYc_originY(ycoriginY:CGFloat) -> Void {
        var frame:CGRect = self.frame
        frame.origin.y = ycoriginY
        self.frame = frame
    }
    
}
