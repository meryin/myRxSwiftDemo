//
//  ArticalTagModel.swift
//  myRxSwiftDemo
//
//  Created by 尹彩霞 on 2017/12/12.
//  Copyright © 2017年 尹彩霞. All rights reserved.
//

import UIKit
import ObjectMapper

class ArticalTagModel: Mappable {
    
    var tag_id:Int?
    var article_count:Int?
    var tag_name:String?
    var create_Time:String?
    var tag_abstract:String?
    var tag_img:String?
    var createdByUser: UserInfoModel?

    
    required init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        tag_id <- map["tag_id"]
        tag_name <- map["tag_name"]
        create_Time <- map["create_Time"]
        tag_abstract <- map["tag_abstract"]
        tag_img <- map["tag_img"]
        createdByUser <- map["createdByUser"]
        article_count <- map["article_count"]
       
    }
}
