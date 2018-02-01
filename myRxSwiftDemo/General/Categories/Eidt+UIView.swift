//
//  Eidt+UIView.swift
//  myRxSwiftDemo
//
//  Created by 尹彩霞 on 2017/12/12.
//  Copyright © 2017年 尹彩霞. All rights reserved.
//

import UIKit

extension UIView {
    
    /// 部分圆角
    /// let corners: UIRectCorner = [.bottomLeft,.bottomRight] button.corner(byRoundingCorners: corners, radii: 5)
    /// - Parameters:
    ///   - corners: 需要实现为圆角的角，可传入多个
    ///   - radii: 圆角半径
    func corner(byRoundingCorners corners: UIRectCorner, radii: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    //全部圆角
    func corner(radii: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [UIRectCorner.topLeft , .topRight , .bottomLeft , .bottomRight], cornerRadii: CGSize(width: radii, height: radii))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    //添加点击事件
    func addOnClick(target: AnyObject, action: Selector) {
        let gr = UITapGestureRecognizer(target: target, action: action)
        gr.numberOfTapsRequired = 1
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(gr)
    }
    
   
}

