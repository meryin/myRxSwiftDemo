
//
//  PageBasicModel.swift
//  myRxSwiftDemo
//
//  Created by 尹彩霞 on 2018/1/10.
//  Copyright © 2018年 尹彩霞. All rights reserved.
//

import Foundation
import ObjectMapper



class PageBasicModel: Mappable {
    var desc :String?
    var total:Int?
    var page:Int?
    var data :[ArticalModel]?
    
    
    required init?(map: Map) {
    }
    
     func mapping(map: Map) {
        desc <- map["desc"]
        total <- map["total"]
        page <- map["page"]
        data <- map["result"]
    }
}

