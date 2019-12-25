//
//  YCOrderShopCartCell.swift
//  learnSwift
//
//  Created by zyc on 2019/12/23.
//  Copyright © 2019 张言超. All rights reserved.
//

import UIKit

@objc protocol YCOrderShopCartCellDelegate {
    /**cell点击了*/
    func shopCellDidPress(goodModel:YCOrderGoodsModel, cell:YCOrderShopCartCell)
    /**加号按钮点击了*/
    func addBtnDidPress(goodModel:YCOrderGoodsModel, cell:YCOrderShopCartCell)
    /**减号按钮点击了*/
    func minusBtnDidPress(goodModel:YCOrderGoodsModel, cell:YCOrderShopCartCell)
    /**左侧选择按钮点击了*/
    func leftSelBtnDidPress(goodModel:YCOrderGoodsModel, cell:YCOrderShopCartCell, isSel:Bool)
}

class YCOrderShopCartCell: UITableViewCell {
    
    let cellHeight:CGFloat = 100//整体的高度
    let boardWidth:CGFloat = 10
    let backHeight:CGFloat = 90//背景内容的高度
    let backWidth:CGFloat =  kScreenWidth-10 //内容的宽
    let smallBtnWH:CGFloat = 25 //右下角按钮尺寸
    let leftSelBtnWH:CGFloat = 30
    
    /** 背景View */
    var backView:UIView?
    /** 左侧选择的按钮 */
    var leftSelBtn:UIButton?
    /** 商品的图片 */
    var commodityImageView:UIImageView?
    /** 商品名字 */
    var commodityNameLabel:UILabel?
    /** 商品详情label */
    var commodityDetailLabel:UILabel?
    /** 价格label */
    var priceLabel:UILabel?
    /** 减号按钮 */
    var minusBtn:UIButton?
    /** 数量label */
    var countLabel:UILabel?
    /** 加号按钮 */
    var addBtn:UIButton?
    /** 左侧按钮 */
    var isLeftBtnSel:Bool = false

    
    //代理
    weak var YCcellDelegate:YCOrderShopCartCellDelegate?
    
