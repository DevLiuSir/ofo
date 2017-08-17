//
//  CustomMenuTabelCell.swift
//  ofo
//
//  Created by Liu Chuan on 2017/7/31.
//  Copyright © 2017年 LC. All rights reserved.
//

import UIKit

/// 自定义cell
class CustomMenuTabelCell: UITableViewCell {
    
    // MARK: - 控件属性
    
    /// 头像
    @IBOutlet weak var iconImageView: UIImageView!
    
    /// 标题
    @IBOutlet weak var titleLabel: UILabel!
    
    /// 小红点视图
    @IBOutlet weak var redpointView: UIView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
