//
//  JianShuModel.swift
//  learnSwift
//
//  Created by zyc on 2019/12/16.
//  Copyright © 2019 张言超. All rights reserved.
//

import UIKit

class JianShuModel: NSObject {
    ///封面
    var wrap:String?
    ///文章URL
    var articleUrl:String?
    ///标题
    var title:String?
    ///文摘
    var abstract:String?
    ///阅读人数
    var read:String?
    ///评论个数
    var comments:String?
    ///喜欢
    var like:String?
    ///发布时间
    var time:String?
    

    ///图片宽度
    var imgW:Float?
    ///图片高度
    var imgH:Float?
    ///item高度
    var itemHeight:String?
    
    ///title高度
    var titleH:CGFloat?
    ///摘要高度
    var abstractH:CGFloat?

}
