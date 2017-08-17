//
//  SettingController.swift
//  ofo
//
//  Created by Liu Chuan on 2017/8/9.
//  Copyright © 2017年 LC. All rights reserved.
//

import UIKit
import UserNotifications

class SettingController: UITableViewController {
    
    // MARK: - 控件属性
    /// 推送开关
    @IBOutlet weak var pushSwitch: UISwitch!
    
    /// 缓存标签
    @IBOutlet weak var cacheLabel: UILabel!
    
    /// 消息推送开关按钮事件
    ///
    /// - Parameter sender: 开关
    @IBAction func btnPushNotificationTapped(_ sender: UISwitch) {
        if !sender.isOn {
            let alert = UIAlertController(title: "关闭后，你将无法收到行程结束的提醒，确定要关闭吗？", message: nil, preferredStyle: .alert)
            
            let confirmAction = UIAlertAction(title: "确定", style: .default, handler: { (_) in
                //跳转到App设置界面
                 UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!, options:[:], completionHandler: nil)
            })
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: { (_) in
                sender.isOn = true
            })

            alert.addAction(cancelAction)
            alert.addAction(confirmAction)            
            self.present(alert, animated: true, completion: nil)
        } else {
            //跳转到App设置界面，让用户去打开通知。
            /* iOS10 之前 */
            // UIApplication.shared.openURL(URL(string: UIApplicationOpenSettingsURLString)!)
            
            /* iOS10 之后 */
            UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!, options:[:], completionHandler: nil)
            
        }
        
    }
    
    // MARK: - 视图的生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //注册通知
        NotificationCenter.default.addObserver(self, selector: #selector(checkAllowPush), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
    }
    deinit {
        // 移除通知
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
    }
    
    /// 视图即将可见时, 加载
    ///
    /// - Parameter animated: 是否动画
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //检测是否允许通知，设置UISwitch开关
        checkAllowPush()

    }

}

// MARK: - 事件监听
extension SettingController {
    
    //检测通知状态，设置UISwitch开关状态
    func checkAllowPush(){
        
/*
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().getNotificationSettings(completionHandler: { (settings) in
                if settings.authorizationStatus == UNAuthorizationStatus.authorized {
                    self.pushSwitch.isOn = true
                }else {
                    self.pushSwitch.isOn = false
                }
            })
        }
        else {
            // iOS 8.0 后的版本
            let settings = UIApplication.shared.currentUserNotificationSettings
            
            //TODO: - 需要测试 rawValue是否正确
            if settings?.types == UIUserNotificationType.init(rawValue: 0)  {
                self.pushSwitch.isOn = true
            } else {
                self.pushSwitch.isOn = false
            }
        }
    }
*/

       
        if #available(iOS 10.0, *) {
            
            // 申请通知权限
            /***(iOS10 之前)*/
           // let settings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
           // UIApplication.shared.registerUserNotificationSettings(settings)
            
             /***(iOS10 之后)*/
            let settings = UNUserNotificationCenter.current()
            settings.requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { (_, error) in
                print(error ?? "")
            })
        
            UNUserNotificationCenter.current().getNotificationSettings { (settings) in
                // 如果已授权,设置开关状态
                if settings.authorizationStatus == UNAuthorizationStatus.authorized {
                    self.pushSwitch.isOn = true
                }else {
                    self.pushSwitch.isOn = false
                }
            }
        }

    }
}


