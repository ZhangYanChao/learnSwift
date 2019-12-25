//
//  UIimageViewViewController.swift
//  learnSwift
//
//  Created by zyc on 2019/11/20.
//  Copyright © 2019 张言超. All rights reserved.
//

import UIKit

class UIimageViewViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "UIImageView"
        customUI()
    }
    
    let imgview10 = UIImageView.init()
    let startUpimageView = UIImageView.init()
    private func customUI(){
        
        //加载1
        
        let label1 = UILabel(frame: CGRect(x: 20, y: 30, width: 260, height: 20))
        label1.text = "加载Assets.xcassets中图片"
        label1.font = UIFont.systemFont(ofSize: 12)
        self.view.addSubview(label1)
        
        let imgview1 = UIImageView(frame: CGRect(x: 20, y: 70, width: 50, height: 50))
        imgview1.image = UIImage(named: "weixin")
        self.view .addSubview(imgview1)
        
        let imgview2 = UIImageView(image: UIImage(named: "zhifubao"))
        imgview2.frame = CGRect(x: 100, y: 70, width: 50, height: 50)
        self.view .addSubview(imgview2)
        
        //加载2
        let label2 = UILabel(frame: CGRect(x: kScreenWidth-130, y: 30, width: 100, height: 20))
        label2.text = "加载目录中的图片"
        label2.textAlignment = NSTextAlignment.center
        label2.font = UIFont.systemFont(ofSize: 12)
        self.view.addSubview(label2)
        
        let imgpath:String = Bundle.main.path(forResource: "pullRefresh1@2x", ofType: "png")!
        let imgview3 = UIImageView(frame: CGRect(x: kScreenWidth-150, y: 70, width: 50, height: 50))
        imgview3.image = UIImage(contentsOfFile:imgpath)
        self.view.addSubview(imgview3)

        let imgpath2:String = Bundle.main.path(forResource: "pullRefresh2@2x", ofType: "png")!
        let imgview4 = UIImageView(frame: CGRect(x: kScreenWidth-70, y: 70, width: 50, height: 50))
        imgview4.image = UIImage(contentsOfFile:imgpath2)
        self.view.addSubview(imgview4)
        
        
        //ContentMode
        //qiu.png 明显不是正方形，
        let imgview5 = UIImageView(image: UIImage(named: "qiu"))
        imgview5.backgroundColor = UIColor.red
        imgview5.frame = CGRect(x: 20, y: 140, width: 80, height: 80)
        //scaleAspectFit 在保持长宽比的前提下，缩放图片，使得图片在容器内完整显示出来。
        imgview5.contentMode = UIView.ContentMode.scaleAspectFit
        self.view.addSubview(imgview5)
        
        let imgview6 = UIImageView(image: UIImage(named: "qiu"))
        imgview6.backgroundColor = UIColor.red
        imgview6.frame = CGRect(x: 120, y: 140, width: 80, height: 80)
        //scaleToFill 缩放图片,使图片充满容器。图片未必保持长宽比例协调，有可能会拉伸至变形。
        imgview6.contentMode = UIView.ContentMode.scaleToFill
        self.view.addSubview(imgview6)
        
        let imgview7 = UIImageView(image: UIImage(named: "qiu"))
        imgview7.backgroundColor = UIColor.red
        imgview7.frame = CGRect(x: 220, y: 140, width: 80, height: 80)
        //scaleAspectFill 在保持长宽比的前提下，缩放图片，使图片充满容器。
        //scaleAspectFit 和 scaleAspectFill都是保证图片的g宽高比不变，
        //但是scaleAspectFit以高计算出宽，scaleAspectFill以宽计算出高
        imgview7.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.addSubview(imgview7)
        
        //
        let imgview8 = UIImageView(image: UIImage(named: "qiu"))
        imgview8.backgroundColor = UIColor.red
        imgview8.frame = CGRect(x: 20, y: 240, width: 80, height: 80)
        //redraw与scaleToFill效果一样
        /*
         redraw          根据尺寸从新绘制图片
         //以下几种模式基本不常用
         center          内容保持相同大小。定位调整。
         top             内容保持相同大小，图片位置与顶部，并居中
         bottom          内容保持相同大小，图片位置与底部，并居中
         left            内容保持相同大小，图片位置与左中部
         right           内容保持相同大小，图片位置与右中部
         topLeft         内容保持相同大小，图片位置与左上部
         topRight        内容保持相同大小，图片位置与右上部
         bottomLeft      内容保持相同大小，图片位置与左下部
         bottomRight     内容保持相同大小，图片位置与右下部
        */
        imgview8.contentMode = UIView.ContentMode.redraw
        self.view.addSubview(imgview8)
        
        //layer操作，添加手势事件，
        let imgview9 = UIImageView(image: UIImage(named: "qiu"))
        imgview9.backgroundColor = UIColor.red
        imgview9.frame = CGRect(x: 120, y: 240, width: 80, height: 80)
        //scaleAspectFit 在保持长宽比的前提下，缩放图片，使得图片在容器内完整显示出来。
        imgview9.contentMode = UIView.ContentMode.scaleAspectFill
        //剪切 超出视图frame的渲染
        imgview9.clipsToBounds = true
        self.view.addSubview(imgview9)
        //layer常用操作
        imgview9.layer.masksToBounds = true
        imgview9.layer.cornerRadius = 5
        imgview9.layer.borderColor = UIColor.red.cgColor
        imgview9.layer.borderWidth = 1
        //手势添加
        //打开交互
        imgview9.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapClick))
        imgview9.addGestureRecognizer(tap)
        
        
        imgview10.frame = CGRect(x: 220, y: 240, width: 80, height: 80)
        //加载一组图片，最终做出gif的效果
        let image1 = UIImage(named: "run1.png")
        let image2 = UIImage(named: "run2.png")
        let image3 = UIImage(named: "run3.png")
        let image4 = UIImage(named: "run4.png")
        let image5 = UIImage(named: "run5.png")
        let ImageArray:Array = [image1,image2,image3,image4,image5]
        imgview10.image = image1
        imgview10.animationImages = ImageArray as? [UIImage]
        //开始动画
        imgview10.startAnimating()
        //动画时间
        imgview10.animationDuration = 1
        /*
         动画执行的次数
         0:无限循环
         n:代表执行多少次
         */
        imgview10.animationRepeatCount = 5
        //判断动画是否执行
        let isAnimation = imgview10.isAnimating
        if isAnimation {
            print("动画执行...")
        }else{
            print("动画未执行...")
        }
        self.view.addSubview(imgview10)
        
        
        startUpimageView.frame = CGRect(x: 150, y: 330, width: 200, height: 200)
        startUpimageView.ht_startGifWithImageName(name: "good")
        self.view.addSubview(startUpimageView)
        
        //加载网络图片
        //定义URL对象
        let url = URL(string: "http://img.zcool.cn/community/0114e05d0320c8a801205e4bbd9a5b.jpg@260w_195h_1c_1e_1o_100sh.jpg")
        //从网络获取数据流
        let data = try! Data(contentsOf: url!)
        //通过数据流初始化图片
        let newImage = UIImage(data: data)
        imgview10.image = newImage
        
        //自适应图片
        let imgview11 = UIImageView.init()
        imgview11.backgroundColor = UIColor.red
        imgview11.frame = imgview11.setFrame(frame: CGRect(x: 20, y: 330, width: 80, height: 80), image: UIImage(named: "qiu")!)
        imgview11.image = UIImage(named: "qiu")
        self.view.addSubview(imgview11)
        
    }
    
    @objc func tapClick(){
        print("111--imgview--tap")
        if startUpimageView.isAnimating {
            startUpimageView.ht_imageStopAnimating()
        }else{
            startUpimageView.startAnimating()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        imgview10.startAnimating()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super .viewWillDisappear(animated)
        //结束动画
        imgview10.stopAnimating()
    }
    
}
//MARK -- 自适应图片大小
extension UIImageView{
    public func setFrame(frame: CGRect, image: UIImage) -> CGRect{
     
        // 判断图片的尺寸是不是小于imageView的尺寸
        // 如果图片的尺寸小于imageView的尺寸，将图片的尺寸做为imageView的尺寸
        // 如果图片的尺寸大于imageView的尺寸：
        // 1、 图片宽与高的比例 scale = width / height
        // 2、 对比图片宽与高的大小，判断是宽大于高，还是高大于宽;
        // 3、 如果宽大于高，则需要设置imageView的高，根据图片宽高比scale求imageView得高;
        //    如果高大于宽，则需要设置imageView的宽，根据图片宽高比scale求imageView的宽;
        // 注： imageView.contentMode = .scaleAspectFit
    
        var _frame: CGRect = CGRect()
        
        if image.size.width < frame.size.width && image.size.height < frame.size.height {
            
            _frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: image.size.width, height: image.size.height)
            
        } else if image.size.width > frame.size.width && image.size.height > frame.size.height{
    
            // 图片宽与高的比例
            let scaleWH: CGFloat = image.size.width / image.size.height
    
            // 对比图片宽与高的大小， 宽>高
            if image.size.width > image.size.height {
    
                // 根据图片宽高比scale求imageView得高
                let imageViewHeight: CGFloat = frame.size.width / scaleWH
                // 设置frame
                _frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: imageViewHeight)
    
            }else if image.size.width < image.size.height {
    
                let imageViewWidth: CGFloat = frame.size.height * scaleWH
                _frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: imageViewWidth, height: frame.size.width)
            }
        }
        return _frame
    }

}

