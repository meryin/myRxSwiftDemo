//
//  Tools.swift
//  myRxSwiftDemo
//
//  Created by 尹彩霞 on 2017/11/20.
//  Copyright © 2017年 尹彩霞. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class Tools: NSObject {
    static func colorWithHex(hexValue:NSInteger,alpha:CGFloat)->UIColor
    {
        return UIColor(red: ((CGFloat)((hexValue & 0xFF0000) >> 16))/255.0, green: ((CGFloat)((hexValue & 0xFF00) >> 8))/255.0, blue: ((CGFloat)(hexValue & 0xFF))/255.0, alpha: alpha)
    }
    static func colorWithHexString(stringValue:String,alpha:CGFloat) -> UIColor
    {
//        0xffffff格式
        let hex = stringValue.hexStringToInt()
        return Tools.colorWithHex(hexValue: hex, alpha: alpha)
    }
    
    class func imageWithColor(color:UIColor) -> UIImage
    {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)  
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
   static func fileSizeOfCache()-> String {
        // 取出cache文件夹目录 缓存文件都在这个目录下
        let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        //缓存目录路径
        // 取出文件夹下所有文件数组
        let fileArr = FileManager.default.subpaths(atPath: cachePath!)
        //快速枚举出所有文件名 计算文件大小
        var size = 0
        for file in fileArr! {
            // 把文件名拼接到路径中
            let path = (cachePath! as NSString).appending("/\(file)")
            // 取出文件属性
            let floder = try! FileManager.default.attributesOfItem(atPath: path)
            // 用元组取出文件大小属性
            for (abc, bcd) in floder {
                // 累加文件大小
                if abc == FileAttributeKey.size {
                    size += (bcd as AnyObject).integerValue
                }
            }
        }
        let mm = Float(size) / 1024.00 / 1024.00
        return String(format: "%.2f", mm) + "M"
    }
   static func clearCache() {
        // 取出cache文件夹目录 缓存文件都在这个目录下
        let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        // 取出文件夹下所有文件数组
        let fileArr = FileManager.default.subpaths(atPath: cachePath!)
        // 遍历删除
        for file in fileArr! {
            let path = (cachePath! as NSString).appending("/\(file)")
            if FileManager.default.fileExists(atPath: path) {
                do {
                    try FileManager.default.removeItem(atPath: path)
                } catch {
                    
                }
            }
        }
    }

}


