//
//  MainTableViewCell.swift
//  myRxSwiftDemo
//
//  Created by 尹彩霞 on 2017/11/22.
//  Copyright © 2017年 尹彩霞. All rights reserved.
//

import UIKit
import SnapKit

class MainTableViewCell: UITableViewCell {
    var headImg:UIImageView?
    var userLabel:UILabel?
    var timeLabel:UILabel?
    var titleLabel:UILabel?
    var adstraLabel:UILabel?
    var commandLabel:UILabel?
    var readLabel:UILabel?
    var collectLabel:UILabel?
    var contentImg:UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        headImg = UIImageView(image: UIImage(named: "Ico_MCustomerCenter")!)
        self.contentView.addSubview(headImg!)
        userLabel = UILabel(font: 12, textColor: Color("0x333333"))
        
        self.contentView.addSubview(userLabel!)
        timeLabel = UILabel(font: 12, textColor: Color("0x999999"))
        self.contentView.addSubview(timeLabel!)
        titleLabel = UILabel(font: 16, textColor: Color("0x111111"))
        self.contentView.addSubview(titleLabel!)
        adstraLabel = UILabel(font: 14, textColor: Color("0x333333"))
        adstraLabel?.numberOfLines = 0
        self.contentView.addSubview(adstraLabel!)
        contentImg = UIImageView()
        self.contentView.addSubview(contentImg!)
        commandLabel = UILabel(textAlign: NSTextAlignment.right, font: 12, textColor: Color("0x999999"))
        self.contentView.addSubview(commandLabel!)
        readLabel = UILabel(textAlign: NSTextAlignment.right, font: 12, textColor: Color("0x999999"))
        self.contentView.addSubview(readLabel!)
        collectLabel = UILabel(textAlign: NSTextAlignment.right, font: 12, textColor: Color("0x999999"))
        self.contentView.addSubview(collectLabel!)
       contentImg?.backgroundColor = UIColor.gray
        headImg?.layer.cornerRadius = 10
        headImg?.clipsToBounds = true
        
        headImg!.snp.makeConstraints { (make) -> Void in
            make.width.height.equalTo(20)
            make.left.equalTo(15)
            make.top.equalTo(3)
        }
        userLabel!.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(self.timeLabel!.snp.left).offset(-5)
            make.left.equalTo(self.headImg!.snp.right).offset(5)
            make.top.equalTo(3)
            make.bottom.equalTo(self.headImg!.snp.bottom)
        }
        timeLabel!.snp.makeConstraints { (make) -> Void in
            make.right.greaterThanOrEqualTo(-15)
            make.left.equalTo(self.userLabel!.snp.right).offset(5)
            make.top.equalTo(3)
            make.bottom.equalTo(self.headImg!.snp.bottom)
        }
        
        
        titleLabel!.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(18)
            make.left.equalTo(15)
            make.top.equalTo(self.headImg!.snp.bottom).offset(5)
            make.right.equalTo(self.contentImg!.snp.left).offset(-5)
        }
        adstraLabel!.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(38)
            make.left.equalTo(15)
            make.top.equalTo(self.titleLabel!.snp.bottom)
            make.right.equalTo(self.contentImg!.snp.left).offset(-5)
        }
        contentImg!.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(self.adstraLabel!.snp.bottom)
            make.top.equalTo(self.titleLabel!.snp.top)
            make.right.equalTo(-15)
            make.width.equalTo(contentImg!.snp.height)
        }
        
        collectLabel!.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(-3)
            make.left.equalTo(self.commandLabel!.snp.right).offset(5)
            make.top.equalTo(self.adstraLabel!.snp.bottom).offset(3)
            make.right.equalTo(-15)
        }
        commandLabel!.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(self.collectLabel!.snp.bottom)
            make.left.equalTo(self.readLabel!.snp.right).offset(5)
            make.top.equalTo(self.collectLabel!.snp.top)
            make.right.equalTo(self.collectLabel!.snp.left).offset(-5)
        }
        readLabel!.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(self.collectLabel!.snp.bottom)
            make.top.equalTo(self.collectLabel!.snp.top)
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
