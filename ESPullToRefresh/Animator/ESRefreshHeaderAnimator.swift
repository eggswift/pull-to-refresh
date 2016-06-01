//
//  ESRefreshHeaderView.swift
//
//  Created by egg swift on 16/4/7.
//  Copyright (c) 2013-2016 ESPullToRefresh (https://github.com/eggswift/pull-to-refresh)
//  Icon from http://www.iconfont.cn
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation
import QuartzCore
import UIKit

public class ESRefreshHeaderAnimator: UIView, ESRefreshProtocol, ESRefreshAnimatorProtocol {
    public var pullToRefreshDescription: String     = "Pull to refresh"
    public var releaseToRefreshDescription: String  = "Release to refresh"
    public var loadingDescription: String           = "Loading..."
    
    public var insets: UIEdgeInsets = UIEdgeInsetsZero
    public var trigger: CGFloat = 60.0
    public var executeIncremental: CGFloat = 60.0
    public var view: UIView { return self }
    
    private let imageView: UIImageView = {
        let imageView = UIImageView.init()
        imageView.image = UIImage.init(named: "icon_pull_to_refresh_arrow")
        return imageView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel.init(frame: CGRect.zero)
        label.font = UIFont.systemFontOfSize(14.0)
        label.textColor = UIColor.init(white: 160.0 / 255.0, alpha: 1.0)
        label.textAlignment = .Left
        return label
    }()
    
    private let indicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView.init(activityIndicatorStyle: .Gray)
        indicatorView.hidden = true
        return indicatorView
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel.text = pullToRefreshDescription
        self.addSubview(imageView)
        self.addSubview(titleLabel)
        self.addSubview(indicatorView)
    }
    
    public required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func refreshAnimationDidBegin(view: ESRefreshComponent) {
        indicatorView.startAnimating()
        indicatorView.hidden = false
        imageView.hidden = true
        titleLabel.text = loadingDescription
        UIView.animateWithDuration(0.2, delay: 0.0, options: .CurveEaseInOut, animations: { 
            [weak self] in
            self?.imageView.transform = CGAffineTransformMakeRotation(0.000001 - CGFloat(M_PI))
            }) { (animated) in
        }
    }
  
    public func refreshAnimationDidEnd(view: ESRefreshComponent) {
        indicatorView.stopAnimating()
        indicatorView.hidden = true
        imageView.hidden = false
        titleLabel.text = pullToRefreshDescription
        imageView.transform = CGAffineTransformIdentity
    }
    
    public func refresh(view: ESRefreshComponent, progressDidChange progress: CGFloat) {
        // Do nothing
        
    }
    
    public func refresh(view: ESRefreshComponent, stateDidChange state: ESRefreshViewState) {
        switch state {
        case .Loading:
            titleLabel.text = loadingDescription
            break
        case .ReleaseToRefresh:
            titleLabel.text = releaseToRefreshDescription
            UIView.animateWithDuration(0.2, delay: 0.0, options: .CurveEaseInOut, animations: {
                [weak self] in
                self?.imageView.transform = CGAffineTransformMakeRotation(0.000001 - CGFloat(M_PI))
                self?.layoutIfNeeded()
            }) { (animated) in }
            break
        default:
            titleLabel.text = pullToRefreshDescription
            UIView.animateWithDuration(0.2, delay: 0.0, options: .CurveEaseInOut, animations: {
                [weak self] in
                self?.imageView.transform = CGAffineTransformIdentity
                self?.layoutIfNeeded()
            }) { (animated) in }
            break
        }
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        let s = self.bounds.size
        let w = s.width
        let h = s.height
        
        titleLabel.frame = CGRect.init(x: w / 2.0 - 36.0, y: 0.0, width: w - (w / 2.0 - 36.0), height: h)
        indicatorView.center = CGPoint.init(x: titleLabel.frame.origin.x - 16.0, y: h / 2.0)
        imageView.frame = CGRect.init(x: titleLabel.frame.origin.x - 28.0, y: (h - 18.0) / 2.0, width: 18.0, height: 18.0)
    }
    
}
