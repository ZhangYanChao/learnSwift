//
//  YCViewController.swift
//  learnSwift
//
//  Created by zyc on 2019/12/5.
//  Copyright © 2019 张言超. All rights reserved.
//

import UIKit

class YCViewController: BaseViewController {
    
    let layerOne = ProgressOneLayer()
    let layerTwo = ProgressTwoLayer()
    let layerThree = ProgressThreeLayer()
    let layerFour =  ProgressFourLayer()
    let slider = UISlider (frame: CGRect.zero)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "CALayer"
//        customUItwo()
        xxUI()
    }
    
    func xxUI() -> Void {
        
        self.view.addSubview(self.slider)
        self.slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        self.view.layer.addSublayer(layerOne)
        self.layerOne.number = 0.0
        self.view.layer.addSublayer(layerTwo)
        self.layerTwo.number = 0.0
        self.view.layer.addSublayer(layerThree)
        self.layerThree.number = 0.0
        self.view.layer.addSublayer(layerFour)
        self.layerFour.number = 0.0
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.slider.frame = CGRect (x: 50, y: 70, width:self.view.frame.width-100, height: 30)
    
        let lWH : CGFloat = 100
    
        let horSpace = (self.view.frame.width - 2*lWH)/3
        self.layerOne.frame =  CGRect (x: horSpace, y: 110, width:lWH , height: lWH)
        self.layerTwo.frame =  CGRect (x: horSpace*2+lWH, y: 110, width:lWH , height: lWH)
        self.layerThree.frame =  CGRect (x: horSpace, y: 110+lWH+30, width:lWH , height: lWH)
        self.layerFour.frame =  CGRect (x: horSpace*2+lWH, y: 110+lWH+30, width:lWH , height: lWH)
        }
    @objc  func sliderValueChanged(){
        self.layerOne.number  = Double(self.slider.value)
        self.layerTwo.number  = Double(self.slider.value)
        self.layerThree.number  = Double(self.slider.value)
        self.layerFour.number  = Double(self.slider.value)
    }
    func customUI() -> Void {
        view.backgroundColor = UIColor.gray
          
        let v = UIView(frame: CGRect(x: 100, y: 100, width: 200, height: 200))
        v.backgroundColor = UIColor.black
        //CALayer边框
        v.layer.borderColor = UIColor.green.cgColor
        v.layer.borderWidth = 2
        view.addSubview(v)
        //CALayer阴影
        v.layer.shadowColor = UIColor.red.cgColor
        v.layer.shadowOffset = CGSize(width: 10, height: 10)
        v.layer.shadowOpacity = 0.45
        v.layer.shadowRadius = 5.0
        //CALayer圆角
        v.layer.masksToBounds = true//这个和阴影冲突
        v.layer.cornerRadius = 100
    }
    
    func customUItwo() -> Void {
        view.backgroundColor = UIColor.gray
          
        let v = UIView(frame: CGRect(x: 100, y: 100, width: 200, height: 200))
        v.backgroundColor = UIColor.black
        view.addSubview(v)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = v.bounds
         
        let fromColor = UIColor.green.cgColor
        let minColor = UIColor.red.cgColor
        let toColor = UIColor.blue.cgColor
         
        gradientLayer.colors = [fromColor,minColor,toColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.locations = [0,0.3,1]
        v.layer.addSublayer(gradientLayer)
    }

}

class ProgressLayer: CALayer {

        var number : Double = 0.0 {

             didSet{
                 self.tLayer.string = String (format : "%.2f", number*100 )
                 self.tLayer.setNeedsDisplay()
                 self.setNeedsDisplay()
             }
         }



         override func draw(in ctx: CGContext) {


         }


         //用于显示字符串的layer
         let tLayer : CATextLayer = {
            let l = CATextLayer ()
            let font = UIFont.systemFont(ofSize: 12)
            l.font = font.pointSize as CFTypeRef
            l.alignmentMode = CATextLayerAlignmentMode.center
            l.foregroundColor = UIColor.black.cgColor
            l.contentsScale = UIScreen.main.scale
            l.isWrapped = false
            l.string = ""
            return l
         }()

         override init() {
             super.init()
             self.addSublayer(tLayer)
         }

         override init(layer: Any) {

             super.init(layer: layer)
         }

