//
//  ViewController.swift
//  ESPullToRefreshExample
//
//  Created by egg swift on 16/5/5.
//  Copyright © 2016年 egg swift. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    let dataArray = [
                        "1. Default",
                    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "ESPullToRefresh"
        tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "UITableViewCell")
    }
    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell")
        cell?.textLabel?.text = dataArray[indexPath.row]
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        var vc: UIViewController!
        switch indexPath.row {
        case 0:
            vc = DefaultTableViewController.init()
            break
        default:
            
            break
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
