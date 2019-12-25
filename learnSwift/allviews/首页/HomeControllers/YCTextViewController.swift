//
//  YCTextViewController.swift
//  learnSwift
//
//  Created by zyc on 2019/12/13.
//  Copyright © 2019 张言超. All rights reserved.
//

import UIKit

class YCTextViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        customTextView()
        self.navigationItem.title = "UITextView"
    }
    
    
    
    var yctextView = UITextView.init()
    var NumLB = UILabel.init()
    func customTextView() -> Void {
        yctextView = UITextView.init(frame: CGRect(x: 20, y: 64, width: kScreenWidth - 40, height: 200))
        self.view.addSubview(yctextView)
        
        //背景颜色
        yctextView.backgroundColor = .white
        
        //textview中文字的大小,颜色
        yctextView.font = UIFont.systemFont(ofSize: 18)
        yctextView.textColor = .black
        
        //设置边框
        yctextView.layer.borderWidth = 2
        yctextView.layer.borderColor = UIColor.red.cgColor
        
        //设置内容是否可选(进行copy等操作)
        yctextView.isSelectable = true //内容不可选，也无法进行编辑
        yctextView.allowsEditingTextAttributes = false
        
        //设置对齐方式
        yctextView.textAlignment = .center
        
        //测试
        yctextView.text = "这是一个测试文本，文本中有手机号13655236678，有网址www.baidu.com，看看能不能被自动识别,"
        //自动识别电话，地址并跳转(只有在不可编译状态下才能识别)
        /**
         phoneNumber 识别电话
         link 识别地址
         all 电话、地址
        */
//        yctextView.dataDetectorTypes = [.phoneNumber, .link]
        yctextView.dataDetectorTypes = []
        
        let attribute = NSMutableAttributedString(string: yctextView.text)
        // 设置段落样式
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineSpacing = 10
        // 设置属性字典
        let dic = [NSAttributedString.Key.foregroundColor: UIColor.green,
                   NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 22.0),
                   NSAttributedString.Key.paragraphStyle: paragraphStyle]
        // 添加属性字典
        attribute.addAttributes(dic, range: NSMakeRange(16, yctextView.text.count - 16))
        // 设置textView的attributedText
        yctextView.attributedText = attribute
        
        //设置文本内容与边框的间距
        yctextView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    //自定义选择内容后的菜单(在选中一段文本后将会显示一系列copy，cur，replace等选项，我们也可以自定义一些选项)
        let share = UIMenuItem(title: "分享", action: #selector(Share))
        let WeChat = UIMenuItem(title: "微信", action: #selector(WeChatOne))
        let menu = UIMenuController()
        menu.menuItems = [share,WeChat]
        
        NumLB = UILabel.init(frame: CGRect(x: kScreenWidth - 100, y: 280, width: 80, height: 26))
        self.view.addSubview(NumLB)
        NumLB.textColor = .brown
        NumLB.textAlignment = .right
        NumLB.text = "\(yctextView.text.count)/200"
        
        //监听textview文字和输入状态的变化
        /*
        NotificationCenter.default.addObserver(self, selector: #selector(txtBegin), name: UITextView.textDidBeginEditingNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(txtChange), name: UITextView.textDidChangeNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(txtEnd), name: UITextView.textDidEndEditingNotification, object: nil)
        */
        //textview的delegate
        yctextView.delegate = self
    }
    @objc func Share(){
        print("已分享")
    }
    @objc func WeChatOne(){
        print("微信,打印选择的部分-Range->\(yctextView.selectedRange)")
        //根据选择的range，找出内容
        let ss:String = yctextView.text
        let ssrange:NSRange = yctextView.selectedRange
        let index01 = ss.index(ss.startIndex, offsetBy: ssrange.location)
        let index02 = ss.index(ss.startIndex, offsetBy: (ssrange.location + ssrange.length))
        let rangeStr = ss[index01..<index02]
        print("打印选择的内容-->\(rangeStr)")
    }
    
    @objc func txtBegin(){
        print("yctextView--开始输入")
    }
    @objc func txtChange(){
        print("yctextView--开始输入：\(String(describing: yctextView.text))")
        NumLB.text = "\(yctextView.text.count)/200"
        if yctextView.text.count > 200 {
            print("你的输入超纲了，请保证内容在200字以内！")
        }
    }
    @objc func txtEnd(){
        print("yctextView--输入结束")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension YCTextViewController:UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("开始输入")
    }
    func textViewDidChange(_ textView: UITextView) {
        print("输入中--")
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        print("结束输入")
    }
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        //控制textview能否结束编辑
        return true
    }
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        //控制textview能否编辑
        return true
    }
    func textViewDidChangeSelection(_ textView: UITextView) {
//        print("xxx---",textView.text ?? "nil")
        //编辑时，选中后调整都会调用
        //编辑时，只要光标移动都会调用
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        //编辑时调用
        //调用次序在textViewDidChange之前
        return true
    }
}
