//
//  MineViewController.swift
//  myRxSwiftDemo
//
//  Created by 尹彩霞 on 2017/11/20.
//  Copyright © 2017年 尹彩霞. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class MineViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    let disposeBag = DisposeBag()
    let headImgV:UIImageView = UIImageView(imgName: "Ico_MCustomerCenter")
    let nameLabel:UILabel = UILabel(textAlign: .center, font: 17, textColor: UIColor.black, numberOfLines: 1)
    let tableView = UITableView()
    let dataSource = ["我的文章","我的会馆","设置","退出登录"]
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        reloadView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadView()
    }
    func initUI()
    {
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        let topView:UIView = UIView(frame:CGRect(x: 0, y: 0, width: WindowWidth, height: 200))
        tableView.tableHeaderView = topView
        let view = UIView(frame:CGRect(x: 0, y: -WindowHeight, width: WindowWidth, height: WindowHeight))
        topView.addSubview(view)
        topView.addSubview(headImgV)
        topView.addSubview(nameLabel)
        view.backgroundColor = UIColor.white
        topView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        let w = WindowWidth * 0.22
        headImgV.corner(radii: w/2.0)
        headImgV.clipsToBounds = true
        headImgV.snp.makeConstraints { (make) in
            make.width.height.equalTo(w)
            make.centerX.equalTo(topView)
            make.top.equalTo(topView).offset(45)
        }
        nameLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(topView)
            make.top.equalTo(headImgV.snp.bottom).offset(5)
            make.height.equalTo(30)
        }
        headImgV.isUserInteractionEnabled = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    func reloadView()
    {
        let my:UserInfoModel? = UserInfoModel.getUserInforModel()
        let tap = UITapGestureRecognizer()
        tap.rx.event
            .subscribe(onNext: { [weak self] _ in
                if(my != nil)
                {
                    self?.navigationController?.pushViewController(SettingViewController(), animated: true)
                }
                else
                {
                    self?.navigationController?.pushViewController(LoginViewController(), animated: true)
                }
            })
            .addDisposableTo(disposeBag)
        
        headImgV.addGestureRecognizer(tap)
        if my != nil {
            headImgV.mb_setImage(withUrlString: my?.img, placeholderImgName: "Ico_MCustomerCenter")
            nameLabel.text = my?.name
            nameLabel.isUserInteractionEnabled = false
        }
        else
        {
            nameLabel.isUserInteractionEnabled = true
            let tapBackground = UITapGestureRecognizer()
            tapBackground.rx.event
                .subscribe(onNext: { [weak self] _ in
                    self?.navigationController?.pushViewController(LoginViewController(), animated: true)
                })
                .addDisposableTo(disposeBag)
            
            nameLabel.addGestureRecognizer(tapBackground)
            nameLabel.text = "登录"
            headImgV.image = UIImage(named: "Ico_MCustomerCenter")
        }
    }
    func loginAction()
    {
        self.navigationController?.pushViewController(LoginViewController(), animated: true)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identity = "cell2"
        var cell = tableView.dequeueReusableCell(withIdentifier: identity)
        if cell == nil
        {
            cell = UITableViewCell(style:.value1, reuseIdentifier: identity)
        }
        cell?.accessoryType = .disclosureIndicator
        cell?.textLabel?.text = dataSource[indexPath.row] as String
        let my:UserInfoModel? = UserInfoModel.getUserInforModel()
        
        if indexPath.row == 0
        {
            cell?.detailTextLabel?.text = "\(my?.article_count ?? 0)"
        }
        else if indexPath.row == 1
        {
            cell?.detailTextLabel?.text = "\(my?.artical_tag_count ?? 0)"
        }
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 0)
        {
            let WebView = WebViewController()
            WebView.urlString = "http://127.0.0.1:8000/haveFun/login"
            self.navigationController?.pushViewController(WebView, animated: true)
        }
        else if (indexPath.row == 1)
        {
            let vc = WKWebViewController()
            vc.urlstring = "http://127.0.0.1:8000/haveFun/login"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if (indexPath.row == 2)
        {
            let my:UserInfoModel? = UserInfoModel.getUserInforModel()
            if(my != nil)
            {
            self.navigationController?.pushViewController(SettingViewController(), animated: true)
            }
            else
            {
            self.navigationController?.pushViewController(LoginViewController(), animated: true)
            }
        }
        else if (indexPath.row == dataSource.count-1)
        {
            UserDefaults.standard.removeObject(forKey: UserBasicInforKey)
            MBProgressHUD.showSuccess("退出成功")
            reloadView()
        }
    }
}
