//
//  RgisterViewController.swift
//  myRxSwiftDemo
//
//  Created by 尹彩霞 on 2018/1/19.
//  Copyright © 2018年 尹彩霞. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class RgisterViewController: UIViewController {
    lazy var nameText = UITextField()
    lazy var phoneText = UITextField()
    lazy var passText = UITextField()
    lazy var passAgainText = UITextField()
    lazy var button = UIButton(type: .custom)
    
    let viewModel:RegisterViewModel = RegisterViewModel()
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "注册"
        initUI()
        setupValid()
    }

    func initUI()
    {
        nameText = UITextField.createLoginTextFiled(height:50,placeholder:"用户名 字母或者数字组合 4到16位")
        phoneText = UITextField.createLoginTextFiled(height:50,placeholder:"电话号码")
        passText = UITextField.createLoginTextFiled(height:50,placeholder:"密码 字母数字加下划线，6到18位")
        passAgainText = UITextField.createLoginTextFiled(height:50,placeholder:"重复密码")
        button = UIButton(backGroundColor:Color("0x42c02e"),title:"注册",titleColor:Color("0xffffff"),target:nil,action:nil )
        self.view.addSubview(nameText)
        self.view.addSubview(passText)
        self.view.addSubview(phoneText)
        self.view.addSubview(passAgainText)
        self.view.addSubview(button)
        
        button.setCoradius(5.0)
        button.isEnabled = false
        button.setBackGroundColor(color: UIColor.gray, .disabled)
        
        nameText.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(20)
            make.right.equalTo(self.view).offset(-20)
            make.top.equalTo(self.view).offset(90)
            make.height.equalTo(50)
        }
        phoneText.snp.makeConstraints { (make) in
            make.left.right.equalTo(nameText)
            make.top.equalTo(nameText.snp.bottom).offset(15)
            make.height.equalTo(nameText.snp.height)
        }
        passText.snp.makeConstraints { (make) in
            make.left.right.equalTo(nameText)
            make.top.equalTo(phoneText.snp.bottom).offset(15)
            make.height.equalTo(nameText.snp.height)
        }
        passAgainText.snp.makeConstraints { (make) in
            make.left.right.equalTo(nameText)
            make.top.equalTo(passText.snp.bottom).offset(15)
            make.height.equalTo(nameText.snp.height)
        }
        button.snp.makeConstraints { (make) in
            make.left.right.equalTo(nameText)
            make.top.equalTo(passAgainText.snp.bottom).offset(30)
            make.height.equalTo(nameText.snp.height)
        }
    }
    
    func setupValid()
    {
        viewModel.vc = self
        nameText.rx.text.orEmpty
            .bind(to:viewModel.username)
            .addDisposableTo(disposeBag)
        passText.rx.text.orEmpty
            .bind(to:viewModel.passwd)
            .addDisposableTo(disposeBag)
        phoneText.rx.text.orEmpty
            .bind(to:viewModel.phone)
            .addDisposableTo(disposeBag)
        passAgainText.rx.text.orEmpty
            .bind(to:viewModel.passAgain)
            .addDisposableTo(disposeBag)
        viewModel.isRegisterEnable
            .bind(to:button.rx.isEnabled)
            .addDisposableTo(disposeBag)
        // 发起注册操作
        button.rx.tap
            .bind(to:viewModel.registerTaps)
            .disposed(by: disposeBag)
       
    }
    

}
