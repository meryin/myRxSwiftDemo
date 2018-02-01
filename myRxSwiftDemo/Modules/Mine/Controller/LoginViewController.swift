//
//  LoginViewController.swift
//  myRxSwiftDemo
//
//  Created by 尹彩霞 on 2017/12/5.
//  Copyright © 2017年 尹彩霞. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    let viewModel:loginViewModel = loginViewModel()
    var nameText:UITextField?
    var passText:UITextField?
    var button:UIButton?
    let nameLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "登录"
        
        let bu = UIButton.init(title: "注册", titleColor: UIColor.red, fontSize: 14)
        bu.frame = CGRect(x: 0, y: 0, width: 50, height: 25)
        bu.rx.tap.bind{
//            self.navigationController?.pushViewController(ChangHeadImageViewController(), animated: true)
                    self.navigationController?.pushViewController(RgisterViewController(), animated: true)
        }.disposed(by: disposeBag)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: bu)
        initUI()
        setupValid()
    }
    func initUI()
    {
        nameText = UITextField.createLoginTextFiled(height:50,placeholder:"用户名 字母或者数字组合 4到16位")
        passText = UITextField.createLoginTextFiled(height:50,placeholder:"密码 字母数字加下划线，6到18位")
        button = UIButton(backGroundColor:Color("0x42c02e"),title:"登录",titleColor:Color("0xffffff"),target:nil,action:nil )
        self.view.addSubview(nameText!)
        self.view.addSubview(passText!)
        self.view.addSubview(button!)
        self.view.addSubview(nameLabel)
        nameLabel.textColor = UIColor.red
        nameLabel.text = "用户名 字母或者数字组合 4到16位"
        
        button!.setCoradius(5.0)
        button!.isEnabled = false
        button!.setBackGroundColor(color: UIColor.gray, .disabled)
        
        nameText!.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(20)
            make.right.equalTo(self.view).offset(-20)
            make.top.equalTo(self.view).offset(110)
            make.height.equalTo(50)
        }
        nameLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(nameText!)
            make.top.equalTo(nameText!.snp.bottom).offset(20)
            make.height.equalTo(20)
        }
        passText!.snp.makeConstraints { (make) in
            make.left.right.equalTo(nameText!)
            make.top.equalTo(nameLabel.snp.bottom).offset(20)
            make.height.equalTo(nameText!.snp.height)
        }
        button!.snp.makeConstraints { (make) in
            make.left.right.equalTo(nameText!)
            make.top.equalTo(passText!.snp.bottom).offset(30)
            make.height.equalTo(nameText!.snp.height)
        }
    }
    
    func setupValid()
    {
        viewModel.vc = self
        nameText!.rx.text.orEmpty
            .bind(to:viewModel.username)
            .addDisposableTo(disposeBag)
        passText!.rx.text.orEmpty
            .bind(to:viewModel.passwd)
            .addDisposableTo(disposeBag)
        
        viewModel.isLoginEnable
            .bind(to:button!.rx.isEnabled)
            .addDisposableTo(disposeBag)
        // 发起登录操作
         button!.rx.tap
            .bind(to:viewModel.loginTaps)
            .disposed(by: disposeBag)
        
        //drive :不能出错 在主线程 资源共享
//        nameText!.rx.text.orEmpty.asDriver()
//            .map{
//                username in
//                return username =~ UsernameRegex
//        }.drive(nameLabel.rx.isHidden)
//        .disposed(by: disposeBag)
        nameText!.rx.text.orEmpty
            .map{ [unowned self]
                username in
                if username =~ UsernameRegex
                {
                    UIView.animate(withDuration: 0.3, animations: {
                        self.nameLabel.snp.updateConstraints{ (make) in
                            make.height.equalTo(0)
                            make.top.equalTo(self.nameText!.snp.bottom).offset(0)
                        }
                    })
                }
                else
                {
                    UIView.animate(withDuration: 0.3, animations: {
                        self.nameLabel.snp.updateConstraints{ (make) in
                            make.height.equalTo(20)
                            make.top.equalTo(self.nameText!.snp.bottom).offset(20)
                        }
                    })
                }
                return username =~ UsernameRegex
        }.bind(to: nameLabel.rx.isHidden)
        .disposed(by: disposeBag)
    }
   
    

}
