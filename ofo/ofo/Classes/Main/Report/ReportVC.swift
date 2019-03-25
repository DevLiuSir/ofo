//
//  ReportVC.swift
//  ofo
//
//  Created by Liu Chuan on 2017/8/1.
//  Copyright © 2017年 LC. All rights reserved.
//

import UIKit
import WebKit

/// 乱停车URL
private let disorderParkUrl = URL(string: "https://common.ofo.so//about/prosecute/illegalparking.html")

/// 没车用URL
private let NobikeUrl = URL(string: "https://common.ofo.so//about/prosecute/nocar.html")

/// 车损坏URL
private let BrokenUrl = URL(string: "https://common.ofo.so//about/prosecute/damged.html")

/// 上私锁URL
private let LockedUrl = URL(string: "https://common.ofo.so//about/prosecute/privatelocked.html")

/// 举报控制器
class ReportVC: UIViewController {

    /// stackView数组
    @IBOutlet var stackViews: [UIStackView]!
    
    // MARK: - 按钮点击事件
    /// 关闭按钮点击
    ///
    /// - Parameter sender: 按钮
    @IBAction func btnCloseTapped(_ sender: UIButton) {
        dismissSelf()
    }
    
    /// 乱停车按钮点击
    ///
    /// - Parameter sender: 按钮
    @IBAction func btnParkTapped(_ sender: UIButton) {
        
        let reportBaseVC = ReportBaseVC()
        
        let web = reportBaseVC.view.subviews[0] as! WKWebView
        
        web.load(URLRequest(url: disorderParkUrl!))
 
        /// 获取呈现导航控制器
        let nav = presentingViewController as? MyNavigationController
        
        // 关闭视图控制器时, 同时执行{}内代码
        self.dismiss(animated: false) {
            nav?.pushViewController(reportBaseVC, animated: true)
        }
    }

    /// 没车用按钮点击
    ///
    /// - Parameter sender: 按钮
    @IBAction func btnNobikeTapped(_ sender: UIButton) {
        
        let reportBaseVC = ReportBaseVC()
        
        let web = reportBaseVC.view.subviews[0] as! WKWebView
        
        web.load(URLRequest(url: NobikeUrl!))
        
        /// 获取呈现导航控制器
        let nav = presentingViewController as? MyNavigationController
        
        // 关闭视图控制器时, 同时执行{}内代码
        self.dismiss(animated: false) {
            nav?.pushViewController(reportBaseVC, animated: true)
        }
    }
    
    /// 车损坏按钮点击
    ///
    /// - Parameter sender: 按钮
    @IBAction func btnBrokenTapped(_ sender: UIButton) {
        
        let reportBaseVC = ReportBaseVC()
        
        let web = reportBaseVC.view.subviews[0] as! WKWebView
        
        web.load(URLRequest(url: BrokenUrl!))
        
        /// 获取呈现导航控制器
        let nav = presentingViewController as? MyNavigationController
        
        // 关闭视图控制器时, 同时执行{}内代码
        self.dismiss(animated: false) {
            nav?.pushViewController(reportBaseVC, animated: true)
        }
    }
    
    /// 上私锁按钮点击
    ///
    /// - Parameter sender: 按钮
    @IBAction func btnLockedTapped(_ sender: UIButton) {
        
        let reportBaseVC = ReportBaseVC()
        
        let web = reportBaseVC.view.subviews[0] as! WKWebView
        
        web.load(URLRequest(url: LockedUrl!))
        
        /// 获取呈现导航控制器
        let nav = presentingViewController as? MyNavigationController
        
        // 关闭视图控制器时, 同时执行{}内代码
        self.dismiss(animated: false) {
            nav?.pushViewController(reportBaseVC, animated: true)
        }
    }

    // MARK: - 视图的生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 创建单击手势, 并添加
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissSelf))
        self.view.addGestureRecognizer(tapGesture)

        // 遍历stackView数组
        for stackView in stackViews {
            stackView.transform = CGAffineTransform(scaleX: 0, y: 0)
        }
    }
    /// 对象的视图已经加入到窗口时,调用
    ///
    /// - Parameter animated: 是否动画
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showButtonWithAnimation()
    }
    
    /// 视图即将可见时,调用
    ///
    /// - Parameter animated: 是否动画
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    /// 视图即将消失时,调用
    ///
    /// - Parameter animated: 是否动画
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

// MARK: - 事件监听
extension ReportVC {
    
    /// 动画显示按钮
    private func showButtonWithAnimation() {
        
        for (index, stackView) in stackViews.enumerated() {
            UIView.animate(withDuration: 0.1, delay: 0.1 * Double(index), options: [], animations: {
                stackView.transform = .identity
            }, completion: nil)
        }
    }
    
    //移除当前控制器
    @objc private func dismissSelf() {
        UIView.animate(withDuration: 0.2, animations: {
            self.view.alpha = 0
        }) { (finished) in
            self.dismiss(animated: false, completion: nil)
        }
    }
}
