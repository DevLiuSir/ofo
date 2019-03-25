//
//  QRCodeController.swift
//  ofo
//
//  Created by Liu Chuan on 2017/7/16.
//  Copyright © 2017年 LC. All rights reserved.
//

import UIKit
import AVFoundation

class QRCodeController: UIViewController {

    // MARK: - 控件属性
    
    /// 冲击波视图顶部约束
    @IBOutlet weak var scanLineTopConstranit: NSLayoutConstraint!
    
    /// 容器视图高度约束
    @IBOutlet weak var containerHeightConstraint: NSLayoutConstraint!
    
    /// 冲击波视图
    @IBOutlet weak var scanLineView: UIImageView!
    
    
    /// 记录seesion
    var seesion: AVCaptureSession?
    
    /// 计时器，当摄像头扫描超过时间，就弹出手动输入界面。
    private var timer: Timer!
    
    
    // MARK: - 按钮点击事件
    /// 手动输入车牌
    ///
    /// - Parameter sender: 按钮
    @IBAction func InputCar(_ sender: UIButton) {
        
        // 返回上一级控制器 (移除扫描控制器)
        self.dismiss(animated: false, completion: nil)

        /// 加载storyboard
        let InputVC = UIStoryboard(name: "InputCarLicenseController", bundle: nil).instantiateInitialViewController() as! InputCarLicenseController
        
        // 过渡方式垂直
        InputVC.modalPresentationStyle = .overCurrentContext
    
        // 获取根控制器
        let rootVC = UIApplication.shared.keyWindow?.rootViewController!
        let vc = rootVC?.children[0]
        // 呈现控制器
        vc?.present(InputVC, animated: true, completion: nil)
    }
    
    /// 手电筒开关点击
    ///
    /// - Parameter sender: UIButton
    @IBAction func TorchSwitchTap(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected  // 按钮状态取反
        TurnOnFlashlight()
    }
    
    // MARK: - system method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 添加计时器
        timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(showInputViewWhenScanTimeout), userInfo: nil, repeats: false)

        configUI()
    }
    

    /// 视图即将可见时,加载
    ///
    /// - Parameter animated: 是否动画
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        scanAnimation()
    }
    
    /// 视图即将消失时,加载
    ///
    /// - Parameter animated: 是否动画
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate()  // 移除定时器
    }
    
    // MARK: - custom method
    
    /// 冲击波动画 (即: 改变冲击波的顶部约束 - 增大)
    private func scanAnimation() {
/*
        // 设置动画初始约束 (让约束从顶部开始)
        self.scanLineTopConstranit.constant = -self.containerHeightConstraint.constant
        
        // 强制更新视图布局
        self.view.layoutIfNeeded()
*/
        UIView.animate(withDuration: 3.0) {
            // 1.修改约束
            self.scanLineTopConstranit.constant = self.containerHeightConstraint.constant
            
            // 1.1设置动画重复次数
            UIView.setAnimationRepeatCount(MAXFLOAT)
            
            // 2.强制更新视图布局
            self.view.layoutIfNeeded()
        }
        startScan()
    }
    
    /// 开始扫描
    private func startScan() {
        
        // 1. 开始输入
        // 1.1 获取摄像头设备
        guard let device = AVCaptureDevice.default(for: AVMediaType.video) else { return }

        // 1.2 把摄像头设备当作输入设备
        var input: AVCaptureDeviceInput?
        
        do {
            //创建输入流
            input = try AVCaptureDeviceInput(device: device)
        } catch  {
            print(error)
            return
        }
        
        // 2.设置输出
        let outPut = AVCaptureMetadataOutput()
        
        // 2.1 设置结果处理代理
        outPut.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        // 3.创建会话, 链接输入和输出
        seesion = AVCaptureSession()
        // 如果能添加输入\输出, 然后才添加
        if seesion!.canAddInput(input!) && seesion!.canAddOutput(outPut) {
            seesion!.addInput(input!)
            seesion!.addOutput(outPut)
        }else {
            return
        }
        
        // 3.1 设置二维码可以识别的码制
        /* 注意: 设置识别的类型, 必须要在输出添加到会话之后, 才可以设置, 否则,程序崩溃!  */
        // 相等
        // outPut.availableMetadataObjectTypes
        // AVMetadataObjectTypeQRCode
        outPut.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        
        // 3.2 添加视频预览图层 (让用户可以看见界面) * 不是必须添加的 *
        let previewLayer = AVCaptureVideoPreviewLayer(session: seesion!)
        
        //设置预览图层的填充方式
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        
        //设置预览图层的frame
        previewLayer.frame = view.layer.bounds
        
        //将预览图层添加到预览视图上
        view.layer.insertSublayer(previewLayer, at: 0)
        
        // 4.启动会话 (让输入开始采集数据, 输出对象, 开始处理数据)
        seesion!.startRunning()
    }
}

// MARK: - 配置UI
extension QRCodeController {
    
    /// 配置UI界面
    private func configUI() {
        configNavigationBar()
    }
    
    /// 配置导航栏
    private func configNavigationBar() {
        
        // 导航栏按钮颜色
        navigationController?.navigationBar.tintColor = UIColor.white
        
        // 左边的item
        let imageView = UIImageView(image: UIImage(named: "yellowBikeWhiteTitle"))
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: imageView)
        
        // 右边的item
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "whiteClose"), style: .plain, target: self, action: #selector(close))
        
        // 取消导航栏底部的阴影线
        let image = UIImage()
        navigationController?.navigationBar.setBackgroundImage(image, for: .default)
        navigationController?.navigationBar.shadowImage = image
    }
}

// MARK: - 事件监听
extension QRCodeController {
    
    /// 关闭按钮事件
    @objc private func close() {
        dismiss(animated: true, completion: nil)
    }
    
    /// 显示扫描超时视图
    @objc private func showInputViewWhenScanTimeout() {
        
        navigationController?.navigationBar.isHidden = true
        
        let scanTimeoutVC = UIStoryboard(name: "ScanTimeoutVC", bundle: nil).instantiateInitialViewController() as! ScanTimeoutVC
        view.addSubview(scanTimeoutVC.view)
        addChild(scanTimeoutVC)
    }
}

// MARK: - AVCaptureMetadataOutputObjectsDelegate 协议
extension QRCodeController: AVCaptureMetadataOutputObjectsDelegate {
    
    // 扫描到结果之后,调用
    func metadataOutput(_ captureOutput: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        print("扫描到结果.......")
        
        if metadataObjects != nil && metadataObjects.count > 0 {
            let metaData = metadataObjects.first as! AVMetadataMachineReadableCodeObject
            
            print(metaData.stringValue ?? "")
            
            DispatchQueue.main.async(execute: {
                let result = WebViewController()
                result.url = metaData.stringValue
                self.navigationController?.pushViewController(result, animated: true)
            })
            seesion?.stopRunning()
        }
    }
}
