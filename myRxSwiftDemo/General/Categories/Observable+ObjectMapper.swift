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


