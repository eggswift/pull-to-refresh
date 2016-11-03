
//  File.swift
//  ESPullToRefreshExample
//
//  Created by Meng Ye on 2016/11/2.
//  Copyright © 2016年 egg swift. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController {
    private var list: [String] = []
    
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.alwaysBounceVertical = true
        collectionView.registerClass(DemoCollectionViewCell.self, forCellWithReuseIdentifier: "DemoCell")
        collectionView.contentInset = UIEdgeInsetsMake(12.0, 15.0, 0, 15.0)
        collectionView.backgroundColor = .whiteColor()
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    // MARK: Private Helper Methods
    private func setupViews() {
        self.collectionView.dataSource = self
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        self.view.addSubview(collectionView)
        let itemWidth = (UIScreen.mainScreen().bounds.width - 40) / 3
        layout.itemSize = CGSizeMake(itemWidth, itemWidth)
        layout.minimumLineSpacing = 5.0
        layout.minimumInteritemSpacing = 5.0
        layout.scrollDirection = .Vertical
        
        let viewsDict = [
            "collectionView" : collectionView
        ]
        let vflDict = [
            "H:|-0-[collectionView]-0-|",
            "V:|-0-[collectionView]-0-|"
        ]
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(vflDict[0] as String, options: [], metrics: nil, views: viewsDict))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(vflDict[1] as String, options: [], metrics: nil, views: viewsDict))
        
        //  add pull to refresh
        self.collectionView.es_addPullToRefresh { [weak self] in
            self?.loadData()
        }
        self.collectionView.es_startPullToRefresh()
        self.collectionView.es_addInfiniteScrolling { [weak self] in
            self!.delay(2) {
                for item in 21...40 {
                    self!.list.append(String(item))
                }
                self?.collectionView.es_stopLoadingMore()
                self?.collectionView.reloadData()
            }
        }
    }
    
    func delay(time: NSTimeInterval, completionHandler: ()-> Void) {
        dispatch_after(dispatch_time(
                DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(),
            completionHandler
        )
    }
    
    private func loadData() {
        delay(2) {
            self.list = []
            for item in 0...20 {
                self.list.append(String(item))
            }
            self.collectionView.es_stopPullToRefresh(completion: true)
            self.collectionView.reloadData()
        }
    }
}

// MARK: UICollectionViewDataSource
extension CollectionViewController: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.list.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("DemoCell", forIndexPath: indexPath) as! DemoCollectionViewCell
        cell.configureCell(self.list[indexPath.row])
        
        return cell
    }
}

// MARK: DemoCollectionViewCell
class DemoCollectionViewCell: UICollectionViewCell {
    lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .Center
        label.textColor = UIColor.blackColor()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let viewsDict = ["label" : label]
        let vflDict = ["H:|-0-[label]-0-|",
                       "V:|-0-[label]-0-|"]
        contentView.addSubview(label)
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(vflDict[0] as String, options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(vflDict[1] as String, options: [], metrics: nil, views: viewsDict))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(title: String) {
        label.text = title
    }
}
