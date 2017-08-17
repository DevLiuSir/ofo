//
//  UserInfoDetailCell.swift
//  ofo
//
//  Created by Liu Chuan on 2017/8/8.
//  Copyright © 2017年 LC. All rights reserved.
//

import UIKit

/// 用户信息详情单元格
class UserInfoDetailCell: UITableViewCell {
    
    // MARK: - 控件属性
    
    /// 名称标签
    @IBOutlet weak var titleLabel: UILabel!
    
    /// 值标签
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
