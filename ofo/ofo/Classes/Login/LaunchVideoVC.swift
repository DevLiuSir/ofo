//
//  LaunchVideoVC.swift
//  ofo
//
//  Created by Liu Chuan on 2017/7/8.
//  Copyright © 2017年 LC. All rights reserved.
//

import UIKit
import AVFoundation

/// 启动App播放视频。
class LaunchVideoVC: UIViewController {

    
    /// 播放器
    private lazy var player = AVPlayer()
    
    /// 销毁
    deinit {
        print("LaunchVideoVC deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        if #available(iOS 11.0, *) {
            additionalSafeAreaInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        } else {
            // Fallback on earlier versions
        }
        
        
        
        playLaunchVedio()
    }
 
    /// 播放启动页视频
    private func playLaunchVedio() {
        
        /// 获取视频路径
        let filePath = Bundle.main.path(forResource: "loginVideoV2", ofType: "mp4")
        
        /// 根据视频路径转换成URL
        let videoURL = URL(fileURLWithPath: filePath!)
        
        //定义一个视频播放器
        let playerItem = AVPlayerItem(url: videoURL)

        player = AVPlayer(playerItem: playerItem)
        
        // 播放结束后暂停
        player.actionAtItemEnd = .pause
        
        /// 播放器预览层
        let playerLayer = AVPlayerLayer(player: player)
        
//        let abc: CGFloat = isIphoneX
        
        playerLayer.frame = CGRect(x: 0, y: 0, width: screenW, height: 812)

        //添加到界面上显示
        view.layer.addSublayer(playerLayer)
       
        // 通知
        NotificationCenter.default.addObserver(self, selector: #selector(videoPlayerDidFinished), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
        
        player.play()
    }
    
    //播放完毕调用此方法
    @objc private func videoPlayerDidFinished() {
        
        print("停止了")
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
        
        //获取Storyboard的主视图
        let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyNavigationController")
        
        switchRootViewController(rootVC: mainVC)
    }
    
    /// 动画切换到根视图控制器
    ///
    /// - Parameter rootVC: 跟视图控制器
    private func switchRootViewController(rootVC: UIViewController) {
        let window = UIApplication.shared.keyWindow!    //transitionCrossDissolve: 过渡淡入淡出动画
        UIView.transition(with: window, duration: 0.5, options: UIView.AnimationOptions.transitionCrossDissolve, animations: {
            window.rootViewController = rootVC
        })
    }
}
