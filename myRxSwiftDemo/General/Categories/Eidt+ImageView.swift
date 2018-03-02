//
//  Eidt+ImageView.swift
//  myRxSwiftDemo
//
//  Created by 尹彩霞 on 2017/12/7.
//  Copyright © 2017年 尹彩霞. All rights reserved.
//

import UIKit

import Kingfisher

extension UIImageView{
    
    /// 快速创建 imageView
    /// - parameter imgName:  图片名字
    convenience init(imgName: String) {
        self.init(image: UIImage(named:imgName))
    }
    
    
    /// - parameter withUrlString:      图片的 urlString
    /// - parameter placeholderImgName:  默认图片的名字
    func mb_setImage(withUrlString: String?, placeholderImgName: String?){
        // 获取图片的 url
        if (withUrlString != nil)
       {
        var url = URL(string: BaseURL + withUrlString!)
        if (withUrlString?.contains("http"))!
        {
           url = URL(string:withUrlString!)
        }
        self.kf.setImage(with: url, placeholder: UIImage(named:placeholderImgName!), options: nil, progressBlock: { (key1, key2) in
            
        }, completionHandler: { (image, error, type, url) in
            self.image = image
        })

        }
        
    }
    
    
    
}

