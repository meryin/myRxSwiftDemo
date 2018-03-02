//
//  File.swift
//  myRxSwiftDemo
//
//  Created by 尹彩霞 on 2017/12/7.
//  Copyright © 2017年 尹彩霞. All rights reserved.
//

import UIKit

extension UIButton {
    // 遍历构造函数必须调用本类中的其他指定构造器
  
    /// - parameter setImage:           默认状态图片
    /// - parameter setBackgroundImage: 背景图片

    convenience init(setImage:String,setBackgroundImage:String,target:Any?,action:Selector? ){
        self.init(type: .custom)
        
        self.setImage(UIImage(named:setImage), for: UIControlState.normal)
        self.setImage(UIImage(named:"\(setImage)_highlighted"), for: UIControlState.highlighted)
        self.setBackgroundImage(UIImage(named:setBackgroundImage), for: UIControlState.normal)
        self.setBackgroundImage(UIImage(named:"\(setBackgroundImage)_highlighted"), for: UIControlState.highlighted)
        
        if target != nil && action != nil
        {
            self.addTarget(target, action: action!, for: UIControlEvents.touchUpInside)
        }
        
        self.sizeToFit()
    }
    
    convenience init(title:String?,titleColor:UIColor?,fontSize:CGFloat? ){
        self.init(type: .custom)
        self.setTitle(title, for: UIControlState.normal)
        self.setTitleColor(titleColor, for: UIControlState.normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: fontSize!)
        self.sizeToFit()
        
    }
    
    //有背景颜色和文字的按钮
    /// - parameter backGroundColor:           背景颜色
    /// - parameter title: 文字
    //titleColor :文字颜色
    convenience init(backGroundColor:UIColor?,title:String?,titleColor:UIColor?,target:Any?,action:Selector? ){
        self.init(type: .custom)
        
        self.setBackGroundColor(color: backGroundColor!, .normal)
        self.setTitle(title, for: UIControlState.normal)
        self.setTitleColor(titleColor, for: UIControlState.normal)
        if target != nil && action != nil
        {
            self.addTarget(target, action: action!, for: UIControlEvents.touchUpInside)
        }
        
        self.sizeToFit()
    }
    
    /// 返回带文字的高亮图片的按钮
    /// - parameter setHighlightImage: 图片
    /// - parameter title:             文字
    
    convenience init(setHighlightImage:String?,title:String?,titleColor:UIColor,target:Any?,action:Selector? ){
        self.init(type: .custom)
        
        if let img = setHighlightImage {
            self.setImage(UIImage(named:img), for: UIControlState.normal)
            
            self.setImage(UIImage(named:"\(img)_highlighted"), for: UIControlState.highlighted)
        }
        
        self.setTitle(title, for: UIControlState.normal)
        self.setTitleColor(titleColor, for: UIControlState.normal)
        if target != nil && action != nil
        {
            self.addTarget(target, action: action!, for: UIControlEvents.touchUpInside)
        }
        
        self.sizeToFit()
        
    }
    /// 返回带文字的背景图片的按钮
    /// - parameter BackgroundImage: 背景图片
    /// - parameter title:             文字
    convenience init(BackgroundImage:String?,title:String?,titleColor:UIColor, target:Any?,action:Selector? ){
        
        self.init(type: .custom)
        
        self.setBackgroundImage(UIImage(named:BackgroundImage!), for: UIControlState.normal)
        self.setTitle(title, for: UIControlState.normal)
        self.setTitleColor(titleColor, for: UIControlState.normal)
        
        if target != nil && action != nil
        {
            self.addTarget(target, action: action!, for: UIControlEvents.touchUpInside)
        }
        
        self.sizeToFit()
        
    }
    func setBackGroundColor(color:UIColor?,_ state:UIControlState = UIControlState.normal )
    {
        self.setBackgroundImage(Tools.imageWithColor(color: color!), for: state)
    }
    func setCoradius(_ radius:CGFloat)
    {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius

    }
    
}
