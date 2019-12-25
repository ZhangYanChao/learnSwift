//
//  HomeController.swift
//  learnSwift
//
//  Created by zyc on 2019/11/20.
//  Copyright © 2019 张言超. All rights reserved.
//

import UIKit

class HomeController: BaseViewController,UITableViewDataSource,UITableViewDelegate {
    
    weak var mytableview:UITableView?;
    var modelArr:NSArray = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        self.navigationItem.title = "控件ALL"
        customUI()
        getHomedata()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.backgroundColor = UIColor.white
    }
    
    private func customUI(){
        
        /**
         label.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];//加粗
         label.font = [UIFont fontWithName:@"Helvetica-Oblique" size:20];//加斜
         label.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:20];//又粗又斜
         UIFont.boldSystemFont(ofSize: 16)//加粗
         */
        
        //nav右侧按钮
        let rightBtn = UIButton.init(type: .custom)
        rightBtn.setTitle("我的简书", for: .normal)
        rightBtn.setTitleColor(.black, for: .normal)
        rightBtn.backgroundColor = .clear
        rightBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
//        rightBtn.titleLabel?.font = UIFont.init(name: "Helvetica-Bold", size: 16)
        rightBtn.addTarget(self, action: #selector(turnMyJianShu), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightBtn)
        
        let tableview = UITableView(frame: CGRect.zero, style: UITableView.Style.plain)
        tableview.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - 64)
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "HomeTableViewCell")
        mytableview = tableview
        tableview.backgroundColor = UIColor.white
        tableview.delegate = self
        tableview.dataSource = self
        //去掉没有数据显示部分多余的分隔线
        tableview.tableFooterView =  UIView.init(frame: CGRect.zero)
        //将分隔线offset设为零，即将分割线拉满屏幕
        tableview.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        //设置分隔线颜色
        tableview.separatorColor = CellDivisionColor
        view.addSubview(tableview)
    }
    
    @objc func turnMyJianShu(){
        print("简书")
        self.navigationController?.pushViewController(YCJianShuController(), animated: true)
    }
    
    private func getHomedata(){
        
        let plistPath:String = Bundle.main.path(forResource: "homeData", ofType:"plist")!
        let dataArr:NSArray = NSArray(contentsOfFile:plistPath)!
        modelArr = dataArr
//        print(modelArr)
        mytableview?.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath)
        let txt:String = modelArr[indexPath.row] as! String
        cell.textLabel?.text = "-->\(txt)"
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let txtstr:String = modelArr[indexPath.row] as! String
        var vc = UIViewController()
        if txtstr == "UIImageView" {
            vc = UIimageViewViewController()//
        }else if txtstr == "UILabel"{
            if #available(iOS 11.0, *) {
                vc = UILabelViewController()
            } else {
                // Fallback on earlier versions
            }
        }else if txtstr == "UIButton"{
            vc = UIButtonController()
        }else if txtstr == "UIScrollView"{
            vc = UIScrollViewController()
        }else if txtstr == "UITableView"{
            vc = UITableViewController()
        }else if txtstr == "UICollectionView"{
            vc = UICollectionViewController()
        }else if txtstr == "WKWebView"{
            vc = UIWebController()
        }else if txtstr == "UIView"{
            vc = YCViewController()
        }else if txtstr == "UITextField"{
            vc = UITextViewController()
        }else if txtstr == "YCTextView"{
            vc = YCTextViewController()
        }else if txtstr == "UIAlert"{
            vc = YCAlert()
        }else if txtstr == "Animation"{
            vc = YCAnimationController()
        }else if txtstr == "UIPickerView"{
            vc = UIPickerViewController()
        }else if txtstr == "UISearchBar"{
            vc = UISearchBarController()
        }
        

        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
