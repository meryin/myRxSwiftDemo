//
//  TabBarViewController.swift
//  myRxSwiftDemo
//
//  Created by 尹彩霞 on 2017/11/20.
//  Copyright © 2017年 尹彩霞. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController,TabBarSelectedItemDelegate {
    var tabBarView:TabBar?
    var tabBarHidden:Bool{
        set{ self.tabBarHidden = newValue
            tabBarView?.isHidden = newValue
        }
        get{ return self.tabBarHidden }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.isHidden = true
        self.view.backgroundColor = UIColor.clear
        let vc1 = MainViewController()
        let vc2 = ListViewController()
        let vc3 = WriteViewController()
        let vc4 = MineViewController()
        vc1.title = "首页"
        vc2.title = "会馆"
        vc3.title = "发布"
        vc4.title = "我的"
        let navarr:Array<Any> = [vc1,vc2,vc3,vc4]
        let titlearr:Array<String> = ["首页","会馆","发布","我的"]
        let imgarr:Array<String> = ["Ico_TabBar_1","Ico_TabBar_2","Ico_TabBar_3","Ico_TabBar_4"]
        let seletimgArr:Array<String> = ["Ico_TabBar_1_Selected","Ico_TabBar_2_Selected","Ico_TabBar_3_Selected","Ico_TabBar_4_Selected"]
        tabBarView = TabBar(frame: CGRect(x: 0.0, y:WindowHeight-50.0 , width: WindowWidth, height: 50.0))
        tabBarView?.backgroundColor = Color("0x999999")
        for index in 0..<navarr.count
        {
            let item:TabBarItem? = TabBarItem.initWith(title: titlearr[index], image: UIImage(named: imgarr[index])!, selectedImage: UIImage(named: seletimgArr[index])!, controller: navarr[index] as! UIViewController)
            tabBarView?.addTabBarItem(tabbaritem: item!)
           self.view.addSubview((navarr[index] as! UIViewController).view)
        }
        self.view.addSubview(tabBarView!)
        tabBarView?.delegate=self
    
        
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
      func tabBarSelectedIndex(tabbar: TabBar, index: Int) {
        tabbar.setSelectIndex(selectIndex: index)
    }
      func tabBarSelectedTabBarItem(tabbar: TabBar, item: TabBarItem) {
        let index = tabbar.tabBarItems.index(of: item)
        tabbar.setSelectIndex(selectIndex: index)
       
       
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
