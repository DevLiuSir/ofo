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
    

    
    // MARK: - 系统回调函数
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

//        // 隐藏返回按钮
//        navigationItem.hidesBackButton = true
//        navigationItem.backBarButtonItem?.title = ""

//        /// 新的返回按钮
//        let newBakcButton = UIBarButtonItem(image: UIImage(named: "backIndicator"), style: .plain, target: self, action: #selector(back))
//        
//        navigationItem.leftBarButtonItem = newBakcButton
//        
        //启用滑动返回（swipe back）
        navigationController?.interactivePopGestureRecognizer!.delegate = self

        // 修改导航栏按钮颜色
//        navigationController?.navigationBar.tintColor = UIColor.gray
        
//        // 隐藏返回按钮上的文字
//        navigationItem.backBarButtonItem?.setBackButtonTitlePositionAdjustment(UIOffset(horizontal: 0, vertical: -60), for: .default)
//        
//        navigationItem.backBarButtonItem?.image = UIImage(named: "backIndicator")
        
        
        
        /*self.navigationItem.hidesBackButton = true
         let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: "back:")
         self.navigationItem.leftBarButtonItem = newBackButton;
         }
         
         func back(sender: UIBarButtonItem) {
         // Perform your custom actions
         // ...
         // Go back to the previous ViewController
         self.navigationController?.popViewControllerAnimated(true)
         
*/
        
        
        
        
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
    
    
//    /// 返回按钮事件
//    @objc fileprivate func back() {
//        self.navigationController?.popViewController(animated: true)
//    }
//    
//    
//      
    
}
