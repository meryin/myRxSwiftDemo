//
//  BaseTabBarViewController.swift
//  myRxSwiftDemo
//
//  Created by 尹彩霞 on 2017/11/22.
//  Copyright © 2017年 尹彩霞. All rights reserved.
//

import UIKit

class BaseTabBarViewController: UITabBarController,UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        let vc1 = MainViewController()
        let vc2 = ListViewController()
        let vc3 = WriteViewController()
        let vc4 = MineViewController()
        let nav1:BaeseNavigationController = BaeseNavigationController(rootViewController:vc1 )
        
        let nav2:BaeseNavigationController = BaeseNavigationController(rootViewController: vc2)
        let nav3:BaeseNavigationController = BaeseNavigationController(rootViewController: vc3)
        let nav4:BaeseNavigationController = BaeseNavigationController(rootViewController: vc4)
        vc1.title = "首页"
        vc2.title = "会馆"
        vc3.title = "发布"
        vc4.title = "我的"
        self.viewControllers = [nav1,nav2,nav3,nav4]
        nav1.tabBarItem.image = UIImage(named:"Ico_TabBar_1")!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        nav1.tabBarItem.selectedImage = UIImage(named:"Ico_TabBar_1_Selected")!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        nav2.tabBarItem.image = UIImage(named:"Ico_TabBar_2")!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        nav2.tabBarItem.selectedImage = UIImage(named:"Ico_TabBar_2_Selected")!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        nav3.tabBarItem.image = UIImage(named:"Ico_TabBar_3")!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        nav3.tabBarItem.selectedImage = UIImage(named:"Ico_TabBar_3_Selected")!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        nav4.tabBarItem.image = UIImage(named:"Ico_TabBar_4")
        
        self.tabBar.barTintColor = Color("0x111111")
        var image:UIImage = UIImage(named: "Ico_TabBar_4_Selected")!
        image = image.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        nav4.tabBarItem.selectedImage = image
        let dict:NSDictionary = [NSForegroundColorAttributeName:UIColor.white]
        let dict1:NSDictionary = [NSForegroundColorAttributeName:UIColor.gray]
        nav1.tabBarItem.setTitleTextAttributes(dict as? [String : Any], for: UIControlState.highlighted)
        nav1.tabBarItem.setTitleTextAttributes(dict1 as? [String : Any], for: UIControlState.normal)
        nav2.tabBarItem.setTitleTextAttributes(dict as? [String : Any], for: UIControlState.highlighted)
        nav2.tabBarItem.setTitleTextAttributes(dict1 as? [String : Any], for: UIControlState.normal)
        nav3.tabBarItem.setTitleTextAttributes(dict as? [String : Any], for: UIControlState.highlighted)
        nav3.tabBarItem.setTitleTextAttributes(dict1 as? [String : Any], for: UIControlState.normal)
        nav4.tabBarItem.setTitleTextAttributes(dict as? [String : Any], for: UIControlState.highlighted)
        nav4.tabBarItem.setTitleTextAttributes(dict1 as? [String : Any], for: UIControlState.normal)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
    }
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let arr = (viewController as! BaeseNavigationController).viewControllers
        if arr.count > 0
        {
            if arr[0] is WriteViewController
            {
                
                let vc = self.viewControllers?[tabBarController.selectedIndex] as! BaeseNavigationController
                vc.pushViewController(WKWebViewController(), animated: true)
                
                return false
            }
        }
        return true
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
