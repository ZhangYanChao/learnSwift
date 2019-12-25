//
//  OrderController.swift
//  learnSwift
//
//  Created by zyc on 2019/11/20.
//  Copyright © 2019 张言超. All rights reserved.
//

import UIKit


class OrderController: BaseViewController {

    var myTableView = UITableView.init()
    /** 数据源 */
    var dataArr:NSMutableArray = NSMutableArray.init()
    /** 选择的数据 */
    var selectedArr:NSMutableArray = NSMutableArray.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "购物车"
        self.customUI()
        self.initData()
    }
    var footView:YCOrderFootView?
    func customUI(){
        view.backgroundColor = UIColor.white
        self.myTableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight-80-70), style: .grouped)
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        self.myTableView.separatorStyle = .none
        self.myTableView.register(YCOrderShopCartCell.self, forCellReuseIdentifier: "YCOrderShopCartCell")
        self.view.addSubview(self.myTableView)
        
        self.footView = YCOrderFootView.init(frame: CGRect(x: 0, y: kScreenHeight-70-110, width: kScreenWidth, height: 70))
        self.footView?.footDelegate = self
        self.view.addSubview(self.footView!)
    }
    
    func initData(){
        let plistPath:String = Bundle.main.path(forResource: "xqq_shop", ofType:"plist")!
        let dataArr:NSArray = NSArray(contentsOfFile:plistPath)!
        for index in 0..<dataArr.count {
            let dict:NSDictionary = dataArr[index] as! NSDictionary
            let shopModel = YCOrderShopModel.init()
            shopModel.setValue(dict["commoditys"], forKey: "commoditys")
            shopModel.setValue(dict["shopName"], forKey: "shopName")
            self.dataArr.add(shopModel)
        }
        self.myTableView.reloadData()
        
        //初始化选择的数组
        for _ in 0..<self.dataArr.count {
            let tempArr = NSMutableArray.init()
            self.selectedArr.add(tempArr)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.backgroundColor = UIColor.white
    }
}

extension OrderController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataArr.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let shopModel:YCOrderShopModel = self.dataArr[section] as! YCOrderShopModel
        return shopModel.goodsArr!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:YCOrderShopCartCell = tableView.dequeueReusableCell(withIdentifier: "YCOrderShopCartCell", for: indexPath) as! YCOrderShopCartCell
        cell.backgroundColor = UIColor.colorWithCustom(r: 242, g: 242, b: 242)
        let shopModel:YCOrderShopModel = self.dataArr[indexPath.section] as! YCOrderShopModel
        
        cell.xgoodModel = shopModel.goodsArr?[indexPath.row]
        cell.YCcellDelegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let model:YCOrderShopModel = self.dataArr[section] as! YCOrderShopModel
        return model.goodsArr!.count > 0 ? 50 : 0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let model:YCOrderShopModel = self.dataArr[section] as! YCOrderShopModel
        let headerview = YCOrderHeaderView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 50))
        headerview.shopModel = model
        headerview.index = section
        headerview.YCHeaderDelegate = self
        return model.goodsArr!.count > 0 ? headerview : nil
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = UIAlertController.init(title: "您确定要删除这个商品吗?", message: "", preferredStyle: .alert)
            let confirmaction = UIAlertAction.init(title: "确定", style: .default) { (UIAlertAction) in
                let shopmodel:YCOrderShopModel = self.dataArr[indexPath.section] as! YCOrderShopModel
                let arr:[YCOrderGoodsModel] = shopmodel.goodsArr!
                if arr.count > 0{
                    let goodmodel:YCOrderGoodsModel = arr[indexPath.row]
                    //删除选中的数组
                    if goodmodel.goodsIsSelect {
                        let xxtempArr:NSMutableArray = self.selectedArr[indexPath.section] as! NSMutableArray
                        if xxtempArr.contains(goodmodel) {
                            xxtempArr.remove(goodmodel)
                        }
                    }
                    //删除数据源
                    var tempArr:[YCOrderGoodsModel] = NSMutableArray.init(array: arr) as! [YCOrderGoodsModel]
                    let xxIndex:Int = tempArr.firstIndex(of: goodmodel)!
                    tempArr.remove(at: xxIndex)
                    shopmodel.goodsArr = tempArr
                }
                //更新数据
                self.updateData()
            }
            let cancleAction = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)
            alert.addAction(confirmaction)
            alert.addAction(cancleAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
}
//MARK: -- YCOrderShopCartCellDelegate
extension OrderController:YCOrderShopCartCellDelegate{
    func shopCellDidPress(goodModel: YCOrderGoodsModel, cell: YCOrderShopCartCell) {
        print("点击cell，跳转商品详情")
    }
    
    func addBtnDidPress(goodModel: YCOrderGoodsModel, cell: YCOrderShopCartCell) {
        self.disposeShopData(goodModel: goodModel, cell: cell, isAdd: true)
    }
    
    func minusBtnDidPress(goodModel: YCOrderGoodsModel, cell: YCOrderShopCartCell) {
        self.disposeShopData(goodModel: goodModel, cell: cell, isAdd: false)
    }
    
