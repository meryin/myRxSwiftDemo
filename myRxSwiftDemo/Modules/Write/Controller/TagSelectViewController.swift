//
//  TagSelectViewController.swift
//  myRxSwiftDemo
//
//  Created by 尹彩霞 on 2018/2/7.
//  Copyright © 2018年 尹彩霞. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

typealias anyBlock = (_ obj: Any) -> Void//声明

class TagSelectViewController: UIViewController {
    lazy var tableView:UITableView = UITableView()
    var blcok:anyBlock?
    let bag : DisposeBag = DisposeBag()
    let viewModel = ArticalViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "选择文集"
        initUI()
    }

    func initUI()
    {
        
        tableView = UITableView(frame: CGRect(x: 0.0, y: 0.0, width: WindowWidth, height: WindowHeight-50), style: UITableViewStyle.plain)
        self.view.addSubview(tableView)
        tableView.tableFooterView  = UIView()
        viewModel.table = tableView
        viewModel.getTagList()
        tableView.register(TagListTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.rx.modelSelected(ArticalTagModel.self).subscribe(onNext: { (item) in
            self.blcok!(item)
            self.navigationController?.popViewController(animated: true)
            }).disposed(by: bag)
        
    }
    

}
