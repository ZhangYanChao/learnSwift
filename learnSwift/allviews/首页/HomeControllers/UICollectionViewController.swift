//
//  UICollectionViewController.swift
//  learnSwift
//
//  Created by zyc on 2019/11/20.
//  Copyright © 2019 张言超. All rights reserved.
//

import UIKit

class UICollectionViewController: BaseViewController,UICollectionViewDataSource, UICollectionViewDelegate{

    var myCollectionview:UICollectionView?
    override func viewDidLoad() {
        super.viewDidLoad()

        customUI()
    }
    
    private func customUI(){
        self.navigationItem.title = "UICollectionView练习"
        
        // 初始化
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.minimumLineSpacing = 5;
        layout.minimumInteritemSpacing = 5;
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
        // 设置分区头视图和尾视图宽高
        layout.headerReferenceSize = CGSize.init(width: kScreenWidth, height: 80)
        layout.footerReferenceSize = CGSize.init(width: kScreenWidth, height: 80)

        myCollectionview = UICollectionView.init(frame: CGRect(x:0, y:0, width:kScreenWidth, height:500), collectionViewLayout: layout)
        myCollectionview?.backgroundColor = UIColor.white
        myCollectionview?.delegate = self
        myCollectionview?.dataSource = self
        self.view.addSubview(myCollectionview!)
        
        // 注册cell
        myCollectionview?.register(UINib.init(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeCollectionViewCell")
        // 注册headerView
        myCollectionview?.register(CollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CollectionHeaderView")
        // 注册footView
        myCollectionview?.register(CollectionFootView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "CollectionFootView")
        
    }
    
    //header高度
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
          return CGSize.init(width: kScreenWidth, height: 80)
      }
      //footer高度
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
          return CGSize.init(width: kScreenWidth, height: 80)
      }

      //设定header和footer的方法，根据kind不同进行不同的判断即可
      func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader{
            let headerView : CollectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CollectionHeaderView", for: indexPath) as! CollectionHeaderView
            headerView.backgroundColor = UIColor.red
            headerView.txtlabel.text = "This is HeaderView"
            return headerView
          }else{
            let footView : CollectionFootView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "CollectionFootView", for: indexPath) as! CollectionFootView
              footView.backgroundColor = UIColor.purple
              footView.txtlabel.text = "This is Foot"
              return footView
          }
      }
      
      func numberOfSections(in collectionView: UICollectionView) -> Int {
          return 1
      }

      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          return 18
      }

      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let cell:HomeCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
            cell.backgroundColor = UIColor.randomColor()
          cell.txtLB.text = String(format:"%d",indexPath.row)
          return cell
      }

      func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
      }
      override func didReceiveMemoryWarning() {
          super.didReceiveMemoryWarning()
          // Dispose of any resources that can be recreated.
      }

}
