//
//  ToolBarView.swift
//  myRxSwiftDemo
//
//  Created by 尹彩霞 on 2017/12/1.
//  Copyright © 2017年 尹彩霞. All rights reserved.
//

import UIKit

class ToolBarView: UIView {

    @IBOutlet weak var cancelButton: UIButton!
    class func initView() -> ToolBarView
    {
        let nib = UINib(nibName: "ToolBarView", bundle: nil)
        let tooBar = nib.instantiate(withOwner: nil, options: nil)[0] as! ToolBarView
        return tooBar
        
    }

}
