//
//  ArticalModel.swift
//  myRxSwiftDemo
//
//  Created by 尹彩霞 on 2017/12/12.
//  Copyright © 2017年 尹彩霞. All rights reserved.
//

import UIKit
import ObjectMapper



class ArticalModel: PageBasicModel {
    
    
    var article_id:Int?
    var title:String?
    var content:String?
    var pubTime:String?
    var read:Int?
    var collect:Int?
    var command:Int?
    var image:String?
    var owner: UserInfoModel?
    var tag: ArticalTagModel?
    
    required init?(map: Map) {
        super.init(map:map)
    }
    
   override public func mapping(map: Map) {
        article_id <- map["article_id"]
        title <- map["title"]
        content <- map["content"]
        pubTime <- map["pubTime"]
        read <- map["read"]
        collect <- map["collect"]
        command <- map["command"]
        image <- map["image"]
        owner <- map["owner"]
        tag <- map["tag"]
    }
}

