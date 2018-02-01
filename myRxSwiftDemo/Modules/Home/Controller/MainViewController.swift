//
//  MainViewController.swift
//  myRxSwiftDemo
//
//  Created by 尹彩霞 on 2017/11/20.
//  Copyright © 2017年 尹彩霞. All rights reserved.
//

import UIKit
import Then
import MJRefresh
import RxSwift

class MainViewController: UIViewController {
    
    let viewModel  = HomeViewModel()
    lazy var tableView:UITableView = UITableView()
    var toolBarView:ToolBarView?
    
    let dispose = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        initToolBarView()
        initUI()
    }
    
    func initUI(){
        tableView = UITableView(frame: CGRect(x: 0.0, y: 0.0, width: WindowWidth, height: WindowHeight-50), style: UITableViewStyle.grouped).then({ (table) in
            table.contentInset = UIEdgeInsetsMake(0, 0, 50, 0)
        })
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = 120
        tableView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(0)
            make.bottom.equalTo(-50)
            make.right.left.equalTo(0)
        }
        weak var weakself = self
        if #available(iOS 11.0, *) {//tableView和ScrollView受导航栏影响向下偏移的问题
            tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentBehavior(rawValue: 2)!
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        viewModel.tableV = tableView
        
        viewModel.SetConfig()
       
        tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            weakself?.viewModel.getData(pull: false)
        })
        
        tableView.mj_footer = MJRefreshBackNormalFooter.init(refreshingBlock: {
            weakself?.viewModel.getData(pull: true)
        })
        
        tableView.mj_header.beginRefreshing()
    }

    func initToolBarView() {
        toolBarView = ToolBarView.initView()
        var frame = CGRect()
        frame.origin = (self.tabBarController?.tabBar.frame.origin)!
        frame.size = (self.tabBarController?.tabBar.frame.size)!
        toolBarView?.frame = frame
        self.tabBarController?.view.addSubview(toolBarView!)
        toolBarView?.isHidden = true
        toolBarView?.cancelButton.addTarget(self, action:#selector(self.deleteToolBarButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc func deleteToolBarButtonTapped(_ sender: UIButton) {
        self.tabBarController?.tabBar.isHidden = false // 显示 Tab 栏
        toolBarView?.isHidden = true // 隐藏工具栏
    }
   
}

extension MainViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return self.viewModel.listArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MainTableViewCell
        let model = self.viewModel.listArray[indexPath.section]!
        let user = model.owner
        cell.titleLabel?.text = model.title
        cell.userLabel?.text = user?.name
        cell.timeLabel?.text = model.pubTime
        cell.adstraLabel?.text = model.content
        cell.readLabel?.text = "阅读：" + "\(model.read ?? 0)"
        cell.commandLabel?.text = "评论：" + "\(model.command ?? 0)"
        cell.collectLabel?.text = "收藏：" + "\(model.collect ?? 0)"
        cell.headImg?.mb_setImage(withUrlString: user?.img, placeholderImgName: "Ico_MCustomerCenter")
        if model.image == nil
        {
            cell.contentImg!.snp.remakeConstraints{(make) -> Void in
                make.width.height.equalTo(0)
                make.right.equalTo(-10)
            }
        }
        else{
            cell.contentImg?.mb_setImage(withUrlString: model.image, placeholderImgName: "Ico_Main_Adv_aqy")
            cell.contentImg!.snp.remakeConstraints{(make) -> Void in
                make.bottom.equalTo(cell.adstraLabel!.snp.bottom)
                make.top.equalTo(cell.titleLabel!.snp.top)
                make.right.equalTo(-15)
                make.width.equalTo(cell.contentImg!.snp.height)
            }
        }
     
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5.01
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
}
