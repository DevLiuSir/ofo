//
//  QRCodeController.swift
//  ofo
//
//  Created by Liu Chuan on 2017/7/16.
//  Copyright © 2017年 LC. All rights reserved.
//

import UIKit

class QRCodeController: UIViewController {

    // MARK: - 控件属性
    
    /// 冲击波视图顶部约束
    @IBOutlet weak var scanLineTopConstranit: NSLayoutConstraint!
    
    /// 容器视图高度约束
    @IBOutlet weak var containerHeightConstraint: NSLayoutConstraint!
    
    /// 冲击波视图
    @IBOutlet weak var scanLineView: UIImageView!
    
    
    
    
    // MARK: - 系统函数
    override func viewDidLoad() {
        super.viewDidLoad()
        

        configUI()
    }
    

    /// 视图即将消失时,加载
    ///
    /// - Parameter animated: 是否动画
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        scanAnimation()
    }
    
    
    
    /// 冲击波动画 (即: 改变冲击波的顶部约束 - 增大)
    private func scanAnimation() {
/*
        // 设置动画初始约束 (让约束从顶部开始)
        self.scanLineTopConstranit.constant = -self.containerHeightConstraint.constant
        
        // 强制更新视图布局
        self.view.layoutIfNeeded()
*/
        UIView.animate(withDuration: 3.0) {
            // 1.修改约束
            self.scanLineTopConstranit.constant = self.containerHeightConstraint.constant
            
            // 1.1设置动画重复次数
            UIView.setAnimationRepeatCount(MAXFLOAT)
            
            // 2.强制更新视图布局
            self.view.layoutIfNeeded()
        }
    }
    
    
}

// MARK: - 配置UI
extension QRCodeController {
    
    /// 配置UI界面
    fileprivate func configUI() {
        
        configNavigationBar()
    }
    
    /// 配置导航栏
    private func configNavigationBar() {
        
        // 导航栏按钮颜色
        navigationController?.navigationBar.tintColor = UIColor.white
        
        // 左边的item
        let imageView = UIImageView(image: UIImage(named: "yellowBikeWhiteTitle"))
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: imageView)
        
        // 右边的item
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "whiteClose"), style: .plain, target: self, action: #selector(close))
        
        // 取消导航栏底部的阴影线
        let image = UIImage()
        navigationController?.navigationBar.setBackgroundImage(image, for: .default)
        navigationController?.navigationBar.shadowImage = image
        
        
    }
}

// MARK: - 事件监听
extension QRCodeController {
    
    /// 关闭按钮事件
    @objc fileprivate func close() {
        dismiss(animated: true, completion: nil)
    }
    
}






