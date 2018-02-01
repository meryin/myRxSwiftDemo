//
//  SettingViewController.swift
//  myRxSwiftDemo
//
//  Created by 尹彩霞 on 2018/1/18.
//  Copyright © 2018年 尹彩霞. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    lazy var tableView:UITableView = UITableView()
    var listArr = [""]
    var user:UserInfoModel? = UserInfoModel.getUserInforModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "个人信息"
        initUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initUI(){
        listArr = ["名字","电话","性别","邮箱","地址","清除缓存"]
        
        tableView = UITableView(frame: CGRect(x: 0.0, y: 0.0, width: WindowWidth, height: WindowHeight-50), style: UITableViewStyle.grouped)
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
       

    }
    

}
extension SettingViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0)
        {
            return 1
        }
        return listArr.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0
        {
            return 80
        }
        return 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let identity = "cell1"
            let cell:UITableViewCell = UITableViewCell(style: .default, reuseIdentifier: identity)
            
            cell.textLabel?.text = "头像"
            let headImgv = UIImageView(frame: CGRect(x: WindowWidth-100, y: 5, width: 60, height: 60))
            cell.addSubview(headImgv)
            headImgv.mb_setImage(withUrlString: user?.img, placeholderImgName: "Ico_MCustomerCenter")
            cell.accessoryType = .disclosureIndicator
            return cell
        }
        else
        {
            let identity = "cell2"
            var cell = tableView.dequeueReusableCell(withIdentifier: identity)
            if cell == nil
            {
                cell = UITableViewCell(style:.value1, reuseIdentifier: identity)
            }
            cell?.textLabel?.text = listArr[indexPath.row]
            cell?.accessoryType = .disclosureIndicator
            switch indexPath.row{
            case 0:
                cell?.detailTextLabel?.text = user?.name
                break
            case 1:
                cell?.detailTextLabel?.text = user?.phone
                break
            case 2:
                if user?.sex == 1
                {
                    cell?.detailTextLabel?.text = "女"
                }
                else
                {
                    cell?.detailTextLabel?.text = "男"
                }
                break
            case 3:
                cell?.detailTextLabel?.text = user?.email
                break
            case 4:
                cell?.detailTextLabel?.text = user?.address
                break
            default:
                cell?.detailTextLabel?.text = Tools.fileSizeOfCache()
                break
            }
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.01
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    //设置分组尾的高度
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    //将分组尾设置为一个空的View
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == 0)
        {
            self.navigationController?.pushViewController(ChangHeadImageViewController(), animated: true)
        }
        else
        {
            if (indexPath.row == 5)
            {
                let message = Tools.fileSizeOfCache() + "缓存"
                let alert = UIAlertController(title: "清除缓存", message: message, preferredStyle: UIAlertControllerStyle.alert)
                
                let alertConfirm = UIAlertAction(title: "确定", style: UIAlertActionStyle.default) { (alertConfirm) -> Void in
                    Tools.clearCache()
                    tableView.reloadData()
                }
                alert.addAction(alertConfirm)
                let cancle = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel) { (cancle) -> Void in
                    
                }
                alert.addAction(cancle)
                present(alert, animated: true) { () -> Void in
                    
                }
            }
        }
        
    }
    
    
}
