//
//  UIPickerViewController.swift
//  learnSwift
//
//  Created by zyc on 2019/12/15.
//  Copyright © 2019 张言超. All rights reserved.
//

import UIKit

class UIPickerViewController: BaseViewController, UIPickerViewDelegate, UIPickerViewDataSource{

    var label: UILabel!
    var pickerView: UIPickerView!
    
    var pickerData:[String: [String]] = ["放假":["写代码","玩游戏","泡妹子"],"旅游":["马尔代夫","火星","迪拜","月球"],"上班":["加班","不加班"]] //保存全部数据
    var pickerProvincesData: [String] = ["放假","旅游","上班"] //第一级数据
    var pickerCitiesData: [String] = ["写代码","玩游戏","泡妹子"]//第二级数据
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "UIPickerView"
        // 创建视图
        let screen = UIScreen.main.bounds
        // 设置 根视图背景色
        self.view.backgroundColor = UIColor.white
        
        // 选择器
        let pickerViewWidth:CGFloat = kScreenWidth
        let pickerViewHeight:CGFloat = 162
        self.pickerView = UIPickerView(frame: CGRect(x:0, y: 0,width: pickerViewWidth, height: pickerViewHeight))
        //因为该Controller中实现了UIPickerViewDataSource接口所以将dataSource设置成自己
        self.pickerView.dataSource = self
        //将delegate设置成自己
        self.pickerView.delegate = self
        self.view.addSubview(self.pickerView)
        
        
        
        // 添加标签
        let labelwidth:CGFloat = 200
        let labelheight:CGFloat = 21
        let labelTopView:CGFloat = 281
        self.label = UILabel(frame: CGRect(x:(screen.size.width - labelwidth)/2, y: labelTopView, width: labelwidth, height: labelheight))
        self.label.text = "Label"
        // 字体左右居中
        self.label.textAlignment = .center
        self.view.addSubview(self.label)
        
        
        // button 按钮
        let button = UIButton(type: .system)
        button.setTitle("Button", for: UIControl.State.normal)
        let buttonwidth:CGFloat = 46
        let buttonheight:CGFloat = 30
        let buttonTopView:CGFloat = 379
        button.frame = CGRect(x: (screen.size.width - buttonwidth)/2, y: buttonTopView, width: buttonwidth, height: buttonheight)
        //事件
        button.addTarget(self, action: #selector(onclick(_:)), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    //设置选择框的总列数,继承于UIPickViewDataSource协议
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    //设置选择框的总行数,继承于UIPickViewDataSource协议
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //总行数设置为数据源的总长度。component :为0 表示第一列，1 表示第二列
        //根据不同的数据源设置不同的个数
        if(component == 0){
            return self.pickerProvincesData.count
        }else{
            return self.pickerCitiesData.count
        }
    }
    //设置选项框各选项的内容,继承于UIPickViewDelegate协议
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        if(component == 0){ //选择第一级数据
            return self.pickerProvincesData[row]
        }
        else{//选择第二级数据
            return self.pickerCitiesData[row]
        }
    }
    //选择控件的事件选择
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(component == 0){
            //记录用户选择的值
            let selectedProvince = self.pickerProvincesData[row] as String
            // 根据第一列选择的值，获取第二列数据
            self.pickerCitiesData = self.pickerData[selectedProvince]!
            //刷新第二列的数据源
            self.pickerView.reloadComponent(1)
            //刷新数据源后将第二组数据转到下标为0,并且开启动画效果
            self.pickerView.selectRow(0, inComponent: 1, animated: true)
        }
    }
    //设置每行选项的高度
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 45.0
    }
    // 获取值
    @objc func onclick(_ sender: AnyObject) {
        //获得2列选取值的下标
        let row1 = self.pickerView.selectedRow(inComponent: 0)
        let row2 = self.pickerView.selectedRow(inComponent: 1)
        //根据下标获取值
        let selected1 = self.pickerProvincesData[row1] as String
        let selected2 = self.pickerCitiesData[row2] as String
        //拼接值
        let title = String(format: "%@, %@", selected1, selected2)
        self.label.text = title
    }
}
