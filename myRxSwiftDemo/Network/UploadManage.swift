//
//  UploadManage.swift
//  myRxSwiftDemo
//
//  Created by 尹彩霞 on 2018/1/31.
//  Copyright © 2018年 尹彩霞. All rights reserved.
//

import Foundation
import Alamofire

func getUserHeadImageName(name:String)->String{
    guard let my = UserInfoModel.getUserInforModel() else {
        MBProgressHUD.showError("请先登录")
        return ""
    }
    let user_id = String(describing: my.user_id!)
    let date = Date()
    let timeFormatter = DateFormatter()
    timeFormatter.dateFormat = "yyyy-MM-dd-HH:mm:ss"
    let strNowTime:String = timeFormatter.string(from: date)
    return user_id + "_" + strNowTime + "_" + name + ".jpg"
}

//上传图片到服务器
func uploadImage(imageData : Data,filename:String,url:String,blcok: @escaping ([String: Any]?) -> Void){
     MBProgressHUD.showLoading("上传图片中...")
    
    let uploadURL = BaseURL + url
    guard let my = UserInfoModel.getUserInforModel() else {
        blcok(nil)
        MBProgressHUD.showError("请先登录")
        return 
    }
    let user_id = String(describing: my.user_id!)
    Alamofire.upload(
        multipartFormData: { multipartFormData in
            //采用post表单上传
            //withName:和后台服务器的name要一致
            multipartFormData.append(imageData, withName: "image", fileName: filename, mimeType: "image/jpeg")
            multipartFormData.append(user_id.data(using: String.Encoding.utf8)!, withName: "uploaded_by")
            multipartFormData.append(filename.data(using: String.Encoding.utf8)!, withName: "filename")
    },to: uploadURL,encodingCompletion: { encodingResult in
        switch encodingResult {
        case .success(let upload, _, _):
            upload.responseJSON { response in
                guard let result = response.result.value else {
                    blcok(nil)
                    MBProgressHUD.showError("上传图片失败")
                    return
                }
                print("json:\(result)")
                guard let dict = result as? [String: Any] else {
                    blcok(nil)
                    MBProgressHUD.showError("上传图片失败")
                    return
                }
                guard let image = dict["result"] as? [String: Any] else{
                    blcok(nil)
                    MBProgressHUD.showError("上传图片失败")
                    return
                }
                MBProgressHUD.showSuccess("上传图片成功")
                blcok(image)
            }
            upload.uploadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                print("图片上传进度: \(progress.fractionCompleted)")
            }
        case .failure(let encodingError):
            MBProgressHUD.showError(encodingError as! String)
            blcok(nil)
            return
        }
    })
}


func postData(url:String,param:[String:String],blcok: @escaping ([String: Any]?) -> Void)
{
    guard let my = UserInfoModel.getUserInforModel() else {
        blcok(nil)
        MBProgressHUD.showError("请先登录")
        return
    }
    let user_id = String(describing: my.user_id!)
    var parameters = ["user_id":user_id]
    for (key, value) in param {
        parameters[key] = value
    }
    let urlString = BaseURL + "/haveFun/" + url
    Alamofire.request(urlString, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).validate()
        .responseJSON { response in
            switch response.result {
            case .success(let value):
                print("数据获取成功!",value)
                
            case .failure(let error):
                print(error)
            }
    }
    
}


////多图片并列上传
func groupUpload(datas: [Data],url:String, success: @escaping (Array<String>?) -> Void) {
    
    // 创建队列组
    let group = DispatchGroup()
    var results:Array<String> = []
    for idnex in 0..<datas.count {
        group.enter()
        Thread.sleep(forTimeInterval: 0.5)
        let name = getUserHeadImageName(name: String(idnex))
        uploadImage(imageData: datas[idnex], filename: name, url: url, blcok: { (dict) in
            guard (dict != nil) else{
                group.leave()
                group.notify(queue: .main) {
                    success(nil)
                }
                return
    
            }
            guard let image = dict!["image"] as? String else
            {
                group.leave()
                group.notify(queue: .main) {
                    success(nil)
                }
                return
                
            }
            Thread.sleep(forTimeInterval: 0.5)
            results.append("--img--" + "\(idnex)" + "--image:--" + image)
            group.leave()
        })
    }
    
    group.notify(queue: .main) {
        MBProgressHUD.showSuccess("图片全部上传完成")
        success(results)
    }
}


//串行上传
func postPhotoSerialQueue(datas: [Data],url:String, success: @escaping ([String: Any]?) -> Void)
{
    func async_serial() {
        // 1、创建一个串行队列
        let serialQueue = DispatchQueue(label: "Mazy", attributes: .init(rawValue: 0))
        // 异步执行三个任务
        serialQueue.async {
            print("1 + \(Thread.current)")
        }
        serialQueue.async {
            print("2 + \(Thread.current)")
        }
        serialQueue.async {
            print("3 + \(Thread.current)")
        }
    }
}
