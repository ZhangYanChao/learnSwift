//
//  BaseNavigationController.swift
//  learnSwift
//
//  Created by zyc on 2019/11/20.
//  Copyright © 2019 张言超. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationBar.setBackgroundImage(imageWithColor(color: UIColor.red), for: UIBarMetrics.default)
        self.navigationBar.setBackgroundImage(UIImage(named: "nav_bg"), for: UIBarMetrics.default)
    }
    
    private func imageWithColor(color:UIColor) -> UIImage{
        let rect=CGRect(x: 0, y: 0, width: 1, height: 1);
        UIGraphicsBeginImageContext(rect.size);
        let context:CGContext = UIGraphicsGetCurrentContext()!;
        context.setFillColor(color.cgColor);
        context.fill(rect);
        let theImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!;
        UIGraphicsEndImageContext();
        return theImage;
    }
    
    lazy var backBtn:UIButton = {
        let backBtn = UIButton(type: UIButton.ButtonType.custom)
        backBtn.setImage(UIImage(named: "goback"), for: UIControl.State.normal)
        backBtn.titleLabel?.isHidden = true
        backBtn.addTarget(self, action:#selector(backBtnClick), for: UIControl.Event.touchUpInside)
        backBtn.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        backBtn.contentEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 0)
        let btnW: CGFloat = kScreenWidth > 375.0 ? 50 : 44
        backBtn.frame = CGRect(x: 0, y: 0, width: btnW, height: 40)
        return backBtn
    }()
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.navigationItem.hidesBackButton = true
        if children.count > 0 {

            UINavigationBar.appearance().backItem?.hidesBackButton = false

            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
            
            viewController.hidesBottomBarWhenPushed = true
        }
        
        super.pushViewController(viewController, animated: animated)
    }
    @objc public func backBtnClick(){
        popViewController(animated: true)
    }
}
