
//
//  Eidt+UILabel.swift
//  myRxSwiftDemo
//
//  Created by 尹彩霞 on 2017/12/7.
//  Copyright © 2017年 尹彩霞. All rights reserved.
//

import UIKit


extension UILabel{
    
    
    convenience init(text:String,font:CGFloat,textColor:UIColor,numberOfLines:Int = 1) {
        self.init()
        self.text = text
        self.font = UIFont.systemFont(ofSize: font)
        self.textColor = textColor
        self.numberOfLines = numberOfLines      
    }
    convenience init(textAlign:NSTextAlignment = .left,font:CGFloat,textColor:UIColor,numberOfLines:Int = 1) {
        self.init()
        self.textAlignment = textAlign
        self.font = UIFont.systemFont(ofSize: font)
        self.textColor = textColor
        self.numberOfLines = numberOfLines
        
        
    }
    
}

