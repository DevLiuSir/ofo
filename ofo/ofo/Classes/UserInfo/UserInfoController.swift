//
//  UserInfoController.swift
//  ofo
//
//  Created by Liu Chuan on 2017/7/23.
//  Copyright © 2017年 LC. All rights reserved.
//

import UIKit

class UserInfoController: UITableViewController, UIGestureRecognizerDelegate {
    
    //表格要展示的数据源
    let sectionTitle = [[],["昵称", "性别", "生日", "ofo身份"], ["手机号", "微信", "QQ"], ["校园认证"]]
    var sectionValue = [[]]
    
    // MARK: - 试图生命周期
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }

}

// MARK: - 配置UI
extension UserInfoController {
    
    /// 配置UI界面
    fileprivate func configUI() {
        configNavigationBar()
    }
    
    /// 配置导航栏
    private func configNavigationBar() {
        
        navigationController?.navigationBar.tintColor = navigationBarTint
        
        let barButton = UIBarButtonItem(image: #imageLiteral(resourceName: "barButtonSetting"), style: .plain, target: self, action: #selector(settingBarButtonTapped))
        navigationItem.rightBarButtonItem = barButton
    }
}

// MARK: - 事件监听
extension UserInfoController {
    
    /// 设置按钮点击事件
    @objc fileprivate func settingBarButtonTapped() {
        // 弹出设置界面
        self.performSegue(withIdentifier: "ShowSettingViewSegue", sender: nil)
    }
    
    /// 返回按钮事件
    @objc fileprivate func backToPrevious() {
        _ = navigationController?.popViewController(animated: true)
    }

}

// MARK: - UITableViewDataSource
extension UserInfoController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        switch section {
        case 0:
            return 1
        case 1...3:
            return sectionTitle[section].count
        default:
            return 0
        }

    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserInfoAvatarCell") as! UserInfoAvatarCell
//            cell.mobileNumberLabel.text = "\(sectionValue[1][0])"
//            cell.creditScoreBtn.setTitle("信用分 \(sectionValue[indexPath.section][0]) >", for: .normal)
            
//            if let avatarImage = UIImage(contentsOfFile: UserModel.shared.getAvatarPath()) {
//                cell.avatarBtn.setImage(avatarImage, for: .normal)
//            }
//            avatarBtn = cell.avatarBtn
            
            
            return cell
        case 1...3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserInfoDetailCell") as! UserInfoDetailCell
//            cell.titleLabel.text = sectionTitle[indexPath.section][indexPath.row]
//            cell.valueLabel.text = "\(sectionValue[indexPath.section][indexPath.row])"
            return cell
        default:
            let cell = UITableViewCell()
            return cell
        
        }
    }
        
        
        
        
}







