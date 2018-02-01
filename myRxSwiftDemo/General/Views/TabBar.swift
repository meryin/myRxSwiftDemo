//
//  TabBar.swift
//  myRxSwiftDemo
//
//  Created by 尹彩霞 on 2017/9/18.
//  Copyright © 2017年 尹彩霞. All rights reserved.
//

import UIKit
protocol TabBarSelectedItemDelegate {
   
    func tabBarSelectedTabBarItem(tabbar:TabBar,item:TabBarItem)
  func tabBarSelectedIndex(tabbar:TabBar,index:Int)
}

class TabBar: UIView {
    var selectIndex:Int = 0
    var index:Int=0
    var tabBarItems:NSArray = []
    var delegate:TabBarSelectedItemDelegate?
    
    private var tabBarViews:NSMutableArray = []
    
    func loadView()  {
        for view in self.subviews{
            view.removeFromSuperview()
        }
        let width:CGFloat = WindowWidth/CGFloat(self.tabBarViews.count)
        var i = 0
        let arr:NSMutableArray = []
        for tabView in self.tabBarViews{
            arr.add(tabView)
            self.addSubview(tabView as! UIView)
            (tabView as! UIView).frame = CGRect(x: width*CGFloat(i), y: 0, width: width, height: self.bounds.size.height)
        }
        i += 1
    }
    
    func addTabBar(item:UITabBarItem) {
        tabBarViews.add(TabBarItem.initWithTabBarItem(item: item))
        self.reloadView()
    }
    func addTabBarItem(tabbaritem:TabBarItem)
    {
        tabBarViews.add(tabbaritem)
        self.reloadView()
    }
    func reloadView()
    {
        _ = self.subviews.map({
            $0.removeFromSuperview()
           
        })
        let width:CGFloat = WindowWidth/CGFloat(self.tabBarViews.count)
        var i:Int = 0
        let items:NSMutableArray = []
        for index in 0..<self.tabBarViews.count
        {
            let tab:TabBarItem = self.tabBarViews[index] as! TabBarItem ;
            items.add(tab)
            let view:UIView = UIView(frame: CGRect(x:CGFloat (i)*width, y: 0.0, width: width, height: self.frame.size.height))
            self.addSubview(view)
            view.addSubview(tab )
            view.tag = index
            tab.center = CGPoint(x:view.frame.size.width/2,y:view.frame.size.height/2)
            let tap = UITapGestureRecognizer(target: self, action: #selector(tap(recognizer:)))
            view.addGestureRecognizer(tap)
            i = i+1
            
        }
        self.tabBarItems = items
        self.setSelectIndex(selectIndex: 0)
        let topline:UIView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: WindowWidth, height: 0.5))
        self.addSubview(topline)
        self.sendSubview(toBack: topline)
        
        topline.backgroundColor = Color("0xffffff")
        
    }
    func setSelectIndex(selectIndex:NSInteger)  {
        self.selectIndex = selectIndex
        for index in 0..<self.tabBarViews.count
        {
            let tab:TabBarItem = self.tabBarViews[index] as! TabBarItem ;
            tab.setSelected(selected: selectIndex == index)
        }
        
    }
    func clear(){
        tabBarViews.removeAllObjects()
    }
    func tap(recognizer:UITapGestureRecognizer)
    {
        let index:Int? = recognizer.view!.tag
        
        if delegate != nil
        {
            self.delegate?.tabBarSelectedIndex(tabbar: self, index: index!)
            delegate?.tabBarSelectedTabBarItem(tabbar: self, item: self.tabBarViews[index!] as! TabBarItem)
        }
        
    }
}
