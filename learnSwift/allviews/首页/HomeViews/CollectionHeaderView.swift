//
//  CollectionHeaderView.swift
//  learnSwift
//
//  Created by zyc on 2019/11/20.
//  Copyright © 2019 张言超. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {

    
    var txtlabel = UILabel()
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.txtlabel = UILabel.init(frame: CGRect(x:10, y: 10, width:self.frame.size.width-20, height:self.frame.size.height-20))
        self.txtlabel.backgroundColor = UIColor.white
        self.addSubview(txtlabel)
    }
    
}
