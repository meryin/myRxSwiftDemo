//
//  TagListTableViewCell.swift
//  myRxSwiftDemo
//
//  Created by 尹彩霞 on 2018/2/7.
//  Copyright © 2018年 尹彩霞. All rights reserved.
//

import UIKit

class TagListTableViewCell: UITableViewCell {
    let imgview = UIImageView.init(imgName: "Ico_Main_Adv_aqy")
    let titleLabel = UILabel.init(text: "", font: 14, textColor: Color("0x111111"))
    let abstrLabel = UILabel.init(text: "", font: 11, textColor: Color("0x999999"))
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(imgview)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(abstrLabel)
        imgview.snp.makeConstraints { (make) -> Void in
//            make.bottom.equalTo(-15)
            make.left.equalTo(15)
            make.top.equalTo(15)
            make.width.height.equalTo(40)
            
        }
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(abstrLabel.snp.height)
            make.left.equalTo(imgview.snp.right).offset(8)
            make.top.equalTo(15)
            make.right.equalTo(-15)
        }
        abstrLabel.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(titleLabel.snp.height)
            make.left.equalTo(imgview.snp.right).offset(8)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(5)
            make.right.equalTo(-15)
            make.bottom.equalTo(-15)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
