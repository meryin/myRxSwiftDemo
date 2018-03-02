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

let BaseURL = "http://192.168.38.50:8000"


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
private func endpointMapping<Target: TargetType>(target: Target) -> Endpoint<Target> {
    
    print("请求连接：\(target.baseURL)\(target.path) \n方法：\(target.method)\n参数：\(String(describing: target.task)) ")
    
    return MoyaProvider.defaultEndpointMapping(for: target)
}

let provider :RxMoyaProvider<APIManager> = RxMoyaProvider<APIManager>(endpointClosure: failureEndpointClosure,manager:defaultAlamofireManager(),plugins:[RequestLoadingPlugin(),NetworkLoggerPlugin(verbose: true,responseDataFormatter:JSONResponseDataFormatter), newworkActivityPlugin,AuthPlugin(token: "暂时为空")])

let gitHubProvider = MoyaProvider<APIManager>(endpointClosure: failureEndpointClosure,manager:defaultAlamofireManager(),plugins:[RequestLoadingPlugin(),NetworkLoggerPlugin(verbose: true,responseDataFormatter:JSONResponseDataFormatter), newworkActivityPlugin,AuthPlugin(token: "暂时为空")])

 func JSONResponseDataFormatter(_ data: Data) -> Data {
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
    case changeUserInfor(key:String,value:String,user_id:Int)
    case tagListByUser(user_id:Int)
    case uploadArtical(title:String,imageName:String,content:String,user_id:Int,tag_id:Int)
    case uploadTag(tag_name:String,tag_img:String,tag_abstract:String,user_id:Int)
    case getUserInfor(user_id:Int)
    
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
        case .changeUserInfor(_,_,_):
            return "change_user_infor"
        case .tagListByUser(_):
            return "artical_tags"
        case .uploadArtical(_,_,_,_,_):
            return "artical_upload"
        case .uploadTag(_,_,_,_):
            return "artical_tag_create"
        case .getUserInfor(_):
            return ""
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
        case .changeUserInfor(let key, let value, let user_id):
            return "{\"\(key)\": \"\(value)\", \"user_id\":\"\(user_id)\"}".data(using: String.Encoding.utf8)!
        default:
            return "".data(using: String.Encoding.utf8)!
        }
    }
    
    var headers: [String: String]? {
        return nil
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
        case .changeUserInfor(let key, let value,let user_id):
            return [key:value,"user_id":user_id]
        case .tagListByUser(let user_id):
            return ["user_id":user_id]
        case .uploadArtical(let title,let imageName,let content,let user_id,let tag_id):
            return ["title":title,"imageName":imageName,"content":content,"user_id":user_id,"tag_id":tag_id]
        case .uploadTag(let tag_name,let tag_img,let tag_abstract,let user_id):
            return ["tag_name":tag_name,"tag_img":tag_img,"tag_abstract":tag_abstract,"user_id":user_id]
        default:
            return [:]
            
        }
    }
    
    /// The method used for parameter encoding.
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
     
}