extension UIImageView {
    
    //MARK:工程内gif
    public func ht_startGifWithImageName(name:String) {
        guard let path = Bundle.main.path(forResource: name, ofType: "gif") else {
            print("SwiftGif: Source for the image does not exist")
            return
        }
        self.ht_startGifWithFilePath(filePath: path)
    }
    
    //MARK:实现动图效果
    public func ht_startGifWithFilePath(filePath:String) {
        //1.加载GIF图片，并转化为data类型
        guard let data = NSData(contentsOfFile: filePath) else {return}
        //2.从data中读取数据，转换为CGImageSource
        guard let imageSource = CGImageSourceCreateWithData(data, nil) else {return}
        let imageCount = CGImageSourceGetCount(imageSource)
        //3.遍历所有图片
        var images = [UIImage]()
        var totalDuration : TimeInterval = 0
        for i in 0..<imageCount {
            //3.1取出图片
            guard let cgImage = CGImageSourceCreateImageAtIndex(imageSource, i, nil) else {continue}
            let image = UIImage(cgImage: cgImage)
            images.append(image)
            
            //3.2取出持续时间
            guard let properties = CGImageSourceCopyPropertiesAtIndex(imageSource, i, nil) as? NSDictionary  else {continue}
            guard let gifDict = properties[kCGImagePropertyGIFDictionary]  as? NSDictionary else  {continue}
            guard let frameDuration = gifDict[kCGImagePropertyGIFDelayTime] as? NSNumber else {continue}
            totalDuration += frameDuration.doubleValue
            
        }
        
        //4.设置imageview的属性
        self.animationImages = images
        self.animationDuration = totalDuration
        self.animationRepeatCount = 0
        //5.开始播放
        self.startAnimating()
        
    }
    
    public func ht_imageStopAnimating() {
        self.stopAnimating()
    }
}
