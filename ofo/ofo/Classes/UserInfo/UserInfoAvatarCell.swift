//
//  UserInfoAvatarCell.swift
//  ofo
//
//  Created by Liu Chuan on 2017/8/8.
//  Copyright © 2017年 LC. All rights reserved.
//

import UIKit

/// 用户信息头像单元格
class UserInfoAvatarCell: UITableViewCell {
    
    // MARK: - 控件属性
    /// 手机号
    @IBOutlet weak var mobileNumberLabel: UILabel!
    
    /// 信用评分按钮
    @IBOutlet weak var creditScoreBtn: UIButton!
    
    /// 头像按钮
    @IBOutlet weak var avatarBtn: UIButton!

    // MARK: - 加载nib,调用
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 禁止选中
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
