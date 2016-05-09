//
//  MeituanTableViewController.swift
//  ESPullToRefreshExample
//
//  Created by lihao on 16/5/7.
//  Copyright © 2016年 egg swift. All rights reserved.
//

import UIKit

class MeituanTableViewController: UITableViewController {
    var array = [String]()
    var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.backgroundColor = UIColor.init(red: 240/255.0, green: 239/255.0, blue: 237/255.0, alpha: 1.0)
        self.tableView.registerNib(UINib.init(nibName: "DefaultTableViewCell", bundle: nil), forCellReuseIdentifier: "DefaultTableViewCell")
        
        self.tableView.es_addPullToRefresh(animator: MTRefreshHeaderAnimator.init(frame: CGRect.zero)) {
            [weak self] in
            let minseconds = 3.0 * Double(NSEC_PER_SEC)
            let dtime = dispatch_time(DISPATCH_TIME_NOW, Int64(minseconds))
            dispatch_after(dtime, dispatch_get_main_queue() , {
                self?.page = 1
                self?.array.removeAll()
                for _ in 1...8{
                    self?.array.append(" ")
                }
                self?.tableView.reloadData()
                self?.tableView.es_stopPullToRefresh(completion: true)
            })
        }
        
        self.tableView.es_addInfiniteScrolling(animator: MTRefreshFooterAnimator.init(frame: CGRect.zero)) {
            [weak self] in
            let minseconds = 3.0 * Double(NSEC_PER_SEC)
            let dtime = dispatch_time(DISPATCH_TIME_NOW, Int64(minseconds))
            dispatch_after(dtime, dispatch_get_main_queue() , {
                self?.page += 1
                if self?.page <= 3 {
                    for _ in 1...8{
                        self?.array.append(" ")
                    }
                    self?.tableView.reloadData()
                    self?.tableView.es_stopLoadingMore()
                } else {
                    self?.tableView.es_noticeNoMoreData()
                }
            })
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.es_startPullToRefresh()
    }
    
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 140.0
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.min
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DefaultTableViewCell", forIndexPath: indexPath)
        cell.backgroundColor = UIColor.init(white: 250.0 / 255.0, alpha: 1.0)
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let vc = WebViewController.init()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}