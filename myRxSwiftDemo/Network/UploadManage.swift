//
//  UploadManage.swift
//  myRxSwiftDemo
//
//  Created by 尹彩霞 on 2018/1/31.
//  Copyright © 2018年 尹彩霞. All rights reserved.
//

import Foundation
import Alamofire

func getUserHeadImageName()->String{
    guard let my = UserInfoModel.getUserInforModel() else {
        MBProgressHUD.showError("请先登录")
        return ""
    }
    let user_id = String(describing: my.user_id!)
    let date = Date()
    let timeFormatter = DateFormatter()
    timeFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let strNowTime:String = timeFormatter.string(from: date)
    return user_id + "_head_image" + strNowTime + ".jpg"
}


//上传图片到服务器
func uploadImage(imageData : Data,filename:String,url:String,blcok: @escaping ([String: Any]?) -> Void){
     MBProgressHUD.showLoading("上传中...")
    
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
            multipartFormData.append(user_id.data(using: String.Encoding.utf8)!, withName: "user_id")
            
            
    },to: uploadURL,encodingCompletion: { encodingResult in
        switch encodingResult {
        case .success(let upload, _, _):
            upload.responseJSON { response in
                guard let result = response.result.value else {
                    blcok(nil)
                    MBProgressHUD.showError("上传失败")
                    return
                    
                }
                print("json:\(result)")
                guard let dict = result as? [String: Any] else {
                    blcok(nil)
                    MBProgressHUD.showError("上传失败")
                    return
                }
                guard let image = dict["result"] as? [String: Any] else{
                    blcok(nil)
                    MBProgressHUD.showError("上传失败")
                    return
                    
                }
                MBProgressHUD.showSuccess("上传成功")
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
