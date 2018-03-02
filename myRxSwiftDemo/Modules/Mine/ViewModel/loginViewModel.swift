//
//  loginViewModel.swift
//  myRxSwiftDemo
//
//  Created by 尹彩霞 on 2017/12/7.
//  Copyright © 2017年 尹彩霞. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Moya



class loginViewModel: NSObject {
    
    let username = Variable<String>("")
    let passwd = Variable<String>("")
    var isLoginEnable = Observable<Bool>.just(false)
    
    let loginTaps = PublishSubject<Void>()
    var vc:UIViewController?
    let disposeBag = DisposeBag()
 
    override init() {
        super.init()
        let usernameUsable = username.asObservable()
            .map{ username in
                return username =~ UsernameRegex
            }
            .shareReplay(1)
        let passwordValidate = passwd.asObservable()
            .map{ password in
                return password =~ PasswordRegex
            }
            .shareReplay(1)
        self.isLoginEnable = Observable.combineLatest(usernameUsable, passwordValidate).map{ return $0 && $1 }.shareReplay(1)
        
        self.loginTaps.asObservable().subscribe{ (event : Event<Void>) in
       
            provider
                .request(.login(name:self.username.value,passwd:self.passwd.value))
                .filterSuccessfulStatusCodes()
                .mapJSON().asObservable()
                .mapObject(type: UserInfoModel.self)
                .subscribe(onNext: { (UserModel) in
                    if ( UserModel.name?.isEmpty == false )
                    {
                        UserInfoModel.saveUserInforModel(UserModel)
                        self.vc?.navigationController?.popToRootViewController(animated: true)
                    }
                    NSLog("%@", UserModel )
                    
                }).addDisposableTo(self.disposeBag)
            }.addDisposableTo(disposeBag)
           
    }
    class  func changeUserInfor(view:UITableView,key:String,value:String)
    {
        guard let my = UserInfoModel.getUserInforModel() ,let user_id = my.user_id else {
            MBProgressHUD.showError("请先登录")
            return
        }
        gitHubProvider.request(.changeUserInfor(key: key, value: value,user_id:user_id)) { result in
            if case let .success(response) = result {
                let UserModel = try? response.mapObject(UserInfoModel.self)                
                if ( UserModel?.name?.isEmpty == false )
                {
                    UserInfoModel.saveUserInforModel(UserModel!)
                    view.reloadData()
                }
 
            }
            else {
                MBProgressHUD.showError((result.error?.errorDescription)! )
            }
  
        }
        
    }
   
}


class RegisterViewModel: NSObject {
    let username = Variable<String>("")
    let phone = Variable<String>("")
    let passAgain = Variable<String>("")
    let passwd = Variable<String>("")
    var isRegisterEnable = Observable<Bool>.just(false)
    let registerTaps = PublishSubject<Void>()
    let disposeBag = DisposeBag()
    var vc:UIViewController?
    override init() {
        super.init()
        let usernameUsable = username.asObservable()
            .map{ username in
                return username =~ UsernameRegex
            }
            .shareReplay(1)
        let phoneUsable = phone.asObservable()
            .map{ phone in
                return phone =~ isIphoneNumRegex
            }
            .shareReplay(1)
        let passwordValidate = Observable.combineLatest(passwd.asObservable(), passAgain.asObservable()).map{ return ($0 == $1 )&&($0 =~ PasswordRegex)}
            .shareReplay(1)
        
        self.isRegisterEnable = Observable.combineLatest(usernameUsable, passwordValidate,phoneUsable).map{ return $0 && $1 && $2 }.shareReplay(1)
        
        self.registerTaps.asObservable().subscribe{ (event : Event<Void>) in
            provider
                .request(.Register(name:self.username.value,phone:self.phone.value,passwd:self.passwd.value))
                .filterSuccessfulStatusCodes()
                .mapJSON().asObservable()
                .mapObject(type: UserInfoModel.self)
                .subscribe(onNext: { (UserModel) in
                    if ( UserModel.name?.isEmpty == false )
                    {
                        UserInfoModel.saveUserInforModel(UserModel)
                        self.vc?.navigationController?.popToRootViewController(animated: true)
                    }
                    NSLog("%@", UserModel )
                    
                }).addDisposableTo(self.disposeBag)
        
        }.addDisposableTo(disposeBag)
    }
    
}
