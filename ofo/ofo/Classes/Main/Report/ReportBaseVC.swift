//
//  ReportBaseVC.swift
//  ofo
//
//  Created by Liu Chuan on 2017/8/18.
//  Copyright © 2017年 LC. All rights reserved.
//

import UIKit
import WebKit

class ReportBaseVC: UIViewController {
    
    // MARK: - 懒加载
    /// 进度条
    fileprivate lazy var progressView: UIProgressView = {
        let progressView = UIProgressView(frame: CGRect(x: 0, y: navigationH + statusH, width: screenW, height: 4))
        progressView.tintColor = ofoWholeColor
        return progressView
    }()
    
    /// 网页
    fileprivate lazy var webView : WKWebView = {
        
        let webView:WKWebView = WKWebView(frame: CGRect(x: 0, y: 0, width: screenW, height: screenH))
        /*
         KVO:添加一个键值观察者{
         第一个参数observer: 观察者; 谁是观察者,谁就要实现 一个方法
         第二个参数forKeyPath: 需要观察对象的属性
         第三个参数options: 新值还是旧值
         第四个参数: 默认填 nil
         */
        // 参数: addObserver: 监听的对象, 谁来监听  forKeyPath: 需要监听的属性
        // 注意: 使用 KVO 和通知一样, 需要注销
        // KVO 的使用: 用监听对象调用 addObserver: forKeyPath: options: context 方法
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        
        // 是否拖动效果
        webView.scrollView.bounces = true
        
        // 设置内边距底部，主要是为了让网页最后的内容不被底部的toolBar挡着
        //webView.scrollView.contentInset = UIEdgeInsets(top: navigationH + statusH, left: 0, bottom: 0, right: 0)
        
        // 让竖直方向的滚动条显示在正确的位置
        //webView.scrollView.scrollIndicatorInsets = webView.scrollView.contentInset
        
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        return webView
    }()

    // 移除KVO
    deinit {
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
    }
    
    // MARK: - 视图生命周期
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(webView)
        view.addSubview(progressView)
        // 取消顶部默认64
//        automaticallyAdjustsScrollViewInsets = false
//        title = "乱停车"
        
//        navigationController?.navigationBar.barStyle = .default
//        navigationController?.navigationBar.barTintColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
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
