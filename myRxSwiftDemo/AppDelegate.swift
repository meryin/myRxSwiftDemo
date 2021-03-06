//
//  AppDelegate.swift
//  myRxSwiftDemo
//
//  Created by 尹彩霞 on 2017/7/11.
//  Copyright © 2017年 尹彩霞. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds )
        window?.backgroundColor = UIColor.gray
        UINavigationBar.appearance().barTintColor = UIColor.white
        let dict:NSDictionary = [NSForegroundColorAttributeName:Color("0x111111"),NSFontAttributeName : UIFont.boldSystemFont(ofSize:18)]
        UINavigationBar.appearance().titleTextAttributes = dict as? [String : Any]
        //2.4设置返回按钮颜色
        UINavigationBar.appearance().tintColor = Color("0x111111")
        
//        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(CGFloat(NSInteger.min),CGFloat(NSInteger.min)), forBarMetrics:UIBarMetrics.default);
        //2.2导航标题文字颜色
         
        MBProgressHUD.initMBProgressHUD()
        
        window?.rootViewController = BaseTabBarViewController()
        window?.makeKeyAndVisible()
        window?.tintColor = UIColor.red //统一更改默认控件的颜色
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

