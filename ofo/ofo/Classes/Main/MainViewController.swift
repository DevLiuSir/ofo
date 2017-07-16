//
//  MainViewController.swift
//  ofo
//
//  Created by Liu Chuan on 2017/7/16.
//  Copyright © 2017年 LC. All rights reserved.
//

import UIKit


class MainViewController: UIViewController {

    // MARK: - 控件属性
    /// 地图
//    @IBOutlet weak var mapView: MKMapView!
    
    /// 扫码用车面板视图
    @IBOutlet weak var panelView: UIView!
    
    /// 包含按钮的底部容器视图
    @IBOutlet weak var containerView: UIView!
    
    /// 用户中心
    @IBOutlet weak var UserCenter: UIButton!
    
    /// 活动中心
    @IBOutlet weak var ActivityCenter: UIButton!

    
    // MARK: - 懒加载
    /// 导航栏底部阴影图片
    fileprivate lazy var shadowImageView: UIImageView = {
        let imV = UIImageView(frame: CGRect(x: 0, y: 0, width: screenW, height: shadowImageViewH))
        imV.image = UIImage(named: "whiteImage")
        return imV
    }()
    
    
    /// 高德地图
    var mapView: MAMapView!
    
    /// 扫码用车按钮事件
    ///
    /// - Parameter sender: 按钮
    @IBAction func sweepCodeCar(_ sender: UIButton) {
        
        scanQRCode()
    }
    
    /// 箭头按钮点击事件
    ///
    /// - Parameter sender: 按钮
    @IBAction func arrowBtnTap(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected  // 取反按钮状态
        
        if sender.isSelected {
            UIView.animate(withDuration: 0.25) {    // 平移动画
                // y值为: 正, 使得向下平移, 使得隐藏.
                self.containerView.transform = CGAffineTransform(translationX: 0, y: self.panelView.frame.size.height)
                self.UserCenter.transform = CGAffineTransform(translationX: 0, y: self.UserCenter.frame.size.height)
                self.ActivityCenter.transform = CGAffineTransform(translationX: 0, y: self.ActivityCenter.frame.size.height)
            }
            
        } else {
            
            UIView.animate(withDuration: 0.25, animations: {
                self.containerView.transform = .identity
            })
            UIView.animate(withDuration: 0.6, animations: {
                self.UserCenter.transform = .identity
                self.ActivityCenter.transform = .identity
            })
        } 
        
    }

    // MARK: - 系统函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
    }
}

// MARK: - 配置UI
extension MainViewController {
    
    /// 配置UI界面
    fileprivate func configUI() {
        
        addSubV()
        configNavigationBar()
        configMaMapView()
    }
    
    /// 添加控件
    private func addSubV() {
        view.addSubview(shadowImageView)
    }
    
    /// 配置导航栏
    private func configNavigationBar() {
        
        // 左边的item
        let imageView = UIImageView(image: UIImage(named: "yellowBikeLogo"))
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: imageView)
        
        // 取消导航栏底部的阴影线
        let image = UIImage()
        navigationController?.navigationBar.setBackgroundImage(image, for: .default)
        navigationController?.navigationBar.shadowImage = image
        
        // 返回按钮图片
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "backIndicator")
        
        // 隐藏返回按钮上的文字
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        // 修改导航栏按钮颜色
        navigationController?.navigationBar.tintColor = UIColor.gray
    }
    
    
    /// 配置高德地图
    private func configMaMapView() {
        mapView = MAMapView(frame: view.bounds)
        
        ///如果您需要进入地图就显示定位小蓝点，则需要下面两行代码
        mapView.showsUserLocation = true
        mapView.userTrackingMode = MAUserTrackingMode.follow    // 追踪位置
        mapView.delegate = self
        
        view.insertSubview(mapView, at: 0)
    }
}



// MARK: - 事件监听
extension MainViewController {
    
    /// 扫描二维码
    fileprivate func scanQRCode() {
        // 获取storyboard
        let storyBoard = UIStoryboard(name: "QRCodeController", bundle: nil)
        let qrcodeVC = storyBoard.instantiateInitialViewController()
        present(qrcodeVC!, animated: true, completion: nil)     // motal展现
    }
}

// MARK: - MAMapViewDelegate 协议
extension MainViewController: MAMapViewDelegate {
    
    
}








