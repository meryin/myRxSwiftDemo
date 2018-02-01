//
//  ListViewModel.swift
//  myRxSwiftDemo
//
//  Created by 尹彩霞 on 2018/1/17.
//  Copyright © 2018年 尹彩霞. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ObjectMapper

class ListViewModel: NSObject {
    let bag : DisposeBag = DisposeBag()//垃圾袋 取消订阅
    var listArray = Variable<[ArticalTagModel]>([])
    var collectV:UICollectionView?
    var requestData = PublishSubject<Bool>()
    
    func setConfig()
    {
      
        requestData.asObserver().subscribe { [unowned self] (event : Event<Bool>) in
            provider.request(.TagList).filterSuccessfulStatusCodes().mapJSON().asObservable().mapArray(type: ArticalTagModel.self)
                .subscribe(onNext: { (model) in
                self.listArray.value = model
                self.collectV!.mj_header.endRefreshing()
            }).addDisposableTo(self.bag)
        }.addDisposableTo(bag)
        listArray.asObservable()
            .bind(to: collectV!.rx.items(cellIdentifier: "cell", cellType: ListCollectionViewCell.self)){ row , model , cell in
                cell.backImgV.mb_setImage(withUrlString: model.tag_img, placeholderImgName: "Ico_Main_Adv_aqy")
                cell.titlLabel.text = model.tag_name
                cell.contentLabel.text = model.tag_abstract
                
            }
            .addDisposableTo(bag)
    }
}
