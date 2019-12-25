//
//  YCTableViewCell.swift
//  learnSwift
//
//  Created by zyc on 2019/11/20.
//  Copyright © 2019 张言超. All rights reserved.
//

import UIKit

class YCTableViewCell: UITableViewCell {

    
    @IBOutlet weak var iconImgView: UIImageView!
    
    @IBOutlet weak var banknameLB: UILabel!
    
    @IBOutlet weak var bankMoneyLB: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
