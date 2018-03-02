//
//  Observable+ObjectMapper.swift
//  myRxSwiftDemo
//
//  Created by 尹彩霞 on 2017/12/22.
//  Copyright © 2017年 尹彩霞. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import ObjectMapper
import Result



// MARK: - Json -> Observable<Model>
extension Observable {
    func mapObject<T: Mappable>(type: T.Type) -> Observable<T> {
        return self.map { response in
            
            guard let dict = response as? [String: Any] else {
                throw RxSwiftMoyaError.ParseJSONError
            }

            guard dict["result"]  != nil else{
                MBProgressHUD.showError(dict["desc"] as! String)
                throw RxSwiftMoyaError.ParseJSONError
            }
            MBProgressHUD.showSuccess(dict["desc"] as! String)
   
            return Mapper<T>().map(JSON: dict["result"] as! [String : Any])!
        }
    }
    
    //用于分页获取数据，包含数组
    func mapPageArrary<T: Mappable>(type: T.Type) -> Observable<T> {
        return self.map { response in
            
            guard let dict = response as? [String: Any] else {
                throw RxSwiftMoyaError.ParseJSONError
            }
            
            guard dict["result"]  != nil else{
                MBProgressHUD.showError(dict["desc"] as! String)
                throw RxSwiftMoyaError.ParseJSONError
            }
            MBProgressHUD.showSuccess(dict["desc"] as! String)
            return Mapper<T>().map(JSON: dict )!
        }
    }
    
    func mapArray<T: Mappable>(type: T.Type) -> Observable<[T]> {
        return self.map { response in
            guard let dict = response as? [String: Any] else {
                throw RxSwiftMoyaError.ParseJSONError
            }
            
            guard dict["result"]  != nil else{
                MBProgressHUD.showError(dict["desc"] as! String)
                throw RxSwiftMoyaError.ParseJSONError
            }
            MBProgressHUD.showSuccess(dict["desc"] as! String)
            return Mapper<T>().mapArray(JSONArray: dict["result"] as! [[String : Any]])
        }
    }
    
}




enum RxSwiftMoyaError: String {
    case ParseJSONError
    case OtherError
}

extension RxSwiftMoyaError: Swift.Error {
    
    
}

extension ObservableType {

    public func flatMapLatest<O: ObservableConvertibleType>(selector: @escaping  (Self.E) throws -> O,onError: (@escaping (Swift.Error) throws ->())) -> RxSwift.Observable<O.E> {

        return flatMapLatest({ x in
            try selector(x).asObservable().catchError({ error in

                try onError(error)

                return Observable.never()
            })
        })

    }

}

// MARK: - Json -> Model
extension Response {
    public func mapObjectResult() throws -> Bool {
        
        guard let json = try mapJSON() as? [String : Any] else {
            return false
        }
        
        if let jsondic = (json["result"] as? String)
        {
            MBProgressHUD.showSuccess(jsondic)
            return true
        }
        else if let des = (json["desc"] as? String){
            MBProgressHUD.showError(des)
            return false
        }
        return false
        
    }
    
    // 将Json解析为单个Model
    public func mapObject<T: BaseMappable>(_ type: T.Type) throws -> T {
        
        guard let json = try mapJSON() as? [String : Any] else {
            throw MoyaError.jsonMapping(self)
        }
        
        if let jsondic = (json["result"] as? [String : Any])
        {
            MBProgressHUD.showSuccess(json["desc"] as! String)
            guard let object = Mapper<T>().map(JSONObject: jsondic) else {
                throw MoyaError.jsonMapping(self)
            }
            
            return object
        }
        else {
            MBProgressHUD.showError(json["desc"] as! String)
            throw MoyaError.jsonMapping(self)
        }
        
        
    }
    
    // 将Json解析为多个Model，返回数组，对于不同的json格式需要对该方法进行修改
    public func mapArray<T:BaseMappable>(_ type: T.Type) throws -> [T] {
        
        guard let json = try mapJSON() as? [String : Any] else {
            throw MoyaError.jsonMapping(self)
        }
        
        if let jsonArr = (json["result"] as? [[String : Any]])
        {
             MBProgressHUD.showSuccess(json["desc"] as! String)
           return Mapper<T>().mapArray(JSONArray: jsonArr)
        }
        else {
            MBProgressHUD.showError(json["desc"] as! String)
            throw MoyaError.jsonMapping(self)
        }
        
        
    }
}
