//
//  ArticalDetailViewController.swift
//  myRxSwiftDemo
//
//  Created by 尹彩霞 on 2018/3/2.
//  Copyright © 2018年 尹彩霞. All rights reserved.
//

import UIKit

class ArticalDetailViewController: UIViewController {
    var artical:ArticalModel?
    let backView = UIScrollView()
    let titleLabel = UILabel.init(font: 18, textColor: UIColor.black)
    let contentText = UITextView()
    let authorView = AuthorInforView()
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
