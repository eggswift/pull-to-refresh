//
//  WebViewController.swift
//  ESPullToRefreshExample
//
//  Created by lihao on 16/5/6.
//  Copyright © 2016年 egg swift. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var networkTipsButton: UIButton!
    @IBOutlet weak var webViewXib: UIWebView!
    var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let _ = self.webViewXib {
            self.webView = self.webViewXib
        } else {
            self.webView = UIWebView()
            self.webView.frame = self.view.bounds
            self.view.addSubview(self.webView!)
        }
        
        self.webView!.delegate = self
        
        let url = "https://github.com/eggswift"
        self.title = "egg swift"
        let request = NSURLRequest.init(url: NSURL(string: url)! as URL)
        
        weak var weakSelf = self
        self.webView.scrollView.es.addPullToRefresh {
            weakSelf?.webView.loadRequest(request as URLRequest)
        }
        self.webView.scrollView.es.startPullToRefresh()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.webView.scrollView.es.stopPullToRefresh()
        self.webView.scrollView.bounces = true
        self.webView.scrollView.alwaysBounceVertical = true
    }

    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        self.webView.scrollView.es.stopPullToRefresh(ignoreDate: true)
        self.networkTipsButton.isHidden = false
    }

    @IBAction func networkRetryAction(_ sender: AnyObject) {
        self.networkTipsButton.isHidden = true
        UIView.performWithoutAnimation {
            self.webView.scrollView.es.startPullToRefresh()
        }
    }
}
