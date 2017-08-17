//
//  ReportVC.swift
//  ofo
//
//  Created by Liu Chuan on 2017/8/1.
//  Copyright © 2017年 LC. All rights reserved.
//

import UIKit


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
        
//        let nav = presentingViewController as? UINavigationController
//        self.dismiss(animated: false) {
//            nav?.performSegue(withIdentifier: "ShowReportBaseSegue", sender: nil)
//        }
    }

    /// 没车用按钮点击
    ///
    /// - Parameter sender: 按钮
    @IBAction func btnNobikeTapped(_ sender: UIButton) {
        
        
        
    }
    
    /// 车损坏按钮点击
    ///
    /// - Parameter sender: 按钮
    @IBAction func btnBrokenTapped(_ sender: UIButton) {
        
    }
    
    /// 上私锁按钮点击
    ///
    /// - Parameter sender: 按钮
    @IBAction func btnLockedTapped(_ sender: UIButton) {
        
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
    
    

}

// MARK: - 事件监听
extension ReportVC {
    
    /// 动画显示按钮
    func showButtonWithAnimation() {
        
        for (index, stackView) in stackViews.enumerated() {
            
            UIView.animate(withDuration: 0.1, delay: 0.1 * Double(index), options: [], animations: {
            
                stackView.transform = .identity
                
            }, completion: nil)
        }
        
    }
    
    //移除当前控制器
    func dismissSelf() {
        UIView.animate(withDuration: 0.2, animations: {
            self.view.alpha = 0
        }) { (finished) in
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    
    
    
}
