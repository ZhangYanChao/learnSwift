//
//  bankModel.swift
//  learnSwift
//
//  Created by zyc on 2019/11/20.
//  Copyright © 2019 张言超. All rights reserved.
//

import UIKit

class bankModel: NSObject {
    public var bankName:String = ""
    public var bankMoney:String = ""
    public var bankImg:String = ""
    
    public func getBankData() -> NSArray{
        let plistPath:String = Bundle.main.path(forResource: "banks", ofType:"plist")!
        let dataArr:NSArray = NSArray(contentsOfFile:plistPath)!
        let bankArr:NSMutableArray = []
        for index in 0..<dataArr.count {
            let dict:NSDictionary = dataArr[index] as! NSDictionary
            let model = bankModel()
            model.bankImg = dict.object(forKey: "img") as! String
            model.bankName = dict.object(forKey: "name") as! String
            model.bankMoney = dict.object(forKey: "money") as! String
            bankArr.add(model)
        }
        return bankArr.copy() as! NSArray
    }
}
