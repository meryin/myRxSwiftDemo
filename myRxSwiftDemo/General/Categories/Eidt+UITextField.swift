
//
//  Eidt+UITextField.swift
//  myRxSwiftDemo
//
//  Created by 尹彩霞 on 2017/12/7.
//  Copyright © 2017年 尹彩霞. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension UITextField{
    
    convenience init(myframe: CGRect) {
        self.init(frame: myframe)
        self.leftViewMode = .always
        let view:UIView = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: frame.size.height))
        self.leftView = view
        self.clipsToBounds = true
    }
    convenience init(height: CGFloat=50) {
        self.init()
        self.leftViewMode = .always
        let view:UIView = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: height))
        self.leftView = view
        self.clipsToBounds = true
        
    }
   static public func createLoginTextFiled(height: CGFloat=50,placeholder:String?)-> UITextField
    {
        let text:UITextField = UITextField.init(height: height)
        text.layer.borderWidth = 1
        text.layer.borderColor = Color("0x999999").cgColor
        text.layer.cornerRadius = 5
        text.placeholder = placeholder
        return text
    }
}



