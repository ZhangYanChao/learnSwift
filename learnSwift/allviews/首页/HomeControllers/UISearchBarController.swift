//
//  UISearchBarController.swift
//  learnSwift
//
//  Created by zyc on 2019/12/15.
//  Copyright © 2019 张言超. All rights reserved.
//

import UIKit

class UISearchBarController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        customUI()
        self.navigationItem.title = "UISearchBar"
    }
    
    func customUI(){
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 30, width: kScreenWidth, height: 50))
        searchBar.showsCancelButton = false  // 取消按钮是否显示
        searchBar.delegate = self
        // 设置光标及取消按钮的颜色
        searchBar.tintColor = UIColor.init(red: 0.12, green: 0.74, blue: 0.13, alpha: 1)
        self.view.addSubview(searchBar)
        
        //定义控件x:30 y:100 width:80 height:40
        let switcher = UISwitch(frame: CGRect(x: 30, y: 100, width: 120, height: 40))
        self.view.addSubview(switcher)
        //设置开启状态显示的颜色
        switcher.onTintColor = UIColor.red
        //设置关闭状态的颜色
        switcher.tintColor = UIColor.blue
        //滑块上小圆点的颜色
        switcher.thumbTintColor = UIColor.yellow
        //添加状态变化监听器
        switcher.addTarget(self, action: #selector(switchDidChange(_:)), for: .valueChanged)
        
        //创建Slider
        let slider = UISlider(frame: CGRect(x: 20, y: 250, width: kScreenWidth - 40, height: 50))
        //最小值
        slider.minimumValue = 0
        //最大值
        slider.maximumValue = 1
        //设置默认值
        slider.value = 0.1
        //设置Slider值，并有动画效果
        slider.setValue(0.5, animated: true)
        //设置Slider两边槽的颜色
        slider.minimumTrackTintColor = UIColor.red
        slider.maximumTrackTintColor = UIColor.green
        //添加两边槽图片
        slider.minimumValueImage = UIImage(named: "image")
        slider.maximumValueImage = UIImage(named: "image1")
        //设置Slider组件图片
        slider.setMaximumTrackImage(UIImage(named:"Maximage1"), for: .normal)
        slider.setMinimumTrackImage(UIImage(named:"MinImage2"), for: .normal)
        slider.setThumbImage(UIImage(named: "thumInage"), for: .normal)
        //使用三宫格缩放
        let image = UIImage(named: "image3")?.stretchableImage(withLeftCapWidth: 14, topCapHeight: 0)//左右像素为14px，中间缩放
        slider.setMaximumTrackImage(image, for: .normal)
        //Slider值改变响应
        slider.isContinuous = false//设置在停止滑动时才出发响应事件
        slider.addTarget(self, action: #selector(SliderChanged(_:)), for: .valueChanged)
        //添加到视图中
        self.view.addSubview(slider)
    }
    
    @objc func SliderChanged(_ slider:UISlider)
    {
        print(slider.value)
    }
    
    @objc
    func switchDidChange(_ sender: UISwitch){
          //打印当前值
          print(sender.isOn)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension UISearchBarController:UISearchBarDelegate{
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            print("cancel")
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            print("搜索")
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("开始")
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("xxx---\(String(describing: searchBar.text))")
    }
}
