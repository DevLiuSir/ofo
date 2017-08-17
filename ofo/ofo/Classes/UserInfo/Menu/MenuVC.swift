//
//  MenuVC.swift
//  ofo
//
//  Created by Liu Chuan on 2017/7/31.
//  Copyright © 2017年 LC. All rights reserved.
//

import UIKit


/// 菜单控制器
class MenuVC: UIViewController {
    
    // MARK: - 控件属性
    /// 表格
    @IBOutlet weak var tableView: UITableView!
    
    /// 头部视图
    @IBOutlet weak var headerView: UIView!
    
    /// 表格 和 用户信息的 父视图
    @IBOutlet weak var tableBgView: UIView!
    
    /// 用户头像
    @IBOutlet weak var userAvatarBtn: UIButton!
    
    /// 用户电话
    @IBOutlet weak var userMobileLabel: UILabel!
    
    /// 用户信用
    @IBOutlet weak var userCreditLabel: UILabel!
    
    // MARK: - 属性
    /// 当前视图是否在离开动画中，用来处理平移手势时，以防重复调用。
    var isAnimating = false
    
    /// 是否激活动画Cell
    var shouldAnimateCell = true
    
    /// 菜单数据数组
    var menuData = ["我的行程", "我的钱包", "邀请好友", "兑优惠券", "我的消息", "我的客服"]
    
    /// 菜单头像
    var menuIconName = ["icon_slide_trip2", "icon_slide_wallet2", "icon_slide_invite2", "icon_slide_coupon2", "icon_slide_myMsg","icon_slide_usage_guild2"]
    
    
    /// 关闭按钮事件
    ///
    /// - Parameter sender: 按钮
    @IBAction func btnCloseTapped(_ sender: UIButton) {
        
        viewLeaveAnimation()
    }
    
    // MARK: - 视图生命周期
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
        
        
        // 将头部视图(黄色View)\tableView的父视图 处于屏幕之外
        tableBgView.transform = CGAffineTransform(translationX: 0, y: screenH)
        headerView.transform = CGAffineTransform(translationX: 0, y: -screenH)
        
        // 创建单击手势, 并添加
        let panGestrue = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        view.addGestureRecognizer(panGestrue)
   
    }
    
    /// 对象的视图已经加入到窗口时,调用
    ///
    /// - Parameter animated: 是否动画
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewEnterAnimation()
        
        //当且仅当第一次载入视图的时候，Cell展示动画。
        if shouldAnimateCell {
            startCellDisplayAnimation()
            shouldAnimateCell = false
        }
    }

    /// 对象的视图即将加入窗口时,调用
    ///
    /// - Parameter animated: 是否动画
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    /// 对象的视图即将消失、被覆盖或是隐藏时调用
    ///
    /// - Parameter animated: 是否动画
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    
    
}

// MARK: - 配置UI界面
extension MenuVC {
    
    /// 配置UI
    fileprivate func configUI() {
        configTableView()
    }
    
    /// 配置表格视图
    private func configTableView() {
        tableView.dataSource = self
    }
}


// MARK: - 事件监听
extension MenuVC {
    
    /// 平移手势，当向下平移时，关闭菜单
    ///
    /// - Parameter recognizer: 拖动手势识别器
    func handlePanGesture(recognizer: UIPanGestureRecognizer) {
        /// 获取拖动的Y值
        let translationY = recognizer.translation(in: self.view).y
        // 拖动的值清零
        recognizer.setTranslation(CGPoint.zero, in: self.view)
        
        //isAnimating 确保这里只调用一次。
        if  translationY > 5 && !isAnimating {
            isAnimating = true
            viewLeaveAnimation()
        }
    }
    
    
    
    /// 视图显示时的动画
    func viewEnterAnimation() {
        
//        let main = MainViewController()
//        let radio = 1 - offSetX
//        main.UserCenter.alpha = radio
//        main.ActivityCenter.alpha = radio
        
        UIView.animate(withDuration: 0.3) { // 恢复
            self.tableBgView.transform = .identity
            self.headerView.transform  = .identity
        }
    }
    /// 视图关闭时的动画
    func viewLeaveAnimation() {
        
        UIView.animate(withDuration: 0.3, animations: {     // 平移
            self.tableBgView.transform = CGAffineTransform(translationX: 0, y: screenH)
            self.headerView.transform = CGAffineTransform(translationX: 0, y: -screenH)
        }) { (finished) in
            self.dismiss(animated: false, completion: nil)
        }
        
        
    }
    
    /// 刚开始载入Cell的时候，有一个往上拱的动画。
    func startCellDisplayAnimation() {
//        self.tableView.reloadData()
        
        /// 表格所有看得见的Cell
        let visibleCells = tableView.visibleCells
        
        /// 表格的高度
        let tableHeight = tableView.bounds.height
        
        for cell in visibleCells {  // 平移Cell
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
        }
        
        var index: Double = 0
        
        for cell in visibleCells {
            
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
            
            UIView.animate(withDuration: 0.3, delay: 0.1 * index, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: nil)
            index += 1
        }
    }

    
    
}


// MARK: - UITableViewDataSource
extension MenuVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomMenuCell") as! CustomMenuTabelCell
        
        // 设置cell相关属性
        cell.iconImageView.image = UIImage(named: menuIconName[indexPath.row])
        cell.titleLabel.text = menuData[indexPath.row]
        
        if indexPath.row == 4 {
            cell.redpointView.isHidden = false  // 小红点不隐藏
        } else {
            cell.redpointView.isHidden = true
        }
        return cell
    }
}
