//
//  UIView+Extension.swift
//  ofo
//
//  Created by Liu Chuan on 2017/6/25.
//  Copyright © 2017年 LC. All rights reserved.
//


import UIKit
import AVFoundation


// MARK:- 定义全局常量
let screenW = UIScreen.main.bounds.width    // 屏幕的宽度
let screenH = UIScreen.main.bounds.height   // 屏幕的高度
let statusH: CGFloat = 20                   // 状态栏的高度
let navigationH: CGFloat = 44               // 导航栏的高度
let tabBarH: CGFloat = 49                   // 标签栏的高度
let shadowImageViewH: CGFloat = 60          // 导航栏底部阴影图片的高度


/// 打开手电筒的实现
func TurnOnFlashlight() {
    // 捕获设备(AVCaptureDevice) 默认为: 视频类型
    guard let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo) else { return }
    // 如果设备有闪光, 且设备的闪光灯是否可用
    if device.hasFlash && device.isTorchAvailable {
        try? device.lockForConfiguration()  // 锁定闪光灯(供该方法调用者使用)
        
        if device.torchMode == .off {
            device.torchMode = .on
        }else {
            device.torchMode = .off
        }
        
        device.unlockForConfiguration()     // 取消锁定
    }
}
