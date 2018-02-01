//
//  HomeViewModel.swift
//  myRxSwiftDemo
//
//  Created by 尹彩霞 on 2017/12/25.
//  Copyright © 2017年 尹彩霞. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ObjectMapper

enum MBRefreshStatus {
    case none
    case beginHeaderRefresh
    case endHeaderRefresh
    case beginFooterRefresh
    case endFooterRefresh
    case noMoreData
}

class HomeViewModel: NSObject {
    var bag : DisposeBag = DisposeBag()
    var page:Int=1
    var listArray = [ArticalModel?]()
    var refreshStateObserable = Variable<MBRefreshStatus>(.none)
    var tableV = UITableView()
    
    func getData(pull:Bool){
        if pull
        {
            self.page += 1
        }
        else
        {
            self.page = 1
        }
        provider
            .request(.homeList(page:self.page))
            .filterSuccessfulStatusCodes()
            .mapJSON().asObservable().mapPageArrary(type: PageBasicModel.self)
            .subscribe(onNext: { (model) in
                let posts = model as PageBasicModel
                if (self.page == 1)
                {
                    self.listArray = posts.data!
                }
                else
                {
                    self.listArray = self.listArray + posts.data!
                }
                if(posts.data?.count == 0)
                {
                    self.page = posts.total!
                }
                self.tableV.reloadData()
                if(self.page > 1)
                {
                    self.refreshStateObserable.value = .endFooterRefresh
                }
                else {
                    self.refreshStateObserable.value = .endHeaderRefresh
                }
                if(posts.data?.count == 0)
                {
                    self.refreshStateObserable.value = .noMoreData
                }
             
            }, onError: { (error) in
                self.tableV.mj_header.endRefreshing()
                self.tableV.mj_footer.endRefreshing()
                
            }).addDisposableTo(self.bag)


    }
    func SetConfig() {
        
        
//        // 差别就是modelSelected()方法会直接返回选中的model，而不会返回选中model的indexPath。
//        tableV.rx.modelSelected(ArticalModel.self).subscribe(onNext: { (item) in
//            print(item)
//        }).disposed(by: bag)
//        tableV.rx.itemSelected.map{
//            return $0
//            }.subscribe { (event : Event<IndexPath>) in
//              print(event)
//        }.addDisposableTo(bag)
        
        
        
        refreshStateObserable.asObservable().subscribe(onNext: { (state) in
            switch state{
            case .beginHeaderRefresh:
                self.tableV.mj_header.beginRefreshing()
            case .endHeaderRefresh:
                self.tableV.mj_header.endRefreshing()
                self.tableV.mj_footer.resetNoMoreData()
            case .beginFooterRefresh:
                self.tableV.mj_footer.beginRefreshing()
            case .endFooterRefresh:
                self.tableV.mj_footer.endRefreshing()
            case .noMoreData:
                self.tableV.mj_footer.resetNoMoreData()
            default:
                break
            }
        }).addDisposableTo(bag)
    }
}
