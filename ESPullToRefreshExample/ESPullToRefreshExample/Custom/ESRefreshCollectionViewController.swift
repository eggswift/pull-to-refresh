//
//  ESRefreshCollectionViewController.swift
//  ESPullToRefreshExample
//
//  Created by lihao on 16/8/30.
//  Copyright © 2016年 egg swift. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ESRefreshCollectionViewCell"

public class ESRefreshCollectionViewController: UICollectionViewController {

    public var array = [String]()
    public var page = 1
    public var type: ESRefreshExampleType = .defaulttype
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    // MARK: UICollectionViewDataSource
    override public func numberOfSections(in collectionView: UICollectionView) -> Int {

        return 1
    }

    override public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return 0
    }

    override public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
    
        return cell
    }

}
