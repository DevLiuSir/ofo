//
//  AppDelegate.swift
//  ofo
//
//  Created by Liu Chuan on 2017/7/16.
//  Copyright © 2017年 LC. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        
        
        // FIXME: 需要存储App版本，否则更新新版App后，isFirstLaunch还是True。
        
        // 1.得到当前应用的版本号
        let currentAppVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        
        // 2.取出之前保存在document中的版本号
//        let appVersion = UserDefaults.standard.string(forKey: "appVersion")
        
        let path: String = ("version" as NSString).lc_appendDocumentDir() as String
        let sandboxVersion = (try? String(contentsOfFile: path)) ?? ""
        print("沙盒版本=\(sandboxVersion)")
        print("当前版本=\(currentAppVersion)")
//        print(path)
        
    
        // 3.将当前版本号保存到沙盒中 1.0.2
        _ = try? currentAppVersion.write(toFile: path, atomically: true, encoding: .utf8)
        
        // 比较2个版本是否一致 (重而判断是否第一次启动App)
        if currentAppVersion == sandboxVersion {
            print("第一次启动")
            self.window?.rootViewController = LaunchVideoVC()
        }else {
            print("不是第一次启动")
            //获取Storyboard的主视图
            let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyNavigationController")
            self.window?.rootViewController = mainVC
        }
        
        // 高德Key
        AMapServices.shared().apiKey = "360ae2bd7ba9c07cd2f141e53722af9f"
        // 开启HTTPS安全协议
        AMapServices.shared().enableHTTPS = true
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

