//
//  AuthorInforView.swift
//  myRxSwiftDemo
//
//  Created by 尹彩霞 on 2018/3/2.
//  Copyright © 2018年 尹彩霞. All rights reserved.
//

import UIKit
import SnapKit

class AuthorInforView: UIView {
    
    var author: String? {
        get{
            //返回成员变量
            return _author;
        }
        set{
            //使用 _成员变量 记录值
            _name = newValue;
        }
    }
    
    var headImg:UIImageView = UIImageView()
    var userLabel:UILabel = UILabel.init(text: "", font: 14, textColor: Color("0x333333"))
    var abstractLabel:UILabel = UILabel.init(text: "", font: 10, textColor: Color("0x999999"))
    override func draw(_ rect: CGRect) {
        self.addSubview(headImg)
        self.addSubview(userLabel)
        self.addSubview(abstractLabel)
        
        headImg.snp.makeConstraints { (make) -> Void in
            make.width.height.equalTo(26)
            make.left.equalTo(0)
            make.centerY.equalTo(0)
        }
        userLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self.headImg.snp.right).offset(5)
            make.top.equalTo(headImg.snp.top)
            make.height.equalTo(15)
        }
        userLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self.headImg.snp.right).offset(5)
            make.top.equalTo(userLabel.snp.bottom)
            make.bottom.equalTo((headImg.snp.bottom))
        }
    }
 

}
