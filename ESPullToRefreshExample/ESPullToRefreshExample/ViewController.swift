//
//  ViewController.swift
//  ESPullToRefreshExample
//
//  Created by egg swift on 16/5/5.
//  Copyright © 2016年 egg swift. All rights reserved.
//

import UIKit

public enum ESRefreshExampleType {
    case defaulttype, meituan, wechat
}

public enum ESRefreshExampleListType {
    case tableview, collectionview
}

public class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    public var listType: ESRefreshExampleListType = .tableview
    
    public let dataArray = [
        "Default",
        "美团网 (Meituan.com)",
        "WeChat",
        "TextView",
        "Day",
        ]
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 250/255.0, green: 250/255.0, blue: 250/255.0, alpha: 0.8)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.init(red: 38/255.0, green: 38/255.0, blue: 38/255.0, alpha: 1.0), NSFontAttributeName: UIFont.systemFont(ofSize: 16.0)]
        self.navigationController?.navigationBar.tintColor = UIColor.init(red: 38/255.0, green: 38/255.0, blue: 38/255.0, alpha: 1.0)
        self.navigationItem.title = "Example"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "listtype2"), style: .plain, target: self, action: #selector(changeListType(sender:)))
        
        self.tableView.register(UINib.init(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "ListTableViewCell")
        self.tableView.isHidden = false
        self.tableView.contentInset = UIEdgeInsetsMake(64.0, 0, 0, 0)
        self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(64.0, 0, 0, 0)
        self.collectionView.register(UINib.init(nibName: "ListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ListCollectionViewCell")
        
        self.collectionView.isHidden = true
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let layout: UICollectionViewFlowLayout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.init(width: 0.0, height: 0.5)
        layout.footerReferenceSize = CGSize.init(width: 0.0, height: 0.5)
        layout.minimumInteritemSpacing = 0.5
        layout.minimumLineSpacing = 0.5
        layout.itemSize = CGSize.init(width: (collectionView.bounds.size.width - layout.minimumInteritemSpacing * 2) / 3.0, height: (collectionView.bounds.size.width - layout.minimumInteritemSpacing * 2) / 3.0)
    }
    
    public func changeListType(sender: Any?) {
        if self.listType == .tableview {
            self.listType = .collectionview
            self.tableView.isHidden = true
            self.collectionView.isHidden = false
        } else {
            self.listType = .tableview
            self.tableView.isHidden = false
            self.collectionView.isHidden = true
        }
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: self.listType == .tableview ? "listtype2" : "listtype1"), style: .plain, target: self, action: #selector(changeListType(sender:)))
    }
    
    public func select(indexPath: IndexPath) {
        var vc: UIViewController!
        switch indexPath.row {
        case 0:
            vc = ESRefreshTableViewController.init(style: .plain)
            if let vc = vc as? ESRefreshTableViewController {
                vc.type = .defaulttype
            }
        case 1:
            vc = ESRefreshTableViewController.init(style: .plain)
            if let vc = vc as? ESRefreshTableViewController {
                vc.type = .meituan
            }
        case 2:
            vc = ESRefreshTableViewController.init(style: .plain)
            if let vc = vc as? ESRefreshTableViewController {
                vc.type = .wechat
            }
        case 3:
            vc = TextViewController.init()
        case 4:
            vc = ESRefreshTableViewController.init(style: .plain)
        default:
            break
        }
        vc.title = dataArray[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: UITableViewDataSource
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 46.0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell")
        if let cell = cell as? ListTableViewCell {
            cell.titleLabel.text = "\(indexPath.row + 1).   " + dataArray[indexPath.row]
        }
        return cell!
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.5
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.bounds.size.width, height: 0.5))
        view.backgroundColor = UIColor.lightGray
        return view
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        self.select(indexPath: indexPath)
    }
    
    // MARK: UICollectionViewDataSource
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(ceil(Double(dataArray.count) / 3.0) * 3.0)
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCollectionViewCell", for: indexPath)
        if let cell = cell as? ListCollectionViewCell {
            if indexPath.row < dataArray.count {
                cell.titleLabel.text = dataArray[indexPath.row]
            }
        }
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if indexPath.row < dataArray.count {
            self.select(indexPath: indexPath)
        }
    }
    
}