    //数据模型
    private var _xgoodModel:YCOrderGoodsModel?
    var xgoodModel:YCOrderGoodsModel?{
        get{
            return _xgoodModel
        }
        set{
            _xgoodModel = newValue
            if _xgoodModel!.goodsIsSelect {
                self .setBtnImage(imageName: "sight_moments_mute_selected", button: self.leftSelBtn!)
                self.isLeftBtnSel = true
            }else{
                self .setBtnImage(imageName: "sight_moments_mute_select", button: self.leftSelBtn!)
                self.isLeftBtnSel = false
            }
            self.commodityNameLabel?.text = _xgoodModel?.goodsName
            self.countLabel?.text = "\(_xgoodModel?.goodsCount ?? 0)"
            self.priceLabel?.text = _xgoodModel?.goodsPrice
            self.commodityDetailLabel?.text = _xgoodModel?.goodsDescription
        }
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //背景
        self.backView = UIView.init(frame: CGRect(x: 0, y: boardWidth*0.5, width: kScreenWidth - boardWidth, height: cellHeight-boardWidth))
        self.backView?.backgroundColor = .white
        self.contentView.addSubview(self.backView!)
        
        //左侧选中按钮
        self.leftSelBtn = UIButton.init()
        self.leftSelBtn?.addTarget(self, action: #selector(leftSelBtnDidPress(button:)), for: .touchUpInside)
        self.backView?.addSubview(self.leftSelBtn!)
        
        //商品imageview
        self.commodityImageView = UIImageView.init()
        self.commodityImageView?.image = UIImage.init(named: "CreditCard_ShoppingBag")
        self.backView?.addSubview(self.commodityImageView!)
        
        //商品标题label
        self.commodityNameLabel = UILabel.init()
        self.commodityNameLabel?.textColor = .black
        self.commodityNameLabel?.font = UIFont.systemFont(ofSize: 18)
        self.backView?.addSubview(self.commodityNameLabel!)
        
        //商品详情描述label
        self.commodityDetailLabel = UILabel.init()
        self.commodityDetailLabel?.font = UIFont.systemFont(ofSize: 15)
        self.commodityDetailLabel?.textColor = .black
        self.commodityDetailLabel?.numberOfLines = 0
        self.backView?.addSubview(self.commodityDetailLabel!)
        
        //价格label
        self.priceLabel = UILabel.init()
        self.priceLabel?.textColor = UIColor.colorWithCustom(r: 245, g: 61, b: 28)
        self.priceLabel?.font = UIFont.systemFont(ofSize: 18)
        self.priceLabel?.textAlignment = .right
        self.backView?.addSubview(self.priceLabel!)
        
        //减号按钮
        self.minusBtn = UIButton.init()
        self.minusBtn?.setImage(UIImage.init(named: "RemoveGroupMemberBtn"), for: .normal)
        self.minusBtn?.setImage(UIImage.init(named: "RemoveGroupMemberBtnHL"), for: .highlighted)
        self.minusBtn?.addTarget(self, action: #selector(minusBtnDidPress(button:)), for: .touchUpInside)
        self.backView?.addSubview(self.minusBtn!)
        
        //中间数量label
        self.countLabel = UILabel.init()
        self.countLabel?.textAlignment = .center
        self.countLabel?.textColor = .black
        self.countLabel?.font = UIFont.systemFont(ofSize: 18)
        self.backView?.addSubview(self.countLabel!)
        
        //加号按钮
        self.addBtn = UIButton.init()
        self.addBtn?.setImage(UIImage.init(named: "AlbumAddBtn"), for: .normal)
        self.addBtn?.setImage(UIImage.init(named: "AlbumAddBtnHL"), for: .highlighted)
        self.addBtn?.addTarget(self, action: #selector(addBtnDidPress(button:)), for: .touchUpInside)
        self.backView?.addSubview(self.addBtn!)
        
        //点击手势
        let sigleTap = UITapGestureRecognizer.init(target: self, action: #selector(cellDidPress(tap:)))
        self.addGestureRecognizer(sigleTap)
        self.setNeedsDisplay()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.leftSelBtn?.frame = CGRect(x: boardWidth, y: (backHeight - leftSelBtnWH)*0.5, width: leftSelBtnWH, height: leftSelBtnWH)
        
        self.commodityImageView?.frame = CGRect(x: 2*boardWidth+leftSelBtnWH, y: boardWidth*0.5, width: backHeight - boardWidth, height: backHeight - boardWidth)
        
        self.priceLabel?.frame = CGRect(x: backWidth - 80 - boardWidth, y: boardWidth, width: 80, height: 30)
        
        self.commodityNameLabel?.frame = CGRect(x: (self.commodityImageView?.yc_right())! + boardWidth, y: boardWidth, width: backWidth - 5*boardWidth - leftSelBtnWH - self.commodityImageView!.yc_width() - self.priceLabel!.yc_width(), height: 25)
        
        self.addBtn?.frame = CGRect(x: backWidth - boardWidth - smallBtnWH, y: (self.backView?.yc_bottom())! - boardWidth - smallBtnWH, width: smallBtnWH, height: smallBtnWH)
        
        self.countLabel?.frame = CGRect(x: (self.addBtn?.yc_originX())! - boardWidth*0.5-smallBtnWH, y: (self.addBtn?.yc_originY())!, width: smallBtnWH, height: smallBtnWH)
        
        self.minusBtn?.frame = CGRect(x: (self.countLabel?.yc_originX())! - boardWidth*0.5 - smallBtnWH, y: (self.addBtn?.yc_originY())!, width: smallBtnWH, height: smallBtnWH)
        
        self.commodityDetailLabel?.frame = CGRect(x: (self.commodityImageView?.yc_right())! + boardWidth, y: (self.commodityNameLabel?.yc_bottom())! + boardWidth*0.5, width: backWidth - 5.5 * boardWidth - (self.leftSelBtn?.yc_width())! - (self.commodityImageView!.yc_width()) - smallBtnWH*3, height: backHeight - boardWidth * 2 - (self.commodityNameLabel?.yc_height())!)
    }

    //MARK: -- activity
    /** 左侧选择的按钮点击了 */
    @objc func leftSelBtnDidPress(button:UIButton){
        if self.isLeftBtnSel {
            self.setBtnImage(imageName: "sight_moments_mute_select", button: self.leftSelBtn!)
            self.isLeftBtnSel = false
        }else{
            self.setBtnImage(imageName: "sight_moments_mute_selected", button: self.leftSelBtn!)
            self.isLeftBtnSel = true
        }
        if (self.YCcellDelegate != nil) {
            self.YCcellDelegate?.leftSelBtnDidPress(goodModel: self.xgoodModel!, cell: self, isSel: self.isLeftBtnSel)
        }
    }
    /** 减号按钮点击了 */
    @objc func minusBtnDidPress(button:UIButton){
        if (self.YCcellDelegate != nil) {
            self.YCcellDelegate?.minusBtnDidPress(goodModel: self.xgoodModel!, cell: self)
        }
    }
    /** 加号按钮点击了 */
    @objc func addBtnDidPress(button:UIButton){
        if (self.YCcellDelegate != nil) {
            self.YCcellDelegate?.addBtnDidPress(goodModel: self.xgoodModel!, cell: self)
        }
    }
    /** cell点击 */
    @objc func cellDidPress(tap:UITapGestureRecognizer){
        if (self.YCcellDelegate != nil) {
            self.YCcellDelegate?.shopCellDidPress(goodModel: self.xgoodModel!, cell: self)
        }
    }
    //MARK: -- tool_func
    func setBtnImage(imageName:String, button:UIButton){
        button.setImage(UIImage.init(named: imageName), for: .normal)
    }
}
