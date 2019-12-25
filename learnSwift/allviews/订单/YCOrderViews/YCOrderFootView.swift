//
//  YCOrderFootView.swift
//  learnSwift
//
//  Created by zyc on 2019/12/23.
//  Copyright © 2019 张言超. All rights reserved.
//

import UIKit

@objc protocol YC_FootViewDelegate {
    func selectedAllBtnDidPress(button:UIButton,isSel:Bool)
}

class YCOrderFootView: UIView {
    /** 全选按钮 */
    var selectAllBtn:UIButton?
    /** 价格label */
    var sumLabel:UILabel?
    /** 结算按钮 */
    var accountBtn:UIButton?
    /** 全选按钮点击 */
    var isSelectAll:Bool = false
    /** 选中商品的个数 */
    var selectCount:NSInteger?
    //代理
    weak var footDelegate:YC_FootViewDelegate?
//    //判断是否全选
//    var isAllSel:Bool?
    /** 数据 */
    private var _xshopModel:YCOrderShopModel?
    var shopModel:YCOrderShopModel?{
        get{
            return _xshopModel
        }
        set{
            _xshopModel = newValue
            if _xshopModel!.shopIsAllSelected {
                
            }
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.customFootViewUI()
    }
    let selectBtnWH:CGFloat = 30
    let boardWidth:CGFloat = 10
    let viewHeight:CGFloat = 70
    func customFootViewUI(){
        
        self.backgroundColor = UIColor.colorWithCustom(r: 222, g: 222, b: 222)
        //左侧按钮
        self.selectAllBtn = UIButton.init(frame: CGRect(x: boardWidth, y: (viewHeight - selectBtnWH)*0.5, width: selectBtnWH, height: selectBtnWH))
        self.selectAllBtn?.setImage(UIImage.init(named: "GameCenterNewWhite"), for: .normal)
        self.selectAllBtn?.setTitle("全选", for: .normal)
        self.selectAllBtn?.setTitleColor(UIColor.black, for: .normal)
        self.selectAllBtn?.addTarget(self, action: #selector(leftSelectAllBtnDidPress(button:)), for: .touchUpInside)
        self.addSubview(self.selectAllBtn!)
        
        self.accountBtn = UIButton.init(frame: CGRect(x: kScreenWidth - (kScreenWidth/3.0 - 2*boardWidth), y: 0, width: kScreenWidth/3.0 - 2*boardWidth, height: viewHeight))
        self.accountBtn?.backgroundColor = UIColor.colorWithCustom(r: 226, g: 84, b: 91)
        self.accountBtn?.setTitle("去结算", for: .normal)
        self.accountBtn?.setTitleColor(.white, for: .normal)
        self.accountBtn?.setTitleColor(.lightGray, for: .highlighted)
        self.addSubview(self.accountBtn!)
        
        //价格label
        self.sumLabel = UILabel.init(frame: CGRect(x: (self.selectAllBtn?.yc_right())! + boardWidth, y: (viewHeight - selectBtnWH)*0.5, width: kScreenWidth - 3*boardWidth - self.selectAllBtn!.yc_width() - (self.accountBtn?.yc_width())!, height: selectBtnWH))
        let att:NSAttributedString = NSAttributedString(string: "合计：", attributes: [NSAttributedString.Key.foregroundColor  : UIColor.black, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20)])
        let att1:NSAttributedString = NSAttributedString(string: "¥0.00", attributes: [NSAttributedString.Key.foregroundColor  : UIColor.red, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20)])
        //定义富文本即有格式的字符串
        let attributedStrM : NSMutableAttributedString = NSMutableAttributedString()
        attributedStrM.append(att)
        attributedStrM.append(att1)
        self.addSubview(self.sumLabel!)
        self.sumLabel?.attributedText = attributedStrM
    }
    
    /** 全选按钮点击了 */
    @objc func leftSelectAllBtnDidPress(button:UIButton){
        if self.isSelectAll {
            self.selectAllBtn?.setImage(UIImage.init(named: "GameCenterNewWhite"), for: .normal)
            self.isSelectAll = false
        }else{
            self.selectAllBtn?.setImage(UIImage.init(named: "GameCenterNewAppTag"), for: .normal)
            self.isSelectAll = true
        }
        if (self.footDelegate != nil) {
            self.footDelegate?.selectedAllBtnDidPress(button: button, isSel: self.isSelectAll)
        }
    }
    
    //更新
    func updateArr(selectedArr:NSArray, dataArr:NSArray){
        //计算价格
        var sumPrice:Float = 0
        //选中商品总数
        var sumCount:NSInteger = 0
        //总的商品数量
        var allCount:NSInteger = 0
        
        for index in 0..<dataArr.count {
            let shopmodel:YCOrderShopModel = dataArr[index] as! YCOrderShopModel
            allCount += shopmodel.goodsArr!.count
        }
        
        for xindex in 0..<selectedArr.count {
            let selArr:NSMutableArray = selectedArr[xindex] as! NSMutableArray
            let count:NSInteger = selArr.count
            sumCount += count
            if count > 0 {
                for jindex in 0..<count {
                    let goodmodel:YCOrderGoodsModel = selArr[jindex] as! YCOrderGoodsModel
                    let price:String = goodmodel.goodsPrice!
                    let priceNum:Float = Float(price)!
                    let ccount:Int = goodmodel.goodsCount!
                    sumPrice += priceNum*Float(ccount)
                }
            }
        }
        let att:NSAttributedString = NSAttributedString(string: "合计：", attributes: [NSAttributedString.Key.foregroundColor  : UIColor.black, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20)])
        let ss:String = String.init(format: "￥%.2f", sumPrice)
        let att1:NSAttributedString = NSAttributedString(string: ss, attributes: [NSAttributedString.Key.foregroundColor  : UIColor.red, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20)])
        //定义富文本即有格式的字符串
        let attributedStrM : NSMutableAttributedString = NSMutableAttributedString()
        attributedStrM.append(att)
        attributedStrM.append(att1)
        self.sumLabel?.attributedText = attributedStrM
        
        self.selectCount = sumCount
        
        let accountBtnTile = sumCount > 0 ? String.init(format: "去结算(%ld)", sumCount) : "去结算"
        self.accountBtn?.setTitle(accountBtnTile, for: .normal)
        
        self.isSelectAll = sumCount == allCount ? true : false;
        
        if !self.isSelectAll {
            self.selectAllBtn?.setImage(UIImage.init(named: "GameCenterNewWhite"), for: .normal)
            self.isSelectAll = false
        }else{
            self.selectAllBtn?.setImage(UIImage.init(named: "GameCenterNewAppTag"), for: .normal)
            self.isSelectAll = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
