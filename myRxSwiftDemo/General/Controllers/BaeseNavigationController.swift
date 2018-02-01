//
//  BaeseNavigationController.swift
//  myRxSwiftDemo
//
//  Created by 尹彩霞 on 2017/11/22.
//  Copyright © 2017年 尹彩霞. All rights reserved.
//

import UIKit

class BaeseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
         // 设置导航栏透明度
        self.navigationBar.isTranslucent = false
    
         // 设置导航栏样式
//        self.navigationBar.barStyle = UIBarStyle.blackTranslucent
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.childViewControllers.count == 1
        {
            viewController.hidesBottomBarWhenPushed = true
        }
        
        if childViewControllers.count > 0 {
           
            viewController.navigationItem.leftBarButtonItem =            UIBarButtonItem(title: "返回", style: .done, target: self, action: #selector(popVC))
        }
        viewController.view.backgroundColor = Color("0xffffff")
        super.pushViewController(viewController, animated: animated)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc fileprivate func popVC() {
        popViewController(animated:true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
