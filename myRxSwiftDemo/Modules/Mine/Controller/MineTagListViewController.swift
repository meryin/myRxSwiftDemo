//
//  MineTagListViewController.swift
//  myRxSwiftDemo
//
//  Created by 尹彩霞 on 2018/2/27.
//  Copyright © 2018年 尹彩霞. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MineTagListViewController: UIViewController {
    lazy var tableView:UITableView = UITableView()
    var blcok:anyBlock?
    let bag : DisposeBag = DisposeBag()
    let viewModel = ArticalViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "我的会馆"
        initUI()
    }
    
    func initUI()
    {
        let button = UIButton.init(backGroundColor: UIColor.clear, title: "新建会馆", titleColor: UIColor.orange, target: self, action: #selector(create))
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 25)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        tableView = UITableView(frame: CGRect(x: 0.0, y: 0.0, width: WindowWidth, height: WindowHeight-50), style: UITableViewStyle.plain)
        self.view.addSubview(tableView)
        
        viewModel.table = tableView
        viewModel.getTagList()
        tableView.register(TagListTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.rx.modelSelected(ArticalTagModel.self).subscribe(onNext: { (item) in
            
        }).disposed(by: bag)
        tableView.tableFooterView  = UIView()
    }
    func create()
    {
        let vc = CreateTagViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
