//
//  WKWebViewController.swift
//  myRxSwiftDemo
//
//  Created by 尹彩霞 on 2017/11/24.
//  Copyright © 2017年 尹彩霞. All rights reserved.
//

import UIKit
import WebKit

class WKWebViewController: UIViewController,WKNavigationDelegate {
    var webView = WKWebView()
    var progressView = UIProgressView()
    var urlstring:String = "http://127.0.0.1:8000/haveFun/pup_artical/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "发布文章"
        
        progressView.frame = CGRect(x: 0, y: 0, width: WindowWidth, height: 2)
        progressView.tintColor = UIColor.blue
        progressView.trackTintColor = UIColor.gray
        progressView.transform = CGAffineTransform(scaleX: 1.0, y: 1.5)
        self.view.addSubview(progressView)
        setWebView()
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress"
        {
            
            self.progressView.progress = Float(webView.estimatedProgress)
            if self.progressView.progress == 1.0
            {
              
                
                UIView.animate(withDuration: 0.5, delay: 0.6, options: .curveEaseOut, animations: {[unowned self] () -> Void in
                    self.progressView.transform = CGAffineTransform(scaleX: 1.0, y: 1.4)
                    
                }, completion: { [unowned self] (finish:Bool) in
                    self.progressView.isHidden = true
                })
            }
            else
            {
                self.progressView.isHidden = false
            }
        }
        
    }
    
    func setWebView() {
        
        let config = WKWebViewConfiguration()
        
        //偏好设置
        config.preferences = WKPreferences()
        //字体
        config.preferences.minimumFontSize = 10
        //设置js跳转
        config.preferences.javaScriptEnabled = true
        //不自动打开窗口
        config.preferences.javaScriptCanOpenWindowsAutomatically = false
        //web内容处理池
        config.processPool = WKProcessPool()
        //js和webview内容交互
        config.userContentController = WKUserContentController()
        //注入js对象名称为appmodel，当js通过appmodel来调用
        //可以在wkscriptMessagehandler的代理中接收到
//        config.userContentController.add(self as! WKScriptMessageHandler, name: "AppModel")
        
        //webView
       
        let myURL = URL(string: urlstring)
        webView = WKWebView(frame: CGRect(x: 0, y: 1, width: WindowWidth, height: WindowHeight-15), configuration: config)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        view.addSubview(webView)
        webView.navigationDelegate = self
        webView.sizeToFit()
        webView.scrollView.bounces = false
        
    }  
    //页面开始加载时调用
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!)
    {
        self.progressView.isHidden = false
        self.progressView.transform = CGAffineTransform(scaleX: 1.0, y: 1.5)
        self.view.bringSubview(toFront: progressView)
    }
    //当内容开始返回时调用
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!)
    {
        
    }
    // 页面加载完成之后调用
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!)
    {
        self.progressView.isHidden = true
    }
    //页面加载失败时调用
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error)
    {
         self.progressView.isHidden = true
        MBProgressHUD.showError(error.localizedDescription)
    }
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView)
    {
        
    }
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Swift.Void)
    {
        
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust && challenge.previousFailureCount == 0
        {
            let credential:URLCredential =  URLCredential.init(trust: challenge.protectionSpace.serverTrust!)
            completionHandler(URLSession.AuthChallengeDisposition.useCredential, credential)
        }
        else
        {
        completionHandler(URLSession.AuthChallengeDisposition.cancelAuthenticationChallenge, nil)
        }
        
    }
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!)
    {
        
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
