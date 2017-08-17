//
//  AboutVC.swift
//  ofo
//
//  Created by Liu Chuan on 2017/8/9.
//  Copyright © 2017年 LC. All rights reserved.
//

import UIKit

class AboutVC: UIViewController {

    /// 滚动视图
    @IBOutlet weak var scrollView: UIScrollView!
    
    /// 版本号
    @IBOutlet weak var versionLabel: UILabel!

    /// 点击箭头按钮事件，滚到底部
    ///
    /// - Parameter sender: 按钮
    @IBAction func btnScrollToBottomTapped(_ sender: UIButton) {
        
        /// 偏移量
        let offset = CGPoint(x: 0, y: scrollView.contentSize.height - view.frame.height)
        scrollView.setContentOffset(offset, animated: true)
    }

    // MARK: - 试图生命周期
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    /// 视图即将可见时, 加载
    ///
    /// - Parameter animated: 是否动画
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configUI()
    }
}

// MARK: - 配置UI
extension AboutVC {
    
    /// 配置UI界面
    fileprivate func configUI() {
        //给Lable加边框
        versionLabel.layer.cornerRadius = 9
        versionLabel.layer.borderColor = UIColor.lightGray.cgColor
        versionLabel.layer.borderWidth = 1
    }
}
