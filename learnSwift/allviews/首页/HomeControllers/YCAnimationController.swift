//
//  YCAnimationController.swift
//  learnSwift
//
//  Created by zyc on 2019/12/13.
//  Copyright © 2019 张言超. All rights reserved.
//

import UIKit

class YCAnimationController: BaseViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "YCAnimation"
        
        YCviewAnimation()
        YCImgviewAnimation()
        btnGraphicsAnimation()
        YCtransitionFlip()
    }
    var myview = UIView.init()
    func YCtransitionFlip() -> Void {
        myview = UIView.init(frame: CGRect(x: 20, y: 80, width: 80, height: 80))
        myview.backgroundColor = .green
        self.view.addSubview(myview)
        let btn = UIButton.init(type: .custom)
        btn.frame = CGRect(x: 220, y: 80, width: 60, height: 30)
        self.view.addSubview(btn)
        btn.backgroundColor = .brown
        btn.setTitle("翻转", for: .normal)
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
    }
    @objc func btnClick(){
        //位置移动
//        let animation:CABasicAnimation = CABasicAnimation()
//        animation.keyPath = "position"
//        let positionX:CGFloat = myview.frame.origin.x+0.5*myview.frame.size.width;
//        let positionY:CGFloat = myview.frame.origin.y+0.5*myview.frame.size.height+100;
//        animation.toValue = NSValue(cgPoint: CGPoint(x:positionX,y: positionY))
//        animation.byValue = NSValue(cgPoint:CGPoint(x:-20,y:100))
//        animation.duration = 1.0
//        animation.fillMode = CAMediaTimingFillMode.forwards
//        animation.isRemovedOnCompletion = false
//        myview.layer.add(animation, forKey: nil)
        
        //缩放 横着 宽度缩放百分比
//        let animation:CABasicAnimation = CABasicAnimation()
//        animation.keyPath = "transform.scale.x"
//        animation.fromValue = 1.0
//        animation.toValue = 0.2
//        animation.duration = 1.0
//        animation.fillMode = CAMediaTimingFillMode.forwards
//        animation.isRemovedOnCompletion = false
//        myview.layer.add(animation, forKey: nil)
        //旋转
//        let animation:CABasicAnimation = CABasicAnimation()
//        animation.keyPath = "transform.rotation.x"
//        animation.toValue = Double.pi * 1
//        animation.duration = 1.0
//        animation.fillMode = CAMediaTimingFillMode.forwards
//        animation.isRemovedOnCompletion = false
//        myview.layer.add(animation, forKey: nil)
        //圆角
//        let animation:CABasicAnimation = CABasicAnimation()
//        animation.keyPath = "cornerRadius"
//        animation.toValue = 40
//        animation.duration = 1.0
//        animation.fillMode = CAMediaTimingFillMode.forwards
//        animation.isRemovedOnCompletion = false
//        myview.layer.add(animation, forKey: nil)
        //边框
//        myview.layer.borderColor = UIColor.gray.cgColor
//        myview.layer.cornerRadius = 10.0
//        let animation:CABasicAnimation = CABasicAnimation()
//        animation.keyPath = "borderWidth"
//        animation.toValue = 10
//        animation.duration = 1.0
//        animation.fillMode = CAMediaTimingFillMode.forwards
//        animation.isRemovedOnCompletion = false
//        myview.layer.add(animation, forKey: nil)
        //颜色
//        let animation:CABasicAnimation = CABasicAnimation()
//        animation.keyPath = "backgroundColor"
//        animation.fromValue = UIColor.green.cgColor
//        animation.toValue = UIColor.red.cgColor
//        animation.duration = 2.0
//        animation.fillMode = CAMediaTimingFillMode.forwards
//        animation.isRemovedOnCompletion = false
//        myview.layer.add(animation, forKey: nil)
        //淡入
//        let animation:CABasicAnimation = CABasicAnimation()
//        animation.keyPath = "opacity"
//        animation.fromValue = UIColor.green.cgColor
//        animation.toValue = 1.0
//        animation.duration = 2.0
//        animation.fillMode = CAMediaTimingFillMode.forwards
//        animation.isRemovedOnCompletion = false
//        myview.layer.add(animation, forKey: nil)
        //阴影渐变
//        myview.layer.shadowColor = UIColor.red.cgColor
//        myview.layer.shadowOpacity = 0.5
//        //        loginButton?.layer.shadowPath = shadowPath.CGPath
//        let animation:CABasicAnimation = CABasicAnimation()
//        animation.keyPath = "shadowOffset"
//        animation.toValue = NSValue(cgSize: CGSize(width: 10, height: 10))
//        animation.duration = 2.0
//        animation.fillMode = CAMediaTimingFillMode.forwards
//        animation.isRemovedOnCompletion = false
//        myview.layer.add(animation, forKey: nil)
        
        //创建一个可变路径
        let circleKeyframePath = CGMutablePath()
    //创建用于转移坐标的Transform，这样我们不用按照实际显示做坐标计算，以这个坐标做基准点。坐标为下半个弧的中心点
        let circleKeyframeTransform:CGAffineTransform = CGAffineTransform(translationX: self.view.frame.size.width / 2, y: 260)
        //  顺时针为false
        circleKeyframePath.addArc(center: CGPoint(x: 0, y: 0), radius: 100, startAngle: CGFloat.pi , endAngle: 0, clockwise: true, transform: circleKeyframeTransform)
        //        circleKeyframePath.move(to: CGPoint(x: 100, y: 0), transform: circleKeyframeTransform)
        circleKeyframePath.addLine(to: CGPoint(x: 100, y: -100), transform: circleKeyframeTransform)
        circleKeyframePath.addLine(to: CGPoint(x: 50, y: -100), transform: circleKeyframeTransform)
        circleKeyframePath.addArc(center: CGPoint(x: 0, y: -100), radius: 50, startAngle: 0 , endAngle: CGFloat.pi, clockwise: true, transform: circleKeyframeTransform)
        circleKeyframePath.addLine(to: CGPoint(x: -100, y: -100), transform: circleKeyframeTransform)
        circleKeyframePath.addLine(to: CGPoint(x: -100, y: 0), transform: circleKeyframeTransform)
        let backgroundLayer:CAShapeLayer = CAShapeLayer()
        backgroundLayer.path = circleKeyframePath
        backgroundLayer.strokeColor = UIColor.blue.cgColor
        backgroundLayer.lineWidth = 3
        backgroundLayer.fillColor = UIColor.clear.cgColor
        //        backgroundLayer.backgroundColor = UIColor.red.cgColor
        self.view.layer.addSublayer(backgroundLayer)
                
        let circleView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let redCircleLayer:CAShapeLayer = CAShapeLayer()
        let redCirclePath:UIBezierPath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 20, height: 20))
        redCircleLayer.path = redCirclePath.cgPath
        redCircleLayer.fillColor = UIColor.red.cgColor
        circleView.layer.addSublayer(redCircleLayer)
        self.view.addSubview(circleView)
        //创建关键帧动画对象
        let circleKeyframeAnimation:CAKeyframeAnimation = CAKeyframeAnimation(keyPath: "position")
        circleKeyframeAnimation.path = circleKeyframePath
        circleKeyframeAnimation.duration = 5
        //让 Core Animation 向被驱动的对象施加一个恒定速度，不管路径的各个线段有多长。
        circleKeyframeAnimation.calculationMode = CAAnimationCalculationMode.paced
        circleKeyframeAnimation.repeatCount = HUGE
        //让它自身也做旋转，不过是圆的看不出效果
        circleKeyframeAnimation.rotationMode = CAAnimationRotationMode.rotateAutoReverse
        //print(circleView.layer.anchorPoint)
        circleView.layer.add(circleKeyframeAnimation, forKey: nil)
    }
    
    func YCImgviewAnimation() -> Void {
        let imgview = UIImageView.init(frame: CGRect(x: 20, y: 30, width: 30, height: 30))
        self.view .addSubview(imgview)
        let im = UIImage.animatedImageNamed("voice", duration: 2)
        imgview.image = im
    }
    var YCbtn = UIButton()
    func btnGraphicsAnimation() -> Void {
        YCbtn = UIButton.init(type: .custom)
        YCbtn.frame = CGRect(x: 70, y: 30, width: 60, height: 30)
        self.view.addSubview(YCbtn)
        YCbtn.backgroundColor = .brown
        YCbtn.setTitle("点我", for: .normal)
        YCbtn.addTarget(self, action: #selector(doAnimation3), for: .touchUpInside)
    }
    @objc func doAnimation3(){
      var arr = [UIImage]()
      let w : CGFloat = 18
      for i in 0 ..< 6 {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: w, height: w), false, 0)
        let context = UIGraphicsGetCurrentContext()!
        context.setFillColor(UIColor.red.cgColor)
        let ii = CGFloat(i)
        let rect = CGRect(x: ii, y:ii, width: w-ii*2, height: w-ii*2)
        context.addEllipse(in: rect)
        context.fillPath()
        let im = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        arr.append(im)
      }
      let im = UIImage.animatedImage(with: arr, duration: 0.5)
      YCbtn.setImage(im, for: .normal)
    }
    /**
     UIView 无疑是最简单的一种，但是所有的动画归根结底还是 layer 层的动画。UIView 层面的动画只是对 layer 层部分属性的封装。我们可以直接对 UIView 的 alpha 、bounds 、center 、frame、transform、backgroundColor(如果view没有实现draw(_:))。上面这些属性看起来不多，但是足够满足大部分日常开发动画。
     */
    
    func YCviewAnimation() -> Void {
        let kProgressBarHeight: CGFloat = 38
        let kProgressBarWidth: CGFloat = 150
        let frame = CGRect(x: (UIScreen.main.bounds.width - kProgressBarWidth) / 2, y: (UIScreen.main.bounds.height - kProgressBarHeight) / 2, width: kProgressBarWidth, height: kProgressBarHeight)
        let progressBar = SWProgressBarView.init(frame: frame)
        self.view.addSubview(progressBar)
        progressBar.backgroundColor = UIColor.cyan
        progressBar.layer.cornerRadius = progressBar.bounds.height / 2
    }
    
    
    /**
     核心动画继承自CAAnimation包括:
     CAPropertyAnimation（属性动画）
     CAAnimationGroup（组动画）和CATransition（转场动画）
     
     CAPropertyAnimation包括:
     CAKeyframeAnimation（帧动画）和CABasicAnimation;
      
     CABasicAnimation又包含CASpringAnimation
     */
}

class MyView: UIView {
    var reverse = false
    override func draw(_ rect: CGRect) {
      let f = self.bounds.insetBy(dx: 10, dy: 10)
      let context = UIGraphicsGetCurrentContext()
      if self.reverse {
        context?.strokeEllipse(in: f)
      }else{
        context?.stroke(f)
      }
    }
}
