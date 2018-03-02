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
        let user:UserInfoModel? = UserInfoModel.getUserInforModel()
        if indexPath.section == 0 {
            let identity = "cell1"
            let cell:UITableViewCell = UITableViewCell(style: .default, reuseIdentifier: identity)
            
            cell.textLabel?.text = "头像"
            let headImgv = UIImageView(frame: CGRect(x: WindowWidth-100, y: 10, width: 60, height: 60))
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
            if indexPath.row > 1
            {
                cell?.accessoryType = .disclosureIndicator
            }
            else
            {
                cell?.accessoryType = .none
            }
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
            else if (indexPath.row == 2)
            {
                
                SimplePickerView.show(["男","女"],result: { (str) in
                    var sex = "0"
                    if str == "女"
                    {
                        sex = "1"
                    }
                    loginViewModel.changeUserInfor(view:tableView,key: "sex", value: sex)
                })
            }
            else if(indexPath.row == 3)
            {
                let alert = UIAlertController(title: "填写邮箱", message: nil, preferredStyle: UIAlertControllerStyle.alert)
                alert.addTextField(configurationHandler: { (textflid) in
                    textflid.placeholder = "邮箱地址"
                })
                let alertConfirm = UIAlertAction(title: "确定", style: UIAlertActionStyle.default) { (alertConfirm) -> Void in
                    let str = alert.textFields?.first?.text
                    if(str != nil && (str! =~ mailRegex))
                    {
                    loginViewModel.changeUserInfor(view:tableView,key: "email", value: str!)
                        
                    }else
                    {
                        MBProgressHUD.showError("请填写邮箱")
                    }
                    alert.dismiss(animated: true, completion: nil)
                }
                alert.addAction(alertConfirm)
                let cancle = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel,handler: nil)
                alert.addAction(cancle)
                present(alert, animated: true,completion: nil)
            }
            else if (indexPath.row == 4)
            {
                let alert = UIAlertController(title: "填写居住地址", message: nil, preferredStyle: UIAlertControllerStyle.alert)
                alert.addTextField(configurationHandler: { (textflid) in
                    textflid.placeholder = "居住地址"
                })
                let alertConfirm = UIAlertAction(title: "确定", style: UIAlertActionStyle.default) { (alertConfirm) -> Void in
                    let str = alert.textFields?.first?.text
                    if(!(str?.isEmpty)!)
                    {
                        loginViewModel.changeUserInfor(view:tableView,key: "address", value: str!)
                    }else
                    {
                        MBProgressHUD.showError("请填写居住地址")
                    }
                    alert.dismiss(animated: true, completion: nil)
                }
                alert.addAction(alertConfirm)
                let cancle = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel,handler: nil)
                alert.addAction(cancle)
                present(alert, animated: true,completion: nil)
            }
        }
        
    }
    
    
}


