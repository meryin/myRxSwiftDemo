//
//  ListCollectionViewCell.swift
//  myRxSwiftDemo
//
//  Created by 尹彩霞 on 2018/1/17.
//  Copyright © 2018年 尹彩霞. All rights reserved.
//

import UIKit

class ListCollectionViewCell: UICollectionViewCell {
    let backImgV = UIImageView()
    let titlLabel = UILabel()
    let contentLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func initUI()
    {
     
        let view = UIView(frame: CGRect(x: 5, y: 35, width: self.frame.size.width-10, height: self.frame.size.height-30))
        self.contentView.addSubview(view)
        view.backgroundColor = Color("0xf1f1f1")
        view.addSubview(titlLabel)
        view.addSubview(contentLabel)
        self.contentView.addSubview(backImgV)
        view.layer.cornerRadius = 5
        view.layer.borderColor = Color("0xf8f8f8").cgColor
        view.layer.borderWidth = 1
        backImgV.clipsToBounds = true
        backImgV.contentMode = .scaleAspectFill
        backImgV.frame = CGRect(x: self.frame.size.width/2.0-40, y: 10, width: 80, height: 50)
        titlLabel.frame = CGRect(x: 5, y: 30, width: self.frame.size.width-10, height: 20)
        contentLabel.frame = CGRect(x: 5, y: view.frame.size.height/2.0-10, width: self.frame.size.width-10, height: 40)
        titlLabel.font = UIFont.systemFont(ofSize: 15)
        contentLabel.font = UIFont.systemFont(ofSize: 14)
        titlLabel.textColor = Color("0x333333")
        contentLabel.textColor = Color("0x666666")
        titlLabel.textAlignment = .center
        contentLabel.textAlignment = .center
        contentLabel.numberOfLines = 2
        
    }
}
