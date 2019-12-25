//
//  UITableViewController.swift
//  learnSwift
//
//  Created by zyc on 2019/11/20.
//  Copyright © 2019 张言超. All rights reserved.
//

import UIKit

class UITableViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate {

    weak var mytableview:UITableView?;
    var modelArr:NSArray = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "我的存款"
        customUI()
        getbankdata()
    }
    private func getbankdata(){
        let viewmodel = bankModel()
        modelArr = viewmodel.getBankData()
        mytableview?.reloadData()
    }
    private func customUI(){
        let tableview = UITableView(frame: CGRect.zero, style: UITableView.Style.plain)
        tableview.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
        tableview.register(UINib.init(nibName: "YCTableViewCell", bundle: nil), forCellReuseIdentifier: "YCTableViewCell")
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelArr.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YCTableViewCell", for: indexPath) as! YCTableViewCell
        let model = modelArr[indexPath.row] as! bankModel
        cell.iconImgView.image = UIImage(named: model.bankImg)
        cell.banknameLB.text = model.bankName
        cell.bankMoneyLB.text = "存款￥\(model.bankMoney)元"
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}


