//
//  UserBasicInfoModel.swift
//  myRxSwiftDemo
//
//  Created by 尹彩霞 on 2017/12/12.
//  Copyright © 2017年 尹彩霞. All rights reserved.
//

import UIKit
import ObjectMapper

class UserInfoModel:NSObject, NSCoding, Mappable {
    
    var user_id:Int?
    var name:String?
    var phone:String?
    var time_join:String?
    var sex:Int?
    var age:Int?
    var address:String?
    var email:String?
    var img:String?
    var user_type:Int?
    var article_count: Int?
    var artical_tag_count: Int?
    
    required init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        user_id <- map["user_id"]
        name <- map["name"]
        phone <- map["phone"]
        time_join <- map["time_join"]
        sex <- map["sex"]
        age <- map["age"]
        address <- map["address"]
        email <- map["email"]
        img <- map["img"]
        user_type <- map["user_type"]
        article_count <- map["article_count"]
        artical_tag_count <- map["artical_tag_count"]
    }
    //从object解析回来
    required init(coder decoder: NSCoder) {
        self.user_id = decoder.decodeObject(forKey: "user_id") as? Int ?? nil
        self.name = decoder.decodeObject(forKey: "name") as? String ?? ""
        self.phone = decoder.decodeObject(forKey: "phone") as? String ?? ""
        self.time_join = decoder.decodeObject(forKey: "time_join") as? String ?? nil
        self.sex = decoder.decodeObject(forKey: "sex") as? Int ?? nil
        self.age = decoder.decodeObject(forKey: "age") as? Int ?? nil
        self.address = decoder.decodeObject(forKey: "address") as? String ?? ""
        self.email = decoder.decodeObject(forKey: "email") as? String ?? nil
        self.img = decoder.decodeObject(forKey: "img") as? String ?? nil
        self.user_type = decoder.decodeObject(forKey: "user_type") as? Int ?? nil
        self.article_count = decoder.decodeObject(forKey: "article_count") as? Int ?? nil
        self.artical_tag_count = decoder.decodeObject(forKey: "artical_tag_count") as? Int ?? nil
    }
    
    //编码成object
    func encode(with coder: NSCoder) {
        coder.encode(user_id, forKey:"user_id")
        coder.encode(name, forKey:"name")
        coder.encode(phone, forKey:"phone")
        coder.encode(time_join, forKey:"time_join")
        coder.encode(sex, forKey:"sex")
        coder.encode(age, forKey:"age")
        coder.encode(address, forKey:"address")
        coder.encode(email, forKey:"email")
        coder.encode(img, forKey:"img")
        coder.encode(user_type, forKey:"user_type")
        coder.encode(article_count, forKey:"article_count")
        coder.encode(artical_tag_count, forKey:"artical_tag_count")
   
    }
    init?(json: Any) {
       
    }
    
    static func getUserInforModel()-> UserInfoModel?
    {
        let myModelData = UserDefaults.standard.data(forKey: UserBasicInforKey)
        if (myModelData != nil)
        {
            guard let my = NSKeyedUnarchiver.unarchiveObject(with: myModelData!) as? UserInfoModel
                else{
                    return nil
            }
            return my
        }
         return nil
    }
    static func saveUserInforModel(_ user:UserInfoModel)
    {
        
        let modelData = NSKeyedArchiver.archivedData(withRootObject: user)
        //存储Data对象
        UserDefaults.standard.set(modelData, forKey: UserBasicInforKey)
    }
}
