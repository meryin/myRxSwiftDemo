//
//  RequestPlugin.swift
//  myRxSwiftDemo
//
//  Created by 尹彩霞 on 2017/12/22.
//  Copyright © 2017年 尹彩霞. All rights reserved.
//

import Foundation
import Moya
import Result
import SVProgressHUD


let newworkActivityPlugin = NetworkActivityPlugin { (change) -> () in
    
    
    switch(change){
        
    case .ended:
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
    case .began:
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
    }
}
struct AuthPlugin: PluginType {
    let token: String
    
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
        request.timeoutInterval = 30
        request.addValue(token, forHTTPHeaderField: "token")
        request.addValue("multipart/form-data", forHTTPHeaderField: "Content-Type")//value : "application/x-www-form-urlencoded; charset=utf-8,multipart/form-data"
        request.addValue("ios", forHTTPHeaderField: "platform")
        request.addValue("version", forHTTPHeaderField: Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String)
        return request
    }
}


public final class RequestLoadingPlugin: PluginType {
    
    public func willSend(_ request: RequestType, target: TargetType) {
       
        MBProgressHUD.showLoading("加载中...")
    }
    
    public func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        MBProgressHUD.dismissHUD()
        switch result {
        case .failure:
            MBProgressHUD.showError((result.error?.errorDescription)! )
            break
        case .success(let respnse):
            if respnse.statusCode != 200
            {
                MBProgressHUD.showError(respnse.description)
            }
            break
        }
        
    }
    
}
