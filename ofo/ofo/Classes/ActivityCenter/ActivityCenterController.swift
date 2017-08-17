//
//  ActivityCenterController.swift
//  ofo
//
//  Created by Liu Chuan on 2017/7/16.
//  Copyright © 2017年 LC. All rights reserved.
//

import UIKit

class ActivityCenterController: UIViewController, UIGestureRecognizerDelegate {
    
    // MARK: - 控件属性
    @IBOutlet weak var webView: UIWebView!
    

    
    // MARK: - 视图生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
    }
    

}
// MARK: - 配置UI
extension ActivityCenterController {
 
    /// 配置UI界面
    fileprivate func configUI() {
        
        configWebView()
        configNavigationBar()
    }
    
    /// 配置导航栏
    private func configNavigationBar() {
        
        title = "活动中心"
        
//        //修改“返回按钮”图标
//        let leftBarBtn = UIBarButtonItem(title: " ", style: .plain, target: self, action: #selector(backToPrevious))
//        leftBarBtn.image =  UIImage(named: "backIndicator")
//        
//        //用于消除左边空隙，要不然按钮顶不到最前面
//        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
//        spacer.width = -10
//        navigationItem.leftBarButtonItems = [spacer, leftBarBtn]
//       
//        //启用滑动返回（swipe back）
//        navigationController?.interactivePopGestureRecognizer!.delegate = self
    }
    
    /// 配置网页视图
    private func configWebView() {
        
        // 取消顶部默认64
        automaticallyAdjustsScrollViewInsets = false
        let url = URL(string: "http://m.ofo.so/active.html")
        let request = URLRequest(url: url!)
        webView.loadRequest(request)
    }
}


// MARK: - 事件监听
extension ActivityCenterController {
    
//    
//    /// 返回按钮事件
//    @objc fileprivate func backToPrevious() {
//        _ = navigationController?.popViewController(animated: true)
//    }
//    
    
      
    
}
