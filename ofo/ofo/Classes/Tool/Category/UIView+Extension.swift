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

/// 屏幕的宽度
let screenW = UIScreen.main.bounds.width

/// 屏幕的高度
let screenH = UIScreen.main.bounds.height

/// iPhone4
let isIphone4 = screenH < 568 ? true : false

/// iPhone 5
let isIphone5 = screenH == 568 ? true : false

/// iPhone 6
let isIphone6 = screenH == 667 ? true : false

/// iphone 6P
let isIphone6P = screenH == 736 ? true : false

/// iphone X
let isIphoneX = screenH == 812 ? true : false

/// 状态栏的高度
let statusH: CGFloat = UIApplication.shared.statusBarFrame.size.height > 20 ? 44 : 20

/// 导航栏的高度
let navigationH: CGFloat = isIphoneX ? 44 : 64

/// 标签栏的高度
let tabBarH: CGFloat = isIphoneX ? 49 + 34 : 49

/// 导航栏底部阴影图片的高度
let shadowImageViewH: CGFloat = 60

/// ofo全局黄色
let ofoWholeColor = UIColor(red:0.98, green:0.89, blue:0.18, alpha:1.00)

/// 导航栏item颜色
let navigationBarTint = UIColor(red: 64/255, green: 50/255, blue: 17/255, alpha: 1)



// MARK: - UIViewExtension
extension UIView {
    
    var size: CGSize {
        get {
            return self.frame.size
        }
        set {
            self.frame.size = newValue
        }
    }
    
    var origin: CGPoint {
        get {
            return self.frame.origin
        }
        set {
            self.frame.origin = newValue
        }
    }
    
    var width: CGFloat {
        get {
            return self.size.width
        }
        set {
            self.size.width = newValue
        }
    }
    
    var height: CGFloat {
        get {
            return self.size.height
        }
        set {
            self.size.height = newValue
        }
    }
    
    var x: CGFloat {
        get {
            return self.origin.x
        }
        set {
            self.origin.x = newValue
        }
    }
    
    var y: CGFloat {
        get {
            return self.origin.y
        }
        set {
            self.origin.y = newValue
        }
    }
}


// MARK: - method
/// 打开手电筒的实现
func TurnOnFlashlight() {
    
    // 获取摄像头设备
    // 捕获设备(AVCaptureDevice) 默认为: 视频类型
    guard let device = AVCaptureDevice.default(for: AVMediaType.video) else { return }
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


// MARK: - NSStringExtension
extension NSString {

    /// 给Document里添加文件
    ///
    /// - Returns: NSString
    func lc_appendDocumentDir() -> NSString {
        let dir: NSString? = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last as NSString?
        return dir!.appendingPathComponent((dir?.lastPathComponent)!) as NSString
     }
}



struct MyColor {
    static var randomColor: UIColor {
        let red = CGFloat(arc4random() % 256) / 255
        let green = CGFloat(arc4random() % 256) / 255
        let blue = CGFloat(arc4random() % 256) / 255
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    static let yellow = UIColor(red: 254/255, green: 234/255, blue: 57/255, alpha: 1)
    static let btnEnable = UIColor(red: 254/255, green: 211/255, blue: 48/255, alpha: 1)
    static let btnDisable = UIColor(red: 205/255, green: 205/255, blue: 205/255, alpha: 1)
    static let verifyCodeBg = UIColor(red: 241/255, green: 241/255, blue: 241/255, alpha: 1)
    static let barTint = UIColor(red: 64/255, green: 50/255, blue: 17/255, alpha: 1)
}
