//
//  UIButtonController.swift
//  learnSwift
//
//  Created by zyc on 2019/11/20.
//  Copyright © 2019 张言超. All rights reserved.
//

import UIKit

class UIButtonController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "UIButton"
        customButtonUI()
    }
    
    private func customButtonUI(){
        
        self.view.backgroundColor = UIColor.randomColor()
        
        //button type
        //system 不自带图标，默认文字为蓝色，点击有高亮效果
        let btn1 = UIButton(type: UIButton.ButtonType.system)
        btn1.frame = CGRect(x: 30, y: 30, width: 120, height: 30)
        btn1.setTitle("system 按钮", for: UIControl.State.normal)
        self.view.addSubview(btn1)
        
        //custom 自定制按钮，不自带图标，默认文字是白色，点击无高亮效果
        let btn2 = UIButton(type: UIButton.ButtonType.custom)
        btn2.frame = CGRect(x: 190, y: 30, width: 120, height: 30)
        btn2.setTitle("custom 按钮", for: UIControl.State.normal)
        self.view.addSubview(btn2)
        
        //contactAdd 自带+号图标，默认文字是蓝色，点击有高亮效果
        let btn3 = UIButton(type: UIButton.ButtonType.contactAdd)
        btn3.frame = CGRect(x: 30, y: 80, width: 120, height: 30)
        btn3.setTitle("contactAdd 按钮", for: UIControl.State.normal)
        self.view.addSubview(btn3)
        
        //infoDark,infoLight,detailDisclosure 自带圆形感叹号!号图标 有高亮效果
        let btn4 = UIButton(type: UIButton.ButtonType.infoDark)
        btn4.frame = CGRect(x: 190, y: 80, width: 120, height: 30)
        btn4.setTitle("infoDark 按钮", for: UIControl.State.normal)
        self.view.addSubview(btn4)
        //处理button 按钮中 titleLabel 的 lineBreakMode 属性
        let btn5 = UIButton(type: UIButton.ButtonType.system)
        btn5.frame = CGRect(x: 190, y: 130, width: 120, height: 120)
        btn5.backgroundColor = UIColor.white
//        btn5.setTitle("这是一个很长很长的按钮", for: UIControl.State.normal)
        btn5.setTitle("这是一个\n很长很长的按钮", for: UIControl.State.normal)
        /*
         byTruncatingHead：省略头部文字，省略部分用...代替
         byTruncatingMiddle：省略中间部分文字，省略部分用...代替（默认）
         byTruncatingTail：省略尾部文字，省略部分用...代替
         byClipping：直接将多余的部分截断
         byWordWrapping：自动换行（按词拆分）
         byCharWrapping：自动换行（按字符拆分）
         */
        
        btn5.titleLabel?.lineBreakMode = .byWordWrapping
        self.view.addSubview(btn5)
        
        //边框，圆角
        let btn6 = UIButton(frame: CGRect(x: 15, y: 300, width: 100, height: 100))
        btn6.backgroundColor = UIColor.white
        btn6.setTitle("swift_Btn", for: .normal)
        btn6.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn6.setTitleColor(UIColor.brown, for: .normal)
        btn6.layer.masksToBounds = true
        btn6.layer.cornerRadius = 5
        btn6.layer.borderColor = UIColor.randomColor().cgColor
        btn6.layer.borderWidth = 2
        self.view.addSubview(btn6)
        
        //EdgeInsets能调整btn中y图片和label的相对位置，无法调整图片的大小
        let btn7 = UIButton(type: UIButton.ButtonType.custom)
        btn7.backgroundColor = UIColor.white
        btn7.frame = CGRect(x: 135, y: 300, width: 100, height: 100)
        btn7.setImage(UIImage(named: "shopCart"), for: UIControl.State.normal)
        btn7.setTitle("helloswift", for: .normal)
        //调整button中图片的位置
        btn7.imageView?.backgroundColor = UIColor.blue
        btn7.imageEdgeInsets = UIEdgeInsets.init(top: 8, left: 35, bottom: 40, right: 35)
        //调整button中label的位置
        btn7.titleLabel?.backgroundColor = UIColor.red
        btn7.titleEdgeInsets = UIEdgeInsets.init(top: 60, left: -25, bottom: 10, right: 0)
        self.view.addSubview(btn7)
        
        //buuton 文字颜色，文字阴影颜色
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.setTitle("普通状态", for:.normal) //普通状态下的文字
        button.setTitle("触摸状态", for:.highlighted) //触摸状态下的文字
        button.setTitle("禁用状态", for:.disabled) //禁用状态下的文字
        
        button.setTitleColor(UIColor.black, for: .normal) //普通状态下文字的颜色
        button.setTitleColor(UIColor.green, for: .highlighted) //触摸状态下文字的颜色
        button.setTitleColor(UIColor.gray, for: .disabled) //禁用状态下文字的颜色
        
        button.setTitleShadowColor(UIColor.green, for:.normal) //普通状态下文字阴影的颜色
        button.setTitleShadowColor(UIColor.yellow, for:.highlighted) //普通状态下文字阴影的颜色
        button.setTitleShadowColor(UIColor.gray, for:.disabled) //普通状态下文字阴影的颜色
        
        button.frame = CGRect(x: 30, y: 130, width: 120, height: 120)
        button.backgroundColor = UIColor.white
        //设置font
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.setImage(UIImage(named: "shopCart"), for: UIControl.State.normal)  //设置图标
        button.adjustsImageWhenHighlighted=false //使触摸模式下按钮也不会变暗（半透明）
        button.adjustsImageWhenDisabled=false //使禁用模式下按钮也不会变暗（半透明）
        self.view.addSubview(button)
        //普通的无需传参的
        btn2.addTarget(self, action: #selector(btnClick1), for: UIControl.Event.touchUpInside)
        //需要传参的
        button.tag = 999
        button.addTarget(self, action: #selector(btnClick2(btn:)), for: UIControl.Event.touchUpInside)
        /*
        常用的触摸事件类型：
        touchDown：单点触摸按下事件，点触屏幕
        touchDownRepeat：多点触摸按下事件，点触计数大于1，按下第2、3或第4根手指的时候
        touchDragInside：触摸在控件内拖动时
        touchDragOutside：触摸在控件外拖动时
        touchDragEnter：触摸从控件之外拖动到内部时
        touchDragExit：触摸从控件内部拖动到外部时
        touchUpInside：在控件之内触摸并抬起事件
        touchUpOutside：在控件之外触摸抬起事件
        touchCancel：触摸取消事件，即一次触摸因为放上太多手指而被取消，或者电话打断
        */
        
        let btn8 = YCButton.init(frame: CGRect(x: 260, y: 300, width: 100, height: 100))
        btn8.setImage(UIImage(named: "shopCart"), for: .normal)
        btn8.setTitle("购物车", for: .normal)
        btn8.backgroundColor = UIColor.white
        btn8.setTitleColor(UIColor.black, for: .normal)
        btn8.addTarget(self, action: #selector(btnclick3(btn:)), for: UIControl.Event.touchUpInside)
        //没有设置高亮状态的UIImage，点击去掉变暗
        btn8.adjustsImageWhenHighlighted=false
        self.view.addSubview(btn8)
    }
    
    //button点击事件为何要加上@objc关键字
    //#selector是Objective-C runtime，swift默认所有方法是不暴露给OC的，
    //加上@objc，OC类就可以正常调用
    @objc func btnClick1(){
        print("button1--点击")
    }
    
    @objc func btnClick2(btn:UIButton){
        print("button2--点击\(btn.tag)")
        btn.isEnabled = false
    }
    
}

@objc
extension UIButtonController{
    func btnclick3(btn:UIButton){
        print("btnclick3---")
    }
}

class YCButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.titleLabel?.textAlignment = NSTextAlignment.center;
        self.titleLabel?.font = UIFont.systemFont(ofSize: 15);
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let YCButtonImageRatio:CGFloat = 0.4
    //调整imgview的大小位置
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        let imgW:CGFloat = contentRect.size.width * YCButtonImageRatio
        let imgH:CGFloat = contentRect.size.height * YCButtonImageRatio
        let imgX:CGFloat = contentRect.size.width * (1-YCButtonImageRatio)/2
        let imgY:CGFloat = contentRect.size.height * 0.2
        
        return CGRect(x: imgX, y: imgY, width: imgW, height: imgH)
    }
    //调整label的位置大小
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        let labelY:CGFloat = contentRect.size.height * (1-YCButtonImageRatio)
        let labelW:CGFloat = contentRect.size.width
        let labelH:CGFloat = contentRect.size.height - labelY
        return CGRect(x: 0, y: labelY, width: labelW, height: labelH)
    }
}
