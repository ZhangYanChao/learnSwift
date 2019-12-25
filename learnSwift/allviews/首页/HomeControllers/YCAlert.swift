//
//  YCAlert.swift
//  learnSwift
//
//  Created by zyc on 2019/12/13.
//  Copyright © 2019 张言超. All rights reserved.
//

import UIKit

class YCAlert: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Alert"
        customUI()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //移除提示框
        self.presentedViewController?.dismiss(animated: false, completion: nil)
    }
    
    func customUI(){
        let button01 = UIButton.init(frame: CGRect(x: 20, y: 64, width: 100, height: 30))
        button01.setTitle("alertview", for: .normal)
        button01.backgroundColor = .brown
        button01.addTarget(self, action: #selector(customAlertView), for: .touchUpInside)
        self.view.addSubview(button01)
        
        let button02 = UIButton.init(frame: CGRect(x: 20, y: 114, width: 100, height: 30))
        button02.setTitle("sheetview", for: .normal)
        button02.backgroundColor = .brown
        button02.addTarget(self, action: #selector(customSheetview), for: .touchUpInside)
        self.view.addSubview(button02)
        
        let button03 = UIButton.init(frame: CGRect(x: 20, y: 164, width: 100, height: 30))
        button03.setTitle("alert", for: .normal)
        button03.backgroundColor = .brown
        button03.addTarget(self, action: #selector(alert), for: .touchUpInside)
        self.view.addSubview(button03)
        
        let button04 = UIButton.init(frame: CGRect(x: 150, y: 64, width: 100, height: 30))
        button04.setTitle("textfieldAlert", for: .normal)
        button04.backgroundColor = .brown
        button04.addTarget(self, action: #selector(textfieldAlert), for: .touchUpInside)
        self.view.addSubview(button04)
        
        let button05 = UIButton.init(frame: CGRect(x: 150, y: 114, width: 100, height: 30))
        button05.setTitle("AutoDisapper", for: .normal)
        button05.backgroundColor = .brown
        button05.addTarget(self, action: #selector(alertAutoDisapper), for: .touchUpInside)
        self.view.addSubview(button05)
        
        let button06 = UIButton.init(frame: CGRect(x: 150, y: 164, width: 100, height: 30))
        button06.setTitle("alertExtesion", for: .normal)
        button06.backgroundColor = .brown
        button06.addTarget(self, action: #selector(alertExtesion), for: .touchUpInside)
        self.view.addSubview(button06)
        
        let button07 = UIButton.init(frame: CGRect(x: 20, y: 264, width: 150, height: 40))
        button07.setTitle("customalertview", for: .normal)
        button07.backgroundColor = .brown
        button07.addTarget(self, action: #selector(customYCAlertview), for: .touchUpInside)
        self.view.addSubview(button07)
    }
    
    @objc func customYCAlertview(){
        let YCAlert = YCCustomAlertView.init()
//        YCAlert.initWithIndicatorWithView(view: self.view, withText: "正在上传，稍等")
//        YCAlert.startTheView();
//        //两秒钟后自动消失
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
//            YCAlert.stopAndRemoveFromSuperView()
//        }
        YCAlert.initWithView(view: self.view, text: "上传成功", duration: 2)
    }
    
    @objc func alertExtesion(){
        //        UIAlertController.showAlert(message: "保存成功")
        UIAlertController.ShowConfirm(messgae: "保存成功", in: self) { (UIAlertAction) in
            print("do it")
        }
    }
    
    @objc func alertAutoDisapper(){
        let alertController = UIAlertController(title: "保存成功!",
                                                message: nil, preferredStyle: .alert)
        //显示提示框
        self.present(alertController, animated: true, completion: nil)
        //两秒钟后自动消失
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.presentedViewController?.dismiss(animated: false, completion: nil)
        }
    }
    
    @objc func textfieldAlert(){
        //添加任意数量文本输入框
        let alertController = UIAlertController(title: "登陆", message: "输入账号密码", preferredStyle: .alert)
        alertController.addTextField { (textField:UITextField) in
            textField.placeholder = "用户"
            textField.delegate = self
            textField.tag = 1000
        }
        alertController.addTextField { (textField:UITextField) in
            textField.placeholder = "密码"
            textField.isSecureTextEntry = true
            textField.delegate = self
            textField.tag = 1001
        }
        let Login = UIAlertAction(title: "登陆", style: .default, handler: nil)
        let Quit = UIAlertAction(title: "退出", style: .cancel, handler: nil)
        alertController.addAction(Login)
        alertController.addAction(Quit)
        //模态弹出提示框
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func alert(){
        //如果支持版本低于9.0，不能使用
        UIAlertView(title: "提示", message:"", delegate: nil, cancelButtonTitle: "确定").show()
    }
    @objc func customAlertView(){
        let alertVC = UIAlertController(title: "提示", message: "我是提示框", preferredStyle: UIAlertController.Style.alert)
        let acSure = UIAlertAction(title: "确定", style: UIAlertAction.Style.destructive) { (UIAlertAction) -> Void in
            print("click Sure")
        }
        let acCancel = UIAlertAction(title: "取消", style: UIAlertAction.Style.cancel) { (UIAlertAction) -> Void in
            print("click Cancel")
        }
        alertVC.addAction(acSure)
        alertVC.addAction(acCancel)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    @objc func customSheetview() -> Void {
        let alertVC = UIAlertController(title: "提示", message: "我是提示框", preferredStyle: UIAlertController.Style.actionSheet)
        let acSure = UIAlertAction(title: "确定", style: UIAlertAction.Style.destructive) { (UIAlertAction) -> Void in
            print("click Sure")
        }
        let acCancel = UIAlertAction(title: "取消", style: UIAlertAction.Style.cancel) { (UIAlertAction) -> Void in
            print("click Cancel")
        }
        alertVC.addAction(acSure)
        alertVC.addAction(acCancel)
        self.present(alertVC, animated: true, completion: nil)
    }
    
}

extension YCAlert:UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 1000 {
            print("-用户->\(String(describing: textField.text))")
        }else if textField.tag == 1001 {
            print("-密码->\(String(describing: textField.text))")
        }
    }
}

//对UIAlertController进行扩展
extension UIAlertController{
    //创建样式
    static func showAlert(message:String,in viewController:UIViewController){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
    //指定样式播放视图
    static func showAlert(message: String) {
        if let vc = UIApplication.shared.keyWindow?.rootViewController {
            showAlert(message: message, in: vc)
        }
    }
    //创建样式
    static func ShowConfirm(messgae:String,in viewController:UIViewController,confirm:((UIAlertAction)->Void)?){
        let alert = UIAlertController(title: nil, message: messgae, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "取消", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: confirm))
        viewController.present(alert, animated: true, completion: nil)
    }
}

class YCCustomAlertView: UIView {
    //活动指示器
    var activity:UIActivityIndicatorView!
    //添加一个透明的View
    var activityView:UIView!
    
    var durationF:Double = 0.0
    
    
    //MARK: - 网络提示
    func initWithIndicatorWithView(view:UIView, withText:String){
        
        activityView = UIView(frame:CGRect(x:0, y:0, width:kScreenWidth, height:kScreenHeight))
        activityView.backgroundColor = UIColor.clear
        
        
        //配置
        self.frame = CGRect(x:(view.bounds.size.width/2 - 120/2), y:view.bounds.size.height/2 - 90/2, width:120,height:90)
        self.backgroundColor = UIColor.init(white: 0, alpha: 0.8)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 8
        self.alpha = 0
        
        
        //配置
        activity = UIActivityIndicatorView(style: .whiteLarge)
        activity.center = CGPoint(x:60, y: 30)
        activityView.addSubview(activity)
        self.addSubview(activity)
        
        
        //UILabel
        let label = UILabel(frame:CGRect(x:0, y:50, width:120,height:30))
        label.text = withText
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = UIColor.white
        self.addSubview(label)
        
        
        activityView.addSubview(self)
        view.addSubview(activityView)
        activityView.isHidden = true
    }
    
    //显示菊花
    func startTheView(){
        
        activityView.isHidden = false
        activity.startAnimating()
        
        weak var weakSelf = self
        
        UIView.animate(withDuration: 0.3) {
            
            weakSelf?.alpha = 1
        }
    }
    
    
    //隐藏菊花
    func stopAndRemoveFromSuperView(){
        activityView.isHidden = true
        activity.stopAnimating()
        
        weak var weakSelf = self
        
        UIView.animate(withDuration: 0.3, animations: {
            
            weakSelf?.alpha = 0
            
        }) { (finish) in
            
            weakSelf?.activityView.isHidden = true
            weakSelf?.removeFromSuperview()
            
        }
        
        
    }
    
    
    
    //MARK: - 普通提示
    func initWithView(view:UIView, text:String ,duration:Double){
        
        print(text)
        
        durationF = duration
        
        //适配高度
        let size:CGRect =  text.boundingRect(with: CGSize(width: kScreenWidth - 60, height: 400), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)] , context: nil);
        
        //配置
        self.frame = CGRect(x:(view.bounds.size.width/2 - (size.width + 20)/2), y:view.bounds.size.height/2 - 50/2, width:size.width + 20,height:50)
        self.backgroundColor = UIColor.init(white: 0, alpha: 0.8)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 8
        self.alpha = 0
        
        
        //UILabel
        let label = UILabel(frame:CGRect(x:0, y:0, width:self.frame.width,height:50))
        label.text = text
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .center
        label.textColor = UIColor.white
        
        
        self.addSubview(label)
        view.addSubview(self)
        
        weak var weakSelf = self
        
        UIView.animate(withDuration: 0.3, animations: {
            
            weakSelf?.alpha = 1
            
        }) { (finish) in
            
            weakSelf?.perform(#selector(weakSelf?.closeCust), with: nil, afterDelay: (weakSelf?.durationF)!)
            
        }
        
        
    }
    
    //关闭
    @objc func closeCust(){
        
        UIView.animate(withDuration: 0.3, animations: {
            
            self.alpha = 0
            
        }) { (finished:Bool) in
            
            self.removeFromSuperview()
        }
    }
    
}
