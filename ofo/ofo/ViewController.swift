//
//  ViewController.swift
//  ofo
//
//  Created by Liu Chuan on 2017/7/16.
//  Copyright © 2017年 LC. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    // MARK: - 控件属性
    /// 地图
    @IBOutlet weak var mapView: MKMapView!
    
    /// 扫码用车面板视图
    @IBOutlet weak var panelView: UIView!
    
    
    // MARK: - 懒加载
    /// 导航栏底部阴影图片
    fileprivate lazy var shadowImageView: UIImageView = {
        let imV = UIImageView(frame: CGRect(x: 0, y: 0, width: screenW, height: shadowImageViewH))
        imV.image = UIImage(named: "whiteImage")
        return imV
    }()
    
    
    // MARK: - 系统函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
    }
    

}

// MARK: - 配置UI
extension ViewController {
    
    /// 配置UI界面
    fileprivate func configUI() {
        
        addSubV()
        configNavigationBar()
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
}
