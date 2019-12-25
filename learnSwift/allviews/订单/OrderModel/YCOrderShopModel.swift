//
//  YCOrderShopModel.swift
//  learnSwift
//
//  Created by zyc on 2019/12/23.
//  Copyright © 2019 张言超. All rights reserved.
//

import UIKit

class YCOrderShopModel: NSObject {
    
    /** 店铺名字 */
    var shopName:String?
    /** 店铺商品 */
    var goodsArr:[YCOrderGoodsModel]?
    /** 是否是全部选中状态 */
    var shopIsAllSelected:Bool = false
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "commoditys" {
            var goodsModelArr = [YCOrderGoodsModel]()
            let tempArr:NSArray = value as! NSArray
            for index in 0..<tempArr.count {
                let dict:NSDictionary = tempArr[index] as! NSDictionary
                let model = YCOrderGoodsModel.init()
                model.goodsName = dict["commodityName"] as? String
                model.goodsDescription = dict["commodityDescription"] as? String
                model.goodsPrice = dict["commodityPrice"] as? String
                model.goodsIsSelect = false
                model.goodsCount = 1;
                goodsModelArr.append(model)
            }
            self.goodsArr = goodsModelArr
        }else if key == "shopName"{
            self.shopName = value as? String
        }
    }
    
    override func value(forUndefinedKey key: String) -> Any? {
        return nil
    }

}
