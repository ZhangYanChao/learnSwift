//
//  UITextViewController.swift
//  learnSwift
//
//  Created by zyc on 2019/12/12.
//  Copyright © 2019 张言超. All rights reserved.
//

import UIKit

class UITextViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //1，UITextField
        customTextField()
        //2，UITextView
        
    }
    var myTextFeild = UITextField.init()
    func customTextField() -> Void {
        //初始化 并设置frame
        myTextFeild = UITextField.init(frame: CGRect(x: 10, y: 64+30, width: kScreenWidth - 20, height: 40))
        self.view.addSubview(myTextFeild)
        //z设置输入框的样式
        /**
        设置样式
        bezel : 是矩形的浅黑线框样式
        line  : 是矩形的黑线框样式
        roundedRect ： 四个圆角的浅灰色矩形框
        none:   系统默认（全白色）
        */
        myTextFeild.borderStyle = .roundedRect
        
        //设置显示提示文字
        myTextFeild.placeholder = "请输入用户名"
        
        //使用attributedPlaceholder更改提示文字的颜色和大小
        myTextFeild.attributedPlaceholder = NSAttributedString.init(string: "看一看", attributes: [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 18),NSAttributedString.Key.foregroundColor:UIColor.magenta])
        
        /**
         设置全部清除按钮
         always :输入框内有输入的情况下，还会一直显示
         whileEditing : 当输入框处于编辑的情况下会显示清除按钮，当输入框不在编辑的情况下，清除按钮就会消失。
         never : 就是一直都不显示全部清除按钮
         unlessEditing : 输入框在编辑的时候不出现清除按钮，当输入框结束编辑的时候，清除按钮就会出现
         */
        myTextFeild.clearButtonMode = .unlessEditing
        
        //控制输入框文字显示明文还是暗文 true 显示暗文 false 显示明文，默认false显示明文
        myTextFeild.isSecureTextEntry = false;
        
        //设置输入文字的颜色、大小、输入后所在位置
        myTextFeild.font = UIFont.systemFont(ofSize: 18)
        myTextFeild.textColor = .red
        //center中间、left左边（默认），right右边
        myTextFeild.textAlignment = .left
        
        /**
         设置输入框的背景色
         */
        myTextFeild.backgroundColor = UIColor.blue

        /**
         设置输入框弹出的键盘
         键盘的样式有好多种，后续再说
         */
        myTextFeild.keyboardType = UIKeyboardType.asciiCapable

        /**
         设置输入框键盘的returen 键的文字
         */
        myTextFeild.returnKeyType = .search
        
        /**
         设置是否开始编辑就清 楚输入框的内容
         clearsOnBeginEditing
         true : 输入框以开始编辑就清楚输入框里面的所有内容
         false : 输入框开始编辑不清楚里面原有的内容(系统默认)
         */
        myTextFeild.clearsOnBeginEditing = true
        
        //代理
//        myTextFeild.delegate = self
        
        //除了delegate代理实现控制textField，还是使用KVO监听来快速实现某些需求
        
        /**
         Notification.Name.UITextFieldTextDidEndEditing
         Notification.Name.UITextFieldTextDidChange
         Notification.Name.UITextFieldTextDidBeginEditing
         
         NotificationCenter.default.addObserver(self, selector: #selector(test), name: Notification.Name.UITextFieldTextDidBeginEditing, object: nil)
         之前还可以这样监听key，来实现，目前这些key notworking
         替换下面的key
         public class let textDidBeginEditingNotification: NSNotification.Name

         public class let textDidEndEditingNotification: NSNotification.Name

         public class let textDidChangeNotification: NSNotification.Name
         */
        
        NotificationCenter.default.addObserver(self, selector: #selector(NotChangetext), name: UITextField.textDidChangeNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(NotBegintext), name: UITextField.textDidBeginEditingNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(NotEndtext), name: UITextField.textDidEndEditingNotification, object: nil)
        
        
//        myTextFeild.addTarget(self, action: #selector(changeValue(ttx:)), for: .editingChanged)
//        myTextFeild.addTarget(self, action: #selector(textChangeEnd(ttx:)), for: .editingDidEnd)
//        myTextFeild.addTarget(self, action: #selector(textBeiginChange(ttx:)), for: .editingDidBegin)

    }
    @objc func textBeiginChange(ttx:UITextField) -> Void{
        print("--begin->\(String(describing: ttx.text))")
    }
    @objc func changeValue(ttx:UITextField) -> Void {
        print(ttx.text ?? "xxd")
    }
    @objc func textChangeEnd(ttx:UITextField) -> Void{
        print("-end-->\(String(describing: ttx.text))")
    }
    
    @objc func NotChangetext(){
        print("监听到变化了---\(String(describing: myTextFeild.text))")
    }
    @objc func NotBegintext(){
        print("开始输入了---")
    }
    @objc func NotEndtext(){
        print("输入结束了---")
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //让整个view去掉键盘
        self.view.endEditing(true)
    }
}




//MARK: UITextFieldDelegate
extension UITextViewController:UITextFieldDelegate{
    //UITextField开始输入编辑调用次函数
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBeginEditing------begin")
    }
    
    //是否允许编辑
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    //结束编辑时候调用该函数
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("textFieldDidEndEditing-------end")
    }
    
    /**
     过滤输入的内容，是否允许显示
     */
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    /**
     控制输入框，不允许一次行清楚
     系统默认 true
     */
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
         return true
    }
    /**
     禁止输入框使用键盘上的 Retrun 键
     */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("xxxxxx")
        textField.endEditing(true)
         return true
    }
    /**
     禁止编辑结束
     */
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
         return true
    }
    
}
