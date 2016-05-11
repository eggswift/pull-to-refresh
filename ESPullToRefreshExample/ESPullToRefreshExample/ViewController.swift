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
                        "Default",
                        "美团网 (Meituan.com)",
                        "WeChat"
                    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 254/255.0, green: 73/255.0, blue: 42/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor(), NSFontAttributeName: UIFont.init(name: "ChalkboardSE-Bold", size: 17.0)!]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.title = "Example"
        self.navigationController?.navigationBar.shadowImage = UIImage.init()
        
        tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "UITableViewCell")
    }
    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell")
        cell?.textLabel?.textColor = UIColor.init(white: 0.0, alpha: 0.6)
        cell?.textLabel?.font = UIFont.init(name: "ChalkboardSE-Bold", size: 18.0)
        cell?.textLabel?.text = "\(indexPath.row + 1).   " + dataArray[indexPath.row]
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.5
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.bounds.size.width, height: 0.5))
        view.backgroundColor = UIColor.lightGrayColor()
        return view
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        var vc: UIViewController!
        switch indexPath.row {
        case 0:
            vc = DefaultTableViewController.init()
            break
        case 1:
            vc = MeituanTableViewController.init()
            break
        case 2:
            vc = WeChatTableViewController.init()
            break
        default:

            break
        }
        vc.title = dataArray[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


private class HeaderView: UIView {
    let label: UILabel = {
        let label = UILabel.init(frame: CGRect.zero)
        label.text = "pull-to-refresh"
        label.textAlignment = .Center
        label.font = UIFont.init(name: "ChalkboardSE-Bold", size: 20.0)
        label.textColor = UIColor.init(white: 0.0, alpha: 0.6)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = self.bounds
    }
    
}
