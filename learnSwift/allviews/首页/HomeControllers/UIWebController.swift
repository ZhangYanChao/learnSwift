//
//  UIWebController.swift
//  learnSwift
//
//  Created by zyc on 2019/12/1.
//  Copyright © 2019 张言超. All rights reserved.
//

import UIKit
import WebKit

class UIWebController: BaseViewController {
    
    
    var mywebview = WKWebView()
    var loadType = UISegmentedControl()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.progressView.frame = CGRect(x:0,y:0,width:kScreenWidth,height:2)
        self.progressView.isHidden = false
        UIView.animate(withDuration: 1.0){
            self.progressView.progress = 0.0
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "WKWebView"
        
        customWKWebviewUI()
        customRightButton()
        customSegmentedControl()
    }
    
    func customSegmentedControl() {
        loadType = UISegmentedControl(items: ["显示网站","显示HTML","显示本地文件","loadData显示本地"])
        loadType.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 40)
        loadType.selectedSegmentIndex = 1
        loadType.addTarget(self, action: #selector(typeChanged(_:)), for: .valueChanged)
        view.addSubview(loadType)
    }
    @objc func typeChanged(_ sender:UISegmentedControl){
        let index = sender.selectedSegmentIndex
        switch index {
        case 0:
        //设置访问的url
            let url = URL(string: "https://www.jianshu.com/u/782695e147fa")
        //根据url创建请求
            let urlRequest = URLRequest(url: url!)
        //加载请求
            mywebview.load(urlRequest)
        case 1:
            let html = "<h1>欢迎来到:<a href='https://www.jianshu.com/u/782695e147fa'>Swift学习</a></h1>"
            mywebview.loadHTMLString(html, baseURL: nil)
        case 2:
            let path = Bundle.main.path(forResource: "test", ofType: "pdf")
            let url = URL(fileURLWithPath: path!)
            let urlRequest = URLRequest(url: url)
            mywebview.load(urlRequest)
        case 3:
            let path = Bundle.main.path(forResource: "test", ofType: "pdf")
            let url = URL(fileURLWithPath: path!)
            let data = try! Data(contentsOf: url)
            mywebview.load(data, mimeType: "application/pdf", characterEncodingName: "utf-8", baseURL: NSURL() as URL)
        default:
            print("出现错误")
        }
    }
    
    open var baritemBtn = UIButton()
    private func customRightButton(){
        baritemBtn = UIButton.init(type: UIButton.ButtonType.custom)
        baritemBtn.frame = CGRect(x: 0, y: 0, width: 60, height: 30)
        baritemBtn.setTitle("返回上一页", for: .normal)
        baritemBtn.setTitleColor(.black, for: .normal)
        baritemBtn.addTarget(self, action: #selector(webviewBack), for: .touchUpInside)
        baritemBtn.isHidden = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: baritemBtn)
    }
    
    @objc func webviewBack(){
        let backlist = self.mywebview.backForwardList
        for index in 0..<backlist.backList.count {
            let item:WKBackForwardListItem = backlist.backList[index]
            print("\(index)-title->\(String(describing: item.title))")
        }
        if mywebview.canGoBack {
            mywebview.goBack()
        }
        print(backlist.backList.count)
        if backlist.backList.count == 0 {
            baritemBtn.isHidden = true
        }
    }
    
    private func customWKWebviewUI(){
        mywebview = WKWebView.init(frame: CGRect(x: 0, y: 40, width: kScreenWidth, height: kScreenHeight - 64 - 40))
//        let url = "https://www.jianshu.com/u/782695e147fa"
        let url = "https://www.baidu.com"
        let request = URLRequest(url: URL(string: url)!)
        mywebview.load(request)
        view.addSubview(mywebview)
        mywebview.isHidden = true
        
        let time:TimeInterval = 4.0
        //4秒后执行
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+time) {
            //显示webview
            self.mywebview.isHidden = false;
        }
        
        mywebview.navigationDelegate = self
        view.addSubview(self.progressView)
    }
    
    lazy var progressView:UIProgressView = {
       let progress = UIProgressView()
        progress.progressTintColor = UIColor.red
        progress.trackTintColor = .clear
        return progress
    }()

}

extension UIWebController:WKNavigationDelegate{
    //页面开始加载
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.navigationItem.title = "加载中..."
        /// 获取网页的progress
        UIView.animate(withDuration: 0.5) {
            self.progressView.progress = Float(self.mywebview.estimatedProgress)
        }
    }
    //页面内容开始返时调用
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("内容开始返回")
//        let backlist = self.mywebview.backForwardList
        if self.mywebview.canGoBack {
            self.baritemBtn.isHidden = false
        }else{
            self.baritemBtn.isHidden = true
        }
    }
    //页面加载完成之后调用
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("页面内容加载完成")
        
        //获取网页的title
        self.navigationItem.title = self.mywebview.title
        
        UIView.animate(withDuration: 0.5){
            self.progressView.progress = 1.0
            self.progressView.isHidden = true
        }
    }
    //页面加载失败时调用
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
        UIView.animate(withDuration: 0.5){
            self.progressView.progress = 0.0
            self.progressView.isHidden = true
        }
        //弹出提示
        let alertview = UIAlertController.init(title: "提示", message: "加载失败", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction.init(title: "确定", style: UIAlertAction.Style.default) { (okAction) in
//            self.navigationController?.popViewController(animated: true)
        }
        alertview.addAction(okAction)
        self.present(alertview, animated: true, completion: nil)
    }
}
