//
//  WebViewController.swift
//  ESPullToRefreshExample
//
//  Created by lihao on 16/5/6.
//  Copyright © 2016年 egg swift. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {


    @IBOutlet weak var webViewXib: UIWebView!
    var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let _ = self.webViewXib {
            print("xib")
            self.webView = self.webViewXib
        } else {
            print("code")
            self.webView = UIWebView()
            self.webView.frame = self.view.bounds
            self.view.addSubview(self.webView!)
        }
        
        self.webView!.delegate = self
        
        let url = "https://github.com/eggswift"
        self.title = url
        let request = NSURLRequest(URL: NSURL(string: url)!)
        
        self.webView.scrollView.es_addPullToRefresh { [weak self] in
            self!.webView.loadRequest(request)
        }
        self.webView.scrollView.es_startPullToRefresh()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        self.webView.scrollView.es_stopPullToRefresh(completion: true)
        self.webView.scrollView.bounces = true
        self.webView.scrollView.alwaysBounceVertical = true
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        self.webView.scrollView.es_stopPullToRefresh(completion: false)
    }

}
