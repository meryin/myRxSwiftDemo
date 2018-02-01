//
//  APIManager.swift
//  myRxSwiftDemo
//
//  Created by 尹彩霞 on 2017/12/21.
//  Copyright © 2017年 尹彩霞. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import RxCocoa
import Alamofire

let BaseURL = "http://192.168.38.127:8000"


public func defaultAlamofireManager() -> Manager {
    let configuration = URLSessionConfiguration.default
    configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
    
    let policies: [String: ServerTrustPolicy] = [
        
        "ap.grtstar.cn": .disableEvaluation
    ]
    let manager = Alamofire.SessionManager(configuration: configuration,serverTrustPolicyManager: ServerTrustPolicyManager(policies: policies))
    
    manager.startRequestsImmediately = false
    return manager
}



func url(_ route: TargetType) -> String {
    let str = route.baseURL.appendingPathComponent(route.path).absoluteString
    NSLog("url=%@", str)
    return str
}

let failureEndpointClosure = { (target: APIManager) -> Endpoint<APIManager> in
    let error = NSError(domain: "com.moya.moyaerror", code: 0, userInfo: [NSLocalizedDescriptionKey: "Houston, we have a problem"])
    return Endpoint<APIManager>(url: url(target), sampleResponseClosure: {.networkError(error)}, method: target.method, task: target.task, httpHeaderFields: target.headers)
}

//
let provider :RxMoyaProvider<APIManager> = RxMoyaProvider<APIManager>(endpointClosure: failureEndpointClosure,manager:defaultAlamofireManager(),plugins:[RequestLoadingPlugin(),NetworkLoggerPlugin(verbose: true,responseDataFormatter:JSONResponseDataFormatter), newworkActivityPlugin,AuthPlugin(token: "暂时为空")])

private func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data //fallback to original data if it cant be serialized
    }
}
//AccessTokenPlugin 管理AccessToken的插件
//CredentialsPlugin 管理认证的插件
//NetworkActivityPlugin 管理网络状态的插件
//NetworkLoggerPlugin 管理网络log的插件


enum APIManager: TargetType {
    var baseURL: URL {
        return URL(string: BaseURL + "/haveFun/")!
        
    }
    
    
    case login(name:String,passwd:String)
    case upload(image:UIImage)
    case homeList(page:Int)
    case TagList
    case Register(name:String,phone:String,passwd:String)
    case uploadURL(fileURL:URL) //上传文件
    
    var path: String {
        switch self {
        case .login(_,_):
            return "login"
        case .upload(_):
            return "upload_head_image"
        case .homeList(_):
            return "articals"
        case .TagList:
            return "articalTags"
        case .Register(_, _, _):
            return "register"
        case .uploadURL(_):
            return "upload_head_image"
        }
    }
    
    var method: Moya.Method {
        return .post
        
    }
    
    var task: Task {
        switch self {
        case  .login(_,_):
            return .requestParameters(parameters: parameters!, encoding: parameterEncoding)
        case .upload(let image):
            let data = UIImageJPEGRepresentation(image, 0.3)
            let img = MultipartFormData(provider: .data(data!), name: "image", fileName: "test.jpg", mimeType: "image/jpeg")
            let my = UserInfoModel.getUserInforModel()
            return .uploadCompositeMultipart([img], urlParameters: ["user_id": my!.user_id ?? "1"])
        case .uploadURL(let fileURL):
            return .uploadFile(fileURL)
            
        default:
            return .requestParameters(parameters: parameters!, encoding: parameterEncoding)
        }
    }
    
    //这个就是做单元测试模拟的数据，必须要实现，只在单元测试文件中有作用
    var sampleData: Data {
        switch self {
        case .login(let name, let passwd):
            return "{\"name\": \"\(name)\", \"passwd\":\"\(passwd)\"}".data(using: String.Encoding.utf8)!
        case .homeList(let page):
            return "{\"page\": \"\(page)\"}".data(using: String.Encoding.utf8)!
        
        default:
            return "".data(using: String.Encoding.utf8)!
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .upload(_):
            return ["Content-Type":"multipart/form-data"]
        default:
            return nil
        }
    }
    var validate: Bool {
        return false
    }
    
    
    var parameters: [String: Any]? {
        switch self {
       
        case .homeList(let page):
            return ["page" : page,"page_size":10]
        case .login(let name, let passwd):
            return ["name" : name, "passwd" :  passwd]
        case .Register(let name, let phone, let passwd):
            return ["name":name,"phone":phone,"passwd":passwd,"user_type":"1"]
       
        default:
            return [:]
            
        }
    }
    
    /// The method used for parameter encoding.
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
     
}
