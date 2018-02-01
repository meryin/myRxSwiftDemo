//
//  MBProgressHUD.swift
//  myRxSwiftDemo
//
//  Created by 尹彩霞 on 2017/12/22.
//  Copyright © 2017年 尹彩霞. All rights reserved.
//

import UIKit
import SVProgressHUD

enum HUDType {
    case success
    case error
    case loading
    case info
    case progress
}

class MBProgressHUD: NSObject {
    
    
    class func initMBProgressHUD() {
        SVProgressHUD.setFont(UIFont.systemFont(ofSize: 14.0))
        SVProgressHUD.setDefaultMaskType(.none)
        SVProgressHUD.setMinimumDismissTimeInterval(1.5)
    }
    
    class func showSuccess(_ status: String) {
        self.showMBProgressHUD(type: .success, status: status)
    }
    class func showError(_ status: String) {
        self.showMBProgressHUD(type: .error, status: status)
    }
    class func showLoading(_ status: String) {
        self.showMBProgressHUD(type: .loading, status: status)
    }
    class func showInfo(_ status: String) {
        self.showMBProgressHUD(type: .info, status: status)
    }
    class func showProgress(_ status: String, _ progress: CGFloat) {
        self.showMBProgressHUD(type: .success, status: status, progress: progress)
    }
    class func dismissHUD(_ delay: TimeInterval = 0) {
        SVProgressHUD.dismiss(withDelay: delay)
    }
}


extension MBProgressHUD {
    class func showMBProgressHUD(type: HUDType, status: String, progress: CGFloat = 0) {
        switch type {
        case .success:
            SVProgressHUD.showSuccess(withStatus: status)
        case .error:
            SVProgressHUD.showError(withStatus: status)
        case .loading:
            SVProgressHUD.show(withStatus: status)
        case .info:
            SVProgressHUD.showInfo(withStatus: status)
        case .progress:
            SVProgressHUD.showProgress(Float(progress), status: status)
        }
    }
}


