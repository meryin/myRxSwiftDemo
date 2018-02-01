//
//  WebViewController.swift
//  myRxSwiftDemo
//
//  Created by 尹彩霞 on 2017/12/15.
//  Copyright © 2017年 尹彩霞. All rights reserved.
//

import UIKit

class WebViewController: UIViewController ,UIWebViewDelegate{

    var urlString:String?
    let theWebView = UIWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(fileURLWithPath:urlString!)
        let request = URLRequest(url:url)
        
        //将浏览器视图全屏(在内容区域全屏,不占用顶端时间条)
        let frame = CGRect(x:0, y:0, width:WindowWidth,
                           height:WindowHeight)
         theWebView.frame = frame
        //禁用页面在最顶端时下拉拖动效果
        theWebView.scrollView.bounces = false
        //加载页面
        theWebView.loadRequest(request)
        self.view.addSubview(theWebView)
        theWebView.delegate = self
    }

    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool
    {
        return true
    }
    
   func webViewDidStartLoad(_ webView: UIWebView)
   {
    
    }
    func webViewDidFinishLoad(_ webView: UIWebView)
    {
        
    }
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error)
    {
        MBProgressHUD.showError(error.localizedDescription)
    }
    

    

}
