////////////////////////////////////////////////////////////////////
//                          _ooOoo_                               //
//                         o8888888o                              //
//                         88" . "88                              //
//                         (| ^_^ |)                              //
//                         O\  =  /O                              //
//                      ____/`---'\____                           //
//                    .'  \\|     |//  `.                         //
//                   /  \\|||  :  |||//  \                        //
//                  /  _||||| -:- |||||-  \                       //
//                  |   | \\\  -  /// |   |                       //
//                  | \_|  ''\---/''  |   |                       //
//                  \  .-\__  `-`  ___/-. /                       //
//                ___`. .'  /--.--\  `. . ___                     //
//              ."" '<  `.__\_<|>_/__.'  >'"".                    //
//            | | :  `- \`.;`\ _ /`;.`/ - ` : | |                 //
//            \  \ `-.   \_ __\ /__ _/   .-` /  /                 //
//      ========`-.____`-.___\_____/___.-`____.-'========         //
//                           `=---='                              //
//      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        //
//         佛祖保佑            永无BUG              永不修改          //
////////////////////////////////////////////////////////////////////
//  AppDelegate.swift
//  learnSwift
//
//  Created by zyc on 2019/11/20.
//  Copyright © 2019 张言超. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        customRootController()
        
        addNotification()
        
        return true
    }
    // MARK: rootViewController
    private func customRootController(){
        window = UIWindow(frame: ScreenBounds)
        window!.makeKeyAndVisible()
        let isFristOpen = UserDefaults.standard.object(forKey: "isFristOpenApp")
        if isFristOpen == nil {
            window?.rootViewController = GuideViewController()
            UserDefaults.standard.set("yes", forKey: "isFristOpenApp")
            UserDefaults.standard.synchronize()
        }else{
            window?.rootViewController = YCTabBarController()
        }
    }

    func addNotification() {
        NotificationCenter.default.addObserver(self, selector:#selector(changeRootVC), name: NSNotification.Name(rawValue: GuideViewControllerDidFinish), object: nil)
    }
    
    @objc func changeRootVC(){
        window?.rootViewController = nil
        window?.rootViewController = YCTabBarController()
        window!.makeKeyAndVisible()
    }

}

