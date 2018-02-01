//
//  ListViewController.swift
//  myRxSwiftDemo
//
//  Created by 尹彩霞 on 2017/11/20.
//  Copyright © 2017年 尹彩霞. All rights reserved.
//

import UIKit
import MJRefresh
import Then

class ListViewController: UIViewController {
    let viewModel = ListViewModel()
    lazy var collectView:UICollectionView = UICollectionView()
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()        
    }

   func initUI()
   {
        let layout = CustomLayout()
    collectView = UICollectionView(frame: CGRect(x: 0.0, y: 0.0, width: WindowWidth, height: WindowHeight-147), collectionViewLayout: layout).then({ (collect) in
        collect.contentInset = UIEdgeInsetsMake(0, 0, 20, 0)
    })
        self.view.addSubview(collectView)
        collectView.register(ListCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectView.backgroundColor = UIColor.white
        viewModel.collectV = collectView;
        viewModel.setConfig()
        weak var weakself = self
        collectView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            weakself?.viewModel.requestData.onNext(true)
        })
        collectView.mj_header.beginRefreshing()
    }

   

}
class CustomLayout:UICollectionViewLayout{
    // 内容区域总大小，不是可见区域
    override var collectionViewContentSize: CGSize {
        let width = collectionView!.bounds.size.width - collectionView!.contentInset.left
            - collectionView!.contentInset.right
        let height = CGFloat((collectionView!.numberOfItems(inSection: 0) + 1) / 2)
            * (width / 2 )
        return CGSize(width: width, height: height)
    }
    
    // 所有单元格位置属性
    override func layoutAttributesForElements(in rect: CGRect)
        -> [UICollectionViewLayoutAttributes]? {
            var attributesArray = [UICollectionViewLayoutAttributes]()
            let cellCount = self.collectionView!.numberOfItems(inSection: 0)
            for i in 0..<cellCount {
                let indexPath =  IndexPath(item:i, section:0)
                let attributes =  self.layoutAttributesForItem(at: indexPath)
                attributesArray.append(attributes!)
            }
            return attributesArray
    }
    
    // 这个方法返回每个单元格的位置和大小
    override func layoutAttributesForItem(at indexPath: IndexPath)
        -> UICollectionViewLayoutAttributes? {
            //当前单元格布局属性
            let attribute =  UICollectionViewLayoutAttributes(forCellWith:indexPath)
            
            //单元格边长
            let largeCellSide = collectionViewContentSize.width / 2
            let smallCellSide = collectionViewContentSize.width / 2
            
            //当前行数，每行显示2个图片，
            let line:Int =  indexPath.item / 2
            //当前行的Y坐标
            let lineOriginY =  largeCellSide * CGFloat(line)
            let rightSmallX = collectionViewContentSize.width - smallCellSide
            
            // 每行2个图片，2行循环一次，一共6种位置
            if (indexPath.item % 2 == 0) {
                attribute.frame = CGRect(x:0, y:lineOriginY, width:largeCellSide,
                                         height:largeCellSide)
            } else  {
                attribute.frame = CGRect(x:rightSmallX, y:lineOriginY, width:smallCellSide,
                                         height:smallCellSide)
            }
            return attribute
    }
    
    
}
