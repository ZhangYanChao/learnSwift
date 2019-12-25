//
//  UIScrollViewController.swift
//  learnSwift
//
//  Created by zyc on 2019/11/20.
//  Copyright © 2019 张言超. All rights reserved.
//

import UIKit

class UIScrollViewController: BaseViewController,UIScrollViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "UIScrollView"
        customScrollviewUI()
    }
    var currentBtn = UIButton()
    let scrollview = UIScrollView()
    private func customScrollviewUI(){
        //做一个分类导航
        //1,创建分类标题
        let titleArrs = ["精选美食","每日特价","9.9疯抢","服饰美妆"]
        let btnWidth = kScreenWidth/4.0
        for index in 0..<4 {
            let btn = UIButton.init(type: UIButton.ButtonType.custom)
            if index == 0 {
                currentBtn = btn
                currentBtn.heightT()
            }
            btn.frame = CGRect(x: CGFloat(index) * btnWidth, y: 0, width: btnWidth, height: 46)
            btn.setTitle(titleArrs[index], for: UIControl.State.normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
            btn.setTitleColor(UIColor.randomColor(), for: .normal)
            //添加tag
            btn.tag = 100 + index
            btn.backgroundColor = UIColor.white
            btn.addTarget(self, action: #selector(btnClick(btn:)), for: UIControl.Event.touchUpInside)
            self.view.addSubview(btn)
        }
        
        //创建scrollview
        scrollview.frame = CGRect(x: 0, y: 46, width: kScreenWidth, height: kScreenHeight - 46)
        scrollview.showsVerticalScrollIndicator = false
        scrollview.showsHorizontalScrollIndicator = false
        scrollview.contentSize = CGSize(width: 4*kScreenWidth, height: kScreenHeight - 46)
        scrollview.isPagingEnabled = true
        scrollview.delegate = self
        self.view.addSubview(scrollview)
        
        //分类视图view
        for zindex in 0..<4 {
            let xview = UIView.init()
            xview.frame = CGRect(x: CGFloat(zindex) * kScreenWidth, y: 0, width: kScreenWidth, height: kScreenHeight - 46)
            xview.backgroundColor = UIColor.randomColor()
            
            let label = UILabel.init(frame: CGRect(x: CGFloat(zindex) * kScreenWidth + 30, y: 30, width: 100, height: 100))
            label.text = "第\(zindex+1)页"
            label.textColor = UIColor.white
            scrollview.addSubview(xview)
            scrollview.addSubview(label)
            
        }
        
    }
    
    //MARK: - UIScrollViewDelegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset)
        let point:CGPoint = scrollView.contentOffset
        let xcurrent = Int(point.x/kScreenWidth)
        getBtn(index: xcurrent)
    }
    
    private func getBtn(index:Int) -> Void{
        
        let btn = view.viewWithTag(100 + index) as! UIButton
        if currentBtn.tag != (100 + index) {
            currentBtn.hideHeightT()
            currentBtn = btn
        }
        btn.heightT()
    }
    
    @objc func btnClick(btn:UIButton) -> Void {
//        print("-btn->\(btn.tag)-cubtn->\(currentBtn.tag)")
        //button高亮状态转换
        if currentBtn.tag != btn.tag {
            currentBtn.hideHeightT()
            currentBtn = btn
            btn.heightT()
        }
        
        //跳转下面的view
        let offsetWith = CGFloat(btn.tag - 100) * kScreenWidth
        scrollview.setContentOffset(CGPoint(x: offsetWith, y: 0), animated: false)
    }
}

extension UIButton{
    func heightT() -> Void {
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.borderWidth = 2
    }
    func hideHeightT() -> Void {
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.borderWidth = 0
    }
}