    func leftSelBtnDidPress(goodModel: YCOrderGoodsModel, cell: YCOrderShopCartCell, isSel: Bool) {
        var shopModelIndex:Int?
        var goodModelIndex:Int?
        for shop_Index in 0..<self.dataArr.count {
            let shopmodel:YCOrderShopModel = self.dataArr[shop_Index] as! YCOrderShopModel
            let arr:[YCOrderGoodsModel] = shopmodel.goodsArr!
            if arr.count > 0 {
                for good_index in 0..<arr.count {
                    let good_model:YCOrderGoodsModel = arr[good_index]
                    if good_model == goodModel {
                        good_model.goodsIsSelect = isSel
                        shopModelIndex = self.dataArr.index(of: shopmodel)
                        goodModelIndex = arr.firstIndex(of: good_model)
                        
                        let tempArr:NSMutableArray = self.selectedArr[shopModelIndex!] as! NSMutableArray
                        if isSel {
                            //装入数组
                            if !tempArr.contains(goodModel) {
                                tempArr.add(goodModel)
                                if tempArr.count == shopmodel.goodsArr?.count {
                                    shopmodel.shopIsAllSelected = true
                                }else{
                                    shopmodel.shopIsAllSelected = false
                                }
                            }
                            
                        }else{
                            if tempArr.contains(goodModel) {
                                tempArr.remove(goodModel)
                                shopmodel.shopIsAllSelected = false
                            }
                        }
                    }
                }
            }
        }
        self.updateData()
    }
    
    func disposeShopData(goodModel:YCOrderGoodsModel, cell:YCOrderShopCartCell, isAdd:Bool){
        var shopModelIndex:Int?
        var goodModelIndex:Int?
        for shop_Index in 0..<self.dataArr.count {
            let shopmodel:YCOrderShopModel = self.dataArr[shop_Index] as! YCOrderShopModel
            let arr:[YCOrderGoodsModel] = shopmodel.goodsArr!
            if arr.count > 0 {
                for good_index in 0..<arr.count {
                    let good_model:YCOrderGoodsModel = arr[good_index]
                    if good_model == goodModel {
                        shopModelIndex = self.dataArr.index(of: shopmodel)
                        goodModelIndex = arr.firstIndex(of: good_model)
                        
                        let tempArr:NSMutableArray = self.selectedArr[shopModelIndex!] as! NSMutableArray
                        //是选中的那个
                        var count:Int = good_model.goodsCount!
                        if isAdd {
                            if count == 99 {
                                return
                            }
                            count += 1
                        }else{
                            if count == 1{
                                return
                            }
                            count -= 1
                        }
                        
                        //更新选中数组中的个数
                        if !tempArr.contains(good_model){
                            //如果没有加入的，加入选中数组
                            goodModel.goodsIsSelect = true
                            tempArr.add(goodModel)
                            if tempArr.count == shopmodel.goodsArr?.count {
                                shopmodel.shopIsAllSelected = true
                            }
                        }
                        let xxindex:Int = tempArr.index(of: good_model)
                        let good:YCOrderGoodsModel = tempArr[xxindex] as! YCOrderGoodsModel
                        good.goodsCount = count
                    }
                }
            }
        }
        self.updateData()
    }
    
}
//MARK: -- headerViewDelegate
extension OrderController:YC_headerViewDelegate{
    func headerViewDidPress(index: NSInteger, shopmodel: YCOrderShopModel, isSel: Bool) {
        let selmodel:YCOrderShopModel = self.dataArr[index] as! YCOrderShopModel
        selmodel.shopIsAllSelected = isSel
        let arr:[YCOrderGoodsModel] = selmodel.goodsArr!
        for xindex in 0..<arr.count {
            let goodmodel:YCOrderGoodsModel = arr[xindex]
            goodmodel.goodsIsSelect = isSel
        }
        //存入选择数组
        let saveArr:NSMutableArray = self.selectedArr[index] as! NSMutableArray
        if isSel {
            saveArr.setArray(arr)
        }else{
            saveArr.removeAllObjects()
        }
        self.updateData()
    }
}
//MARK: -- FootViewDelegate
extension OrderController:YC_FootViewDelegate{
    func selectedAllBtnDidPress(button: UIButton, isSel: Bool) {
        for xindex in 0..<self.dataArr.count {
            let shopmodel:YCOrderShopModel = self.dataArr[xindex] as! YCOrderShopModel
            let goodarr:NSArray = shopmodel.goodsArr! as NSArray
            if goodarr.count > 0 {
                for jindex in 0..<goodarr.count {
                    let goodmodel:YCOrderGoodsModel = goodarr[jindex] as! YCOrderGoodsModel
                    goodmodel.goodsIsSelect = isSel
                }
            }
        }
        //添加到选择数组
        if isSel {
            for kindex in 0..<self.dataArr.count {
                let tempArr:NSMutableArray = self.selectedArr[kindex] as! NSMutableArray
                let model:YCOrderShopModel = self.dataArr[kindex] as! YCOrderShopModel
                let arr:NSArray = model.goodsArr! as NSArray
                tempArr.setArray(arr as! [Any])
            }
        }else {
            for kindex in 0..<self.selectedArr.count {
                let tempArr:NSMutableArray = self.selectedArr[kindex] as! NSMutableArray
                tempArr.removeAllObjects()
            }
        }
        self.updateData()
    }
    //更新数据 --价格总计--tableviewUI变化
    func updateData() -> Void {
        self.updatePrice()
        self.myTableView.reloadData()
    }
    //更新价格
    func updatePrice() -> Void {
        //更新底部的价格
        self.footView?.updateArr(selectedArr: self.selectedArr, dataArr: self.dataArr)
        //判断每个店铺是否全选状态
        for lindex in 0..<self.dataArr.count {
            let model:YCOrderShopModel = self.dataArr[lindex] as! YCOrderShopModel
            let selectarr:NSMutableArray = self.selectedArr[lindex] as! NSMutableArray
            model.shopIsAllSelected = model.goodsArr?.count == selectarr.count ? true : false
        }
    }
}
