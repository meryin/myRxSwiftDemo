//
//  Config.swift
//  myRxSwiftDemo
//
//  Created by 尹彩霞 on 2017/11/20.
//  Copyright © 2017年 尹彩霞. All rights reserved.
//

import UIKit

let WindowWidth = UIScreen.main.bounds.size.width
let WindowHeight = UIScreen.main.bounds.size.height
let UserBasicInforKey = "UserBasicInforKey"

public func Color(_ color:String)->UIColor
{
    return Tools.colorWithHexString(stringValue: color, alpha: 1)
}
func RGBColor(_ r:CGFloat,_ g:CGFloat,_ b:CGFloat) -> UIColor{
    return UIColor(red: (r)/255.0, green: (g)/255.0, blue: (b)/255.0, alpha: 1.0)
}
