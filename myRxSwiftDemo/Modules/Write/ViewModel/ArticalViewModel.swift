//
//  ArticalViewModel.swift
//  myRxSwiftDemo
//
//  Created by 尹彩霞 on 2018/2/7.
//  Copyright © 2018年 尹彩霞. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ObjectMapper

class ArticalViewModel: NSObject {
    let disposeBag = DisposeBag()
    var listArray = Variable<[ArticalTagModel]>([])
    var table:UITableView = UITableView()
      func getTagList()
    {
       
        guard let my = UserInfoModel.getUserInforModel() ,let user_id = my.user_id else {
            MBProgressHUD.showError("请先登录")
            return
        }
       
        listArray.asObservable()
            .bind(to: table.rx.items(cellIdentifier: "cell", cellType: TagListTableViewCell.self)){ row , model , cell in
                
                cell.imgview.mb_setImage(withUrlString: model.tag_img, placeholderImgName: "Ico_Main_Adv_aqy")
                cell.titleLabel.text = model.tag_name
                let user = model.createdByUser
                cell.abstrLabel.text = (user?.name)! + ": " + "\(model.article_count ?? 0 )" + "篇文章"
            }
            .addDisposableTo(disposeBag)
        gitHubProvider.request(.tagListByUser(user_id:user_id)) { result in
            if case let .success(response) = result {
                let arr = try? response.mapArray(ArticalTagModel.self)
                self.listArray.value = arr!
                self.table.reloadData()
                
            }
            else {
                MBProgressHUD.showError((result.error?.errorDescription)! )
            }
            
        }
            
        
        
    }
   
}
