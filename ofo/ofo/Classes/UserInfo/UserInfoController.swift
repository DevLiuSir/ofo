//
//  UserInfoController.swift
//  ofo
//
//  Created by Liu Chuan on 2017/7/23.
//  Copyright © 2017年 LC. All rights reserved.
//

import UIKit

/// 个人信息控制器
class UserInfoController: UITableViewController, UIGestureRecognizerDelegate {
    
    
    /// 头像按钮
    var avatarButton: UIButton!
    
    
    /*** 表格要展示的数据源 ***/
    
    
    /// 分组title
    let sectionTitle = [[],["昵称", "性别", "生日", "ofo身份"], ["手机号", "微信", "QQ"], ["校园认证"]]
    
    
    var sectionValue = [[]]
    
    
    /// 头像按钮点击事件(设置头像)
    ///
    /// - Parameter sender: UIButton
    @IBAction func btnAvatarTapped(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        /// 拍照
        let takePhotoAction = UIAlertAction(title: "拍照", style: .default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let picker = UIImagePickerController()
                picker.delegate = self
                picker.sourceType = .camera
                picker.allowsEditing = true
                self.present(picker, animated: true, completion: nil)
            } else {
//                self.noticeError("找不到相机", autoClear: true, autoClearTime: 1)
            }
        }
        
        /// 相册选择
        let selectFromAblumAction = UIAlertAction(title: "从相册选择", style: .default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let picker = UIImagePickerController()
                picker.delegate = self
                picker.sourceType = .photoLibrary
                picker.allowsEditing = true
                self.present(picker, animated: true, completion: nil)
            } else {
//                self.noticeError("读取相册错误", autoClear: true, autoClearTime: 1)
            }
        }
        
        /// 取消
        let cancelAction = UIAlertAction(title: "取消", style: .cancel) { (default) in
            print("取消")
        }
        
        alertController.addAction(takePhotoAction)
        alertController.addAction(selectFromAblumAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - 试图生命周期
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }

}

// MARK: - 配置UI
extension UserInfoController {
    
    /// 配置UI界面
    private func configUI() {
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

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension UserInfoController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //头像选择照片成功后回调
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
// Local variable inserted by Swift 4.2 migrator.
let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

       
        let image = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.editedImage)] as! UIImage
        avatarButton.setImage(image, for: .normal)
        saveAvatarToSandbox(image: image, quality: 1)
        picker.dismiss(animated: true, completion: nil)
    }
    
    /// 将新头像保存到手机本地
    ///
    /// - Parameters:
    ///   - image: 要保存的图像
    ///   - quality: 图像质量（0.0 ~ 1.0）
    ///   - imageName: 文件名，需要后缀。 eg: "avatar.jpg"
    private func saveAvatarToSandbox(image: UIImage, quality: CGFloat) {
        
        if let imageData = image.jpegData(compressionQuality: quality) as NSData? {
//            let path = UserModel.shared.getAvatarPath()
//            imageData.write(toFile: path, atomically: true)
            
            
            print("将新头像保存到手机本地......")
            
        }
        
    }
    
}





// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
}
