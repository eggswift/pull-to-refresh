//
//  MTRefreshHeaderAnimator.swift
//  ESPullToRefreshExample
//
//  Created by lihao on 16/5/7.
//  Copyright © 2016年 egg swift. All rights reserved.
//
//  Icon from 美团 iOS app.
//  https://itunes.apple.com/cn/app/mei-tuan-tuan-gou-tuan-gou/id423084029?mt=8
//

import UIKit

public class MTRefreshHeaderAnimator: UIView, ESRefreshProtocol, ESRefreshAnimatorProtocol {
    public var insets: UIEdgeInsets = UIEdgeInsetsZero
    public var view: UIView { return self }
    public var trigger: CGFloat = 56.0
    public var executeIncremental: CGFloat = 56.0
    private var state: ESRefreshViewState = .PullToRefresh
    
    private let imageView: UIImageView = {
        let imageView = UIImageView.init()
        imageView.image = UIImage.init(named: "icon_pull_animation_1")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(imageView)
    }
    
    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func refreshAnimationDidBegin(view: ESRefreshComponent) {
        imageView.center = self.center
        UIView.animateWithDuration(0.2, delay: 0, options: .CurveLinear, animations: {
            self.imageView.frame = CGRect.init(x: (self.bounds.size.width - 39.0) / 2.0,
                                               y: self.bounds.size.height - 50.0,
                                           width: 39.0,
                                          height: 50.0)


            }, completion: { (finished) in
                var images = [UIImage]()
                for idx in 1 ... 8 {
                    if let aImage = UIImage(named: "icon_shake_animation_\(idx)") {
                        images.append(aImage)
                    }
                }
                self.imageView.animationRepeatCount = 0
                self.imageView.animationImages = images
                self.imageView.startAnimating()
        })
    }
    
    public func refreshAnimationDidEnd(view: ESRefreshComponent) {
        imageView.image = UIImage.init(named: "icon_pull_animation_1")
        imageView.stopAnimating()
    }
    
    public func refresh(view: ESRefreshComponent, progressDidChange progress: CGFloat) {
        let p = max(0.0, min(1.0, progress))
        imageView.frame = CGRect.init(x: (self.bounds.size.width - 39.0) / 2.0,
                                      y: self.bounds.size.height - 50.0 * p,
                                      width: 39.0,
                                      height: 50.0 * p)
    }
    
    public func refresh(view: ESRefreshComponent, stateDidChange state: ESRefreshViewState) {
        if self.state == state { return }
        self.state = state
        switch state {
        case .PullToRefresh:
            var images = [UIImage]()
            for idx in 1 ... 5 {
                if let aImage = UIImage(named: "icon_pull_animation_\((5 - idx + 1))") {
                    images.append(aImage)
                }
            }
            imageView.animationRepeatCount = 1
            imageView.animationImages = images
            imageView.image = UIImage.init(named: "icon_pull_animation_1")
            imageView.startAnimating()
            break
        case .ReleaseToRefresh:
            var images = [UIImage]()
            for idx in 1 ... 5 {
                if let aImage = UIImage(named: "icon_pull_animation_\(idx)") {
                    images.append(aImage)
                }
            }
            imageView.animationRepeatCount = 1
            imageView.animationImages = images
            imageView.image = UIImage.init(named: "icon_pull_animation_5")
            imageView.startAnimating()
            break
        default:
            
            break
        }
    }
    
}