         required init?(coder aDecoder: NSCoder) {
             fatalError("init(coder:) has not been implemented")
         }


         override func layoutSublayers() {

             super.layoutSublayers()


             //计算出字符串的高度
            let tH = NSString (string: "100%").boundingRect(with: CGSize(width: CGFloat.infinity, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 12) ], context: nil).height

             self.tLayer.frame = CGRect (x: 0, y: self.frame.height*0.5 - tH*0.5, width: self.frame.width, height: tH)
         }

}
 //

class ProgressOneLayer: ProgressLayer {
         ///定义画笔
     override func draw(in ctx: CGContext) {

         let radius =  self.frame.width * 0.45
         let center = CGPoint (x: self.frame.width*0.5, y: self.frame.height*0.5)

         ctx.setStrokeColor(UIColor.cyan.cgColor)

         ctx.setLineWidth(radius * 0.08)

         ctx.setLineCap(CGLineCap.round)

         let endAngle = CGFloat(self.number) * CGFloat.pi*2.0 - CGFloat.pi*0.5

             //zaddaArc 画原型
         ctx.addArc(center: center, radius: radius, startAngle: -0.5*CGFloat.pi, endAngle: endAngle, clockwise: false)

         ctx.strokePath()

     }

 }

class ProgressTwoLayer: ProgressLayer {

     override func draw(in ctx: CGContext) {

         let radius =  self.frame.width * 0.45
         let center = CGPoint (x: self.frame.width*0.5, y: self.frame.height*0.5)
         ctx.setFillColor(UIColor.yellow.cgColor)

         //画线
         ctx.move(to: center)
         ctx.addLine(to: CGPoint (x: center.x, y: self.frame.height*0.5))


         let endAngle =  CGFloat (self.number) * CGFloat.pi * 2.0 - CGFloat.pi*0.5


         ctx.addArc(center: center, radius: radius, startAngle: -0.5*CGFloat.pi, endAngle: endAngle, clockwise: false)

         ctx.closePath()
         ctx.fillPath()

     }
 }

class ProgressThreeLayer: ProgressLayer {

     override func draw(in ctx: CGContext) {

         let radius =  self.frame.width * 0.45
         let center = CGPoint (x: self.frame.width * 0.5, y: self.frame.height * 0.5)
         ctx.setFillColor(UIColor.orange.cgColor)
        ctx.setStrokeColor(UIColor.gray.withAlphaComponent(0.3).cgColor)
         ctx.setLineWidth(radius*0.06)
         ctx.addEllipse(in: CGRect(x: self.frame.width*0.05, y: self.frame.height*0.05, width: self.frame.width*0.9, height: self.frame.height*0.9))
         ctx.strokePath()

         let startAngle =  CGFloat.pi * 0.5 - CGFloat(self.number) * CGFloat.pi

         let endAngle = CGFloat.pi * 0.5 + CGFloat(self.number) * CGFloat.pi
         ctx.addArc(center: center, radius: radius, startAngle: startAngle, endAngle:endAngle , clockwise: false)
         ctx.closePath()
         ctx.fillPath()

     }

}

class ProgressFourLayer: ProgressLayer {
    ///定义画笔
    override func draw(in ctx: CGContext) {

        let radius =  self.frame.width * 0.45
        let center = CGPoint (x: self.frame.width*0.5, y: self.frame.height*0.5)

        //背景
        ctx.setStrokeColor(UIColor.gray.withAlphaComponent(0.8).cgColor)
        ctx.setLineWidth(radius*0.07)
        ctx.addEllipse(in: CGRect(x: self.frame.width*0.05, y: self.frame.height*0.05, width: self.frame.width*0.9, height: self.frame.height*0.9))
        ctx.strokePath()

        ctx.setStrokeColor(UIColor.red.cgColor)
        ctx.setLineWidth(radius * 0.08)
        ctx.setLineCap(CGLineCap.round)
        let endAngle = CGFloat(self.number) * CGFloat.pi*2.0 - CGFloat.pi*0.5
        //zaddaArc 画原型
        ctx.addArc(center: center, radius: radius, startAngle: -0.5*CGFloat.pi, endAngle: endAngle, clockwise: false)
        
        ctx.strokePath()

    }

}
