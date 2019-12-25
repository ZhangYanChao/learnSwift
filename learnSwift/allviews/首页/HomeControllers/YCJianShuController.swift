//
//  YCJianShuController.swift
//  learnSwift
//
//  Created by zyc on 2019/12/16.
//  Copyright © 2019 张言超. All rights reserved.
//

import UIKit

class YCJianShuController: BaseViewController,UICollectionViewDelegate,UICollectionViewDataSource{
    
    var collectionView: UICollectionView!
    var headerView: HomeHeadView?
    var footerView: HomeFootView?
    // 是否正在加载数据标记
    var loading = false
    // 瀑布流布局
    var flowLayout: HomeFlowLayout!
    //顶部菊花
    private var topIndicator: UIActivityIndicatorView?
    // 列数
    var columnCount:Int = 2;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "我的简书"
        customUI()
        dataRefresh()
    }
    
    func customUI(){
        self.flowLayout = HomeFlowLayout()
        let rect: CGRect = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: kScreenWidth, height: kScreenHeight - 0 - (IsFullScreen ? 34 : 0)))
        self.collectionView = UICollectionView.init(frame: rect, collectionViewLayout:self.flowLayout)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.backgroundColor = .white
        self.view.addSubview(self.collectionView)
        //注册xib
        self.collectionView.register(UINib.init(nibName: "HomeCell", bundle: nil), forCellWithReuseIdentifier: "HomeCell")
        self.collectionView.register(UINib.init(nibName: "HomeFootView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "HomeFootView")
        self.collectionView.register(UINib.init(nibName: "HomeHeadView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HomeHeadView")
        
        //顶部加载“菊花”
        self.topIndicator = UIActivityIndicatorView.init(frame: CGRect(x: (kScreenWidth - 50) / 2.0, y: 90, width: 50, height: 50))
        self.topIndicator?.color = .red
        self.view.addSubview(self.topIndicator!)
        
        self.setHomeFlowLayouts()
        
    }
    
    //MARK: - --- 设置item的布局
    func setHomeFlowLayouts(){
        //通过layout的一些参数设置item的宽度
        let inset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let minLine:CGFloat = 10.0
        self.itemWidth = (kScreenWidth - inset.left - inset.right - minLine * (CGFloat(self.columnCount - 1))) / CGFloat(self.columnCount)
        
        //设置布局属性
        self.flowLayout.columnCount = self.columnCount
        self.flowLayout.sectionInset = inset
        self.flowLayout.minimumLineSpacing = minLine
    }
    
    var index:Int = 1
    var itemWidth:CGFloat = 0
    //头部信息
    var headInfo:Yuanzu?
    //数据源数组
    var xdataArr = [JianShuModel]()
    
    func dataRefresh(){
        if self.headInfo != nil {
            if self.index > self.headInfo!.totalPage{
                print("没有更多数据了")
                self.topIndicator?.stopAnimating()
                self.loading = false
                return;
            }
        }
        //网络请求回调
        JianShuRequestModel.jianshuRequestDataWithPage(index, Float(itemWidth), { (headInfo) in
            self.headInfo = headInfo
            self.flowLayout.headerH = headInfo.headerH
            print(headInfo)
        }, { (xdataArr) in
            self.topIndicator?.stopAnimating()
            
            if self.index == 1 {
                self.xdataArr.removeAll()
            }
            self.xdataArr.append(contentsOf: xdataArr)
            print("pageIndex: \(self.index)")
            self.index += 1
            
            //layout布局
            self.flowLayout.findList = self.xdataArr
            //self.collectionView.collectionViewLayout = self.flowLayout
            //刷新视图
            self.collectionView?.reloadData()
        })
    }
    
    //MARK: - --- delegate，dataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.xdataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:HomeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as! HomeCell
        let  model = self.xdataArr[indexPath.row]
        cell.setModel(model)
        if self.headInfo != nil {
            cell.setHeadInfo(self.headInfo!)
        }
        return cell
    }
    
    //MARK: - --- 点击事件
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell:HomeCell = collectionView.cellForItem(at: indexPath) as! HomeCell
        let model = self.self.xdataArr[indexPath.row]
        
        print("{\n第\(indexPath.row)个item\ntitle: \(cell.titleLb.text!)\nabstract: \(model.abstract!)\narticleUrl: https://www.jianshu.com\(model.articleUrl!)\n}")
        
        let webVC = YCJianShuDetailController()
        webVC.aticleID = model.articleUrl!
        self.navigationController?.pushViewController(webVC, animated: true)
    }
    
    //MARK: - --- HeaderView  FooterView
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var reusableView: UICollectionReusableView?
        if kind == UICollectionView.elementKindSectionFooter {
            self.footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HomeFootView", for: indexPath) as? HomeFootView
            reusableView = self.footerView
            return self.footerView!
        }else if kind == UICollectionView.elementKindSectionHeader {
            self.headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HomeHeadView", for: indexPath) as? HomeHeadView
            reusableView = self.headerView
            self.headerView?.setHearderInfo(self.headInfo!)
            //点击切换布局
            self.headerView?.switchBack = { (click) in
                print(click)
                self.columnCount = (click == true) ? 1 : 2
                self.setHomeFlowLayouts()
                //遍历数组 重新计算高度
                var num = 0
                for model in self.xdataArr {
                    //计算标题和摘要的高度
                    model.imgW = Float(self.itemWidth - 16)
                    model.imgH = model.wrap!.count > 0 ? model.imgW! * 120 / 150 : nil
                    model.titleH = GETSTRHEIGHT(fontSize: 20, width: CGFloat(model.imgW!) , words: model.title!) + 1
                    model.abstractH = GETSTRHEIGHT(fontSize: 14, width: CGFloat(model.imgW!) , words: model.abstract!) + 1
                    
                    //item高度
                    var computeH:CGFloat = 8 + 25 + 3 + 10 + 8 + (model.imgH != nil ? CGFloat(model.imgH!) : 0) + 8 + model.titleH! + 8 + model.abstractH! + 8 + 10 + 8
                    //如果没有图片减去一个间隙8
                    computeH = computeH - (model.wrap!.count > 0 ? 0 : 8)
                    model.itemHeight = String(format: "%.f", computeH)
                    self.xdataArr[num] = model;
                    num += 1
                }
                self.flowLayout.findList = self.xdataArr
                self.collectionView?.reloadData()
            }
            return self.headerView!
        }
        return reusableView!
    }
    
    //MARK: - --- scrollViewDelegate 监听scrollView.contentOffset.y，用以刷新数据
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.y < -120.0 {
            if self.loading == true {
                return;
            }
            self.topIndicator?.startAnimating()
            self.loading = true
            self.collectionView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(1 * NSEC_PER_SEC)) / Double(NSEC_PER_SEC), execute: {
                
                UIView.animate(withDuration: 0.3, animations: {
                    self.collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                }, completion: { (finished) in
                    self.topIndicator?.stopAnimating()
                    self.loading = false
                })
                self.index = 1
                self.dataRefresh()
                
            })
        }
        
        if self.footerView == nil || self.loading == true {
            return
        }
        
        if self.footerView!.frame.origin.y < (scrollView.contentOffset.y + scrollView.bounds.size.height) {
            NSLog("开始刷新");
            self.loading = true
            self.footerView?.indicator.startAnimating()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(1 * NSEC_PER_SEC)) / Double(NSEC_PER_SEC), execute: {
                self.footerView = nil
                self.dataRefresh()
                self.loading = false
            })
        }
        
    }
    
    //MARK: - --- 监听手指停止滑动
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        //print(decelerate)
        if scrollView.contentOffset.y < -120.0 {
            self.topIndicator?.startAnimating()
            self.collectionView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        }
        
        if scrollView.contentOffset.y > -120 &&  scrollView.contentOffset.y < -88{
            UIView.animate(withDuration: 0.3, animations: {
                self.collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                self.collectionView.contentOffset.y = -88;
            }, completion: { (finished) in
                
            })
            self.topIndicator?.stopAnimating()
            self.loading = false
        }
        
    }
    //控制最顶部StatusBar
    override var prefersStatusBarHidden : Bool {
        return false
    }
}
