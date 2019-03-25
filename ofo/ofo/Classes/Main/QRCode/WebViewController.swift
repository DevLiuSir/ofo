//
//  WebViewController.swift
//  ofo
//
//  Created by Liu Chuan on 2017/8/18.
//  Copyright © 2017年 LC. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    
    /// 网址
    public var url : String?
    
    /// 网页
    fileprivate lazy var webView: WKWebView = {
        let web = WKWebView(frame: self.view.bounds)
        web.navigationDelegate = self
        return web
    }()
    
    // MARK: - 视图的生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
    }
    

}

// MARK: - 配置UI
extension WebViewController {
    
    /// 配置UI界面
    fileprivate func configUI() {
        
        configWebView()
        configNavigationBar()
    }
    
    /// 配置网页视图
    private func configWebView() {
        let str = url! as String
        guard let path = URL(string: str) else { return }
        webView.load(URLRequest(url: path))
        view.addSubview(webView)
    }
    
    /// 配置导航栏
    private func configNavigationBar() {
        
        navigationController?.navigationBar.tintColor = UIColor.black
        
        // 修改导航栏文字颜色
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]

        // 用于消除左边空隙，要不然按钮顶不到最前面
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spacer.width = -10
        
        /// 修改“返回按钮”图标
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "backIndicator"), style: .plain, target: self, action: #selector(backToPrevious))
        
        navigationController?.navigationItem.leftBarButtonItems = [spacer, backButton]
    }
}


// MARK: - 事件监听
extension WebViewController {
    
    /// 返回按钮点击事件
    @objc func backToPrevious() {
         _ = navigationController?.popViewController(animated: true)
    }
}



// MARK: - WKNavigationDelegate
extension WebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.title = webView.title
    }
    
}
