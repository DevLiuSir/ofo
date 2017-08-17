//
//  MyNavigationController.swift
//  ofo
//
//  Created by Liu Chuan on 2017/8/9.
//  Copyright © 2017年 LC. All rights reserved.
//

import UIKit

class MyNavigationController: UINavigationController {
    
    
    // MARK: - 视图生命周期
    override func viewDidLoad() {
        super.viewDidLoad()

        configNavigationBar()
    }

    
    /// 重写push方法, 让所有push的动作都会调用此方法
    ///
    /// - Parameters:
    ///   - viewController: 控制器
    ///   - animated: 是否动画
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        // 如果push进来的不是第一个控制器
        if self.childViewControllers.count > 0 {
            
            // 用于消除左边空隙，要不然按钮顶不到最前面
            let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
            spacer.width = -10
            
            /// 修改“返回按钮”图标
            let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "backIndicator"), style: .plain, target: self, action: #selector(backToPrevious))
            
            viewController.navigationItem.leftBarButtonItems = [spacer, backButton]
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    
    
}

// MARK: - 配置UI
extension MyNavigationController {
    
    /// 配置导航栏
    fileprivate func configNavigationBar() {
        navigationBar.tintColor = navigationBarTint
        self.interactivePopGestureRecognizer!.delegate = self   //启用滑动返回（swipe back）
    }
    
}


// MARK: - 事件监听
extension MyNavigationController {
    
    /// 返回按钮点击事件
    func backToPrevious() {
        self.popViewController(animated: true)
    }
}

// MARK: - UIGestureRecognizerDelegate 协议
extension MyNavigationController: UIGestureRecognizerDelegate {
    
    //修复返回手势失效的问题
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if gestureRecognizer == self.interactivePopGestureRecognizer {
            return self.viewControllers.count > 1
        }
        return true
    }
}

