//
//  YCTabBarController.swift
//  learnSwift
//
//  Created by zyc on 2019/11/20.
//  Copyright © 2019 张言超. All rights reserved.
//

import UIKit

class YCTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        customTabBarChildController()
        
    }
    
    
    private func customTabBarChildController(){
        let homevc = HomeController()
        tabBarControllerAddChildViewController(childView: homevc, title: "首页", imageName: "tabhome", selectedImageName: "tabhome_r", tag: 0)
        let shopcartvc = ShopCartController()
        tabBarControllerAddChildViewController(childView: shopcartvc, title: "活动", imageName: "taborder", selectedImageName: "taborder_r", tag: 1)
        let ordervc = OrderController()
        tabBarControllerAddChildViewController(childView: ordervc, title: "购物车", imageName: "tabshopCart", selectedImageName: "tabshopCart_r", tag: 2)
        let myvc = MyController()
        tabBarControllerAddChildViewController(childView: myvc, title: "我的", imageName: "tabmy", selectedImageName: "tabmy_r", tag: 3)
    }
    
    private func tabBarControllerAddChildViewController(childView: UIViewController, title: String, imageName: String, selectedImageName: String, tag: Int){
        let vcItem = customTabbarItem(title: title, image: imageName, selectedImage: selectedImageName)
        vcItem.tag = tag;
        childView.tabBarItem = vcItem
        childView.tabBarController?.tabBar.backgroundColor = UIColor.white
        let nav = BaseNavigationController(rootViewController: childView)
        addChild(nav)
    }
    
    private func customTabbarItem(title: String, image: String, selectedImage: String) -> UITabBarItem{
        let item = UITabBarItem()
        item.title = title
        item.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.colorWithCustom(r: 249, g: 206, b: 58)], for: UIControl.State.normal)
        item.image = UIImage(named: image)
        item.selectedImage = UIImage(named: selectedImage)?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        
        return item
    }

}
