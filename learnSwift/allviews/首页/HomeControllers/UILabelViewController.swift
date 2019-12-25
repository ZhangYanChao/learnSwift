//
//  UILabelViewController.swift
//  learnSwift
//
//  Created by zyc on 2019/11/20.
//  Copyright © 2019 张言超. All rights reserved.
//

import UIKit

@available(iOS 11.0, *)
@available(iOS 11.0, *)
class UILabelViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "UILabel"
        customLabelUI()
        labelSizeOfText()
        labelRichText()
    }
    //富文本
    func labelRichText() -> Void {
        
        let label = UILabel.init(frame: CGRect.init(origin: CGPoint.init(x: 20, y: 220), size: CGSize(width: 200, height: 100)))
        label.backgroundColor = UIColor.brown
        label.textColor = UIColor.red
        self.view.addSubview(label)

        label.attributedText = FuWenBen()
        //自动换行
        label.numberOfLines = 0
    }
    func FuWenBen() -> NSMutableAttributedString {
         
        //定义富文本即有格式的字符串
        let attributedStrM : NSMutableAttributedString = NSMutableAttributedString()
         
        //        左上角星星
        let xingxing = NSAttributedString.init(string: "*", attributes: [NSAttributedString.Key.backgroundColor : UIColor.black , NSAttributedString.Key.foregroundColor : UIColor.red , NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20) ,NSAttributedString.Key.baselineOffset : (20)])
         
        let wo = NSAttributedString.init(string: "我", attributes: [NSAttributedString.Key.backgroundColor : UIColor.gray , NSAttributedString.Key.foregroundColor : UIColor.green , NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 30)])
         
        let shi : NSAttributedString = NSAttributedString(string: "是", attributes: [NSAttributedString.Key.foregroundColor  : UIColor.purple, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12)])
         
        //帅逼
        let shuaibi : NSAttributedString = NSAttributedString(string: "帅逼", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 38)])
         
        //图片
        let smileImage  = UIImage.init(named: "xxhui")
        let textAttachment : NSTextAttachment = NSTextAttachment()
        textAttachment.image = smileImage
        textAttachment.bounds = CGRect(x: 0, y: -4, width: 32, height: 32)
         
        attributedStrM.append(xingxing)
        attributedStrM.append(wo)
        attributedStrM.append(shi)
        attributedStrM.append(shuaibi)
        attributedStrM.append(NSAttributedString(attachment: textAttachment))
         
        return attributedStrM
    }
    
    //自适应
    func labelSizeOfText() -> Void {
        
        //需要显示在label上的文字
        let str = "收到回复asdfsajfdkl刷卡费；爱打架发；欧弟就发了算法减肥；阿里的就发；埃里克森方法阿发；发；浪费纪检委上"
        
        //计算显示指定文字所需要的最小空间
        //1.将swift的字符串转换成OC的字符串
        let ocStr = str as NSString
        
        //2.计算字符串的大小
        //参数1:限制显示当前字符串的最大宽度和最大高度
        //参数2:设置渲染方式(UsesLineFragmentOrigin)
        //参数3:确定文字的字体(大小)
        //NSFontAttributeName ->字体对应的key值
        //NSForegroundColorAttributeName -> 文字颜色对应的key值
        let strSize = ocStr.boundingRect(with: CGSize.init(width: 200, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 17)], context: nil).size
        
        print("strSize is : " + NSCoder.string(for: strSize))
        
        //3.创建label显示文字
        let label = UILabel.init(frame: CGRect.init(origin: CGPoint.init(x: 20, y: 20), size: strSize))
        label.backgroundColor = UIColor.black
        label.textColor = UIColor.red
        self.view.addSubview(label)
        label.text = str
        //自动换行
        label.numberOfLines = 0
    }
    private func customLabelUI(){
        let label = UILabel(frame:CGRect(x:20,y:140,width:200,height:40))
        label.backgroundColor=UIColor.cyan;
        label.text="你好UILabel"
        label.textColor=UIColor.red
        label.font = UIFont.init(name: "FZJKai-Z03S", size: 17)
        label.font=UIFont.systemFont(ofSize:20)
        label.textAlignment = .center
        label.numberOfLines = 0
        //阴影
        label.shadowColor=UIColor.gray
        label.shadowOffset=CGSize(width:1.5,height:1.5)
        //文字太多，省略lineBreakMode
        label.lineBreakMode = .byTruncatingTail//隐藏尾部并显示省略号
        label.lineBreakMode = .byTruncatingMiddle//隐藏中间部分并显示省略号
        label.lineBreakMode = .byTruncatingHead//隐藏头部并显示省略号
        label.lineBreakMode = .byClipping//截去多余部分也不显示省略号
        view.addSubview(label)
        
        //设置tag
        label.tag=1003
        //获取tag方法
        let getTagView = view.viewWithTag(1003) as! UILabel
        print("--->\(getTagView.text ?? "nil")")
        
        label.isUserInteractionEnabled = true
        let labeltap = UITapGestureRecognizer.init(target: self, action: #selector(labelTap))
        labeltap.numberOfTapsRequired = 2
        label.addGestureRecognizer(labeltap)
        
        let labeltaptwo = UITapGestureRecognizer.init(target: self, action: #selector(labelTapTwo(labelGesture:)))
        labeltaptwo.numberOfTapsRequired = 1
        label.addGestureRecognizer(labeltaptwo)
    }
    
    @objc func labelTap(){
        print("--->label tap")
    }
    @objc func labelTapTwo(labelGesture:UITapGestureRecognizer){
//        print("--->\(String(describing: labelGesture.numberOfTapsRequired))")
        print("--->label tap two")
    }
    
}
