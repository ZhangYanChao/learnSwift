//
//  GuideViewController.swift
//  learnSwift
//
//  Created by zyc on 2019/12/5.
//  Copyright © 2019 张言超. All rights reserved.
//

import UIKit

class GuideViewController: BaseViewController {

    private var collectionView: UICollectionView?
    private var imageNames = ["guide_40_1", "guide_40_2", "guide_40_3", "guide_40_4"]
    private let cellIdentifier = "GuideCell"
    private var isHiddenNextButton = true
    private var pageController = UIPageControl(frame:CGRect(x: 0, y: kScreenHeight - 50, width: kScreenWidth, height: 20))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.setStatusBarHidden(false, with: UIStatusBarAnimation.none)
        buildCollectionView()
        
        buildPageController()
    }
    
    // MARK: - Build UI
    private func buildCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = ScreenBounds.size
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        
        collectionView = UICollectionView(frame: ScreenBounds, collectionViewLayout: layout)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.isPagingEnabled = true
        collectionView?.bounces = false
        collectionView?.register(GuideCell.self, forCellWithReuseIdentifier: cellIdentifier)
        view.addSubview(collectionView!)
    }
    
    private func buildPageController() {
        pageController.numberOfPages = imageNames.count
        pageController.currentPage = 0
        view.addSubview(pageController)
    }

}
extension GuideViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for:indexPath as IndexPath) as! GuideCell
        cell.newImage = UIImage(named: imageNames[indexPath.row])
        if indexPath.row != imageNames.count - 1 {
            cell.setNextButtonHidden(hidden: true)
        }else{
            cell.setNextButtonHidden(hidden: false)
        }
        return cell
    }
    
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return imageNames.count
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageController.currentPage = Int(scrollView.contentOffset.x / kScreenWidth + 0.5)
    }
}
