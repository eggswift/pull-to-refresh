//
//  WebViewController.swift
//  ESPullToRefreshExample
//
//  Created by lihao on 16/5/6.
//  Copyright © 2016年 egg swift. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "https://github.com/eggswift"
        self.webView.delegate = self
        self.webView.scrollView.es_addPullToRefresh { [weak self] in
            self?.webView.loadRequest(NSURLRequest.init(URL: NSURL.init(string: "https://github.com/eggswift")!))
        }
        self.webView.scrollView.bounces = true
        self.webView.scrollView.alwaysBounceVertical = true
        self.webView.scrollView.es_startPullToRefresh()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        self.webView.scrollView.es_stopPullToRefresh(completion: true)
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        self.webView.scrollView.es_stopPullToRefresh(completion: false)
    }

}
