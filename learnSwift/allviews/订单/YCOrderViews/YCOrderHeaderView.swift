//
//  YCOrderHeaderView.swift
//  learnSwift
//
//  Created by zyc on 2019/12/23.
//  Copyright © 2019 张言超. All rights reserved.
//

import UIKit


@objc protocol YC_headerViewDelegate {
    func headerViewDidPress(index:NSInteger, shopmodel:YCOrderShopModel,isSel:Bool)
}

class YCOrderHeaderView: UIView {

    /** 代理 */
    weak var YCHeaderDelegate:YC_headerViewDelegate?
    /** 数据 */
    private var _xshopModel:YCOrderShopModel?
    var shopModel:YCOrderShopModel?{
        get{
            return _xshopModel
        }
        set{
            _xshopModel = newValue
            if (_xshopModel?.shopIsAllSelected)! {
                self.leftSelBtn.setImage(UIImage.init(named: "GameCenterNewAppTag"), for: .normal)
                self.isLeftBtnSel = true
            }else{
                self.leftSelBtn.setImage(UIImage.init(named: "GameCenterNewWhite"), for: .normal)
                self.isLeftBtnSel = false
            }
            self.shopNameLabel.text = _xshopModel?.shopName
        }
    }
    /** 序号 */
    var index:NSInteger?
    
    let boardWidth:CGFloat = 10
    let headerHeight:CGFloat = 50
    let leftSelBtnWH:CGFloat = 30
    
    var leftSelBtn = UIButton.init()
    var shopNameLabel = UILabel.init()
    var isLeftBtnSel:Bool = false
    override init(frame: CGRect) {
        super.init(frame: frame)
        let leftBtn = UIButton.init(frame: CGRect(x: boardWidth, y: (headerHeight - leftSelBtnWH)*0.5, width: leftSelBtnWH, height: leftSelBtnWH))
        leftBtn.addTarget(self, action: #selector(leftSelBtnDidPress(btn:)), for: .touchUpInside)
        self.leftSelBtn = leftBtn
        self.addSubview(leftBtn)
        
        self.shopNameLabel = UILabel.init(frame: CGRect(x: (boardWidth+boardWidth+leftSelBtnWH), y: leftBtn.yc_top(), width: (kScreenWidth - 3*boardWidth - leftBtn.yc_width()), height: leftSelBtnWH))
        self.shopNameLabel.text = "今年本月旗舰店"
        self.shopNameLabel.font = UIFont.systemFont(ofSize: 19)
        self.shopNameLabel.textColor = .black
        self.addSubview(self.shopNameLabel)
    }
    
    @objc func leftSelBtnDidPress(btn:UIButton){
        if self.isLeftBtnSel {
            self.leftSelBtn.setImage(UIImage.init(named: "GameCenterNewWhite"), for: .normal)
            self.isLeftBtnSel = false
        }else{
            self.leftSelBtn.setImage(UIImage.init(named: "GameCenterNewAppTag"), for: .normal)
            self.isLeftBtnSel = true
        }
        if (self.YCHeaderDelegate != nil){
            self.YCHeaderDelegate?.headerViewDidPress(index: self.index!, shopmodel: self.shopModel!, isSel: self.isLeftBtnSel)
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
