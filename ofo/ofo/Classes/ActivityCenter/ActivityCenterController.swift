//
//  ActivityCenterController.swift
//  ofo
//
//  Created by Liu Chuan on 2017/7/16.
//  Copyright © 2017年 LC. All rights reserved.
//

import UIKit
import WebKit

/// 活动中心
class ActivityCenterController: UIViewController {
    
    // MARK: - 懒加载
    
    /// 进度条
    private lazy var progressView: UIProgressView = {
        let progressView = UIProgressView(frame: CGRect(x: 0, y: navigationH + statusH, width: screenW, height: 4))
        progressView.tintColor = ofoWholeColor
        return progressView
    }()
    
    /// 网页
    private lazy var webView : WKWebView = {
        
        let url = URL(string: "http://m.ofo.so/active.html")

        let webView:WKWebView = WKWebView(frame: CGRect(x: 0, y: navigationH + statusH, width: screenW, height: screenH - navigationH - statusH))
        
        if #available(iOS 11.0, *) {
            webView.scrollView.contentInsetAdjustmentBehavior = .never
        }else {
            // 设置 webView 的顶部间距, 使得 webView 全屏而且,不被导航栏挡住
            webView.scrollView.contentInset = UIEdgeInsets(top: navigationH + statusH, left: 0, bottom: 0, right: 0)
        }
        
/*
         KVO:添加一个键值观察者{
         第一个参数observer: 观察者; 谁是观察者,谁就要实现 一个方法
         第二个参数forKeyPath: 需要观察对象的属性
         第三个参数options: 新值还是旧值
         第四个参数: 默认填 nil
         
         注意: 使用 KVO 和通知一样, 需要注销
         KVO 的使用: 用监听对象调用 addObserver: forKeyPath: options: context 方法
*/
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        webView.load(URLRequest(url: url!))
        return webView
    }()

    // 移除KVO
    deinit {
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
    }
    
    // MARK: - 视图生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
    }
    
    
    // MARK: 属性发生改变
    // 当监听对象的熟悉发生改变时, 调用 addObserver对象的 observeValue(forKeyPath keyPath: of object:  change: [NSKeyValueChangeKey : Any]?, context:
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        /** 计算进度条 */
        /// 新值
        let newValue = change?[NSKeyValueChangeKey.newKey] as? Float ?? 0.0
        progressView.progress = newValue
        progressView.isHidden = newValue >= 1.0
    }
}
// MARK: - 自定义方法
extension ActivityCenterController {
 
    /// 配置UI界面
    private func configUI() {
        addSubV()
        configNavigationBar()
    }
    
    /// 添加视图
    private func addSubV() {
        view.addSubview(webView)
        view.addSubview(progressView)
    }
    
    /// 配置导航栏
    private func configNavigationBar() {
        title = "活动中心"
    }
}
