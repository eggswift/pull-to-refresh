//
//  ESRefreshFooterAnimator.swift
//
//  Created by egg swift on 16/4/7.
//  Copyright (c) 2013-2016 ESPullToRefresh (https://github.com/eggswift/pull-to-refresh)
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

import UIKit

public class ESRefreshFooterAnimator: UIView, ESRefreshProtocol, ESRefreshAnimatorProtocol {
    public var loadingMoreDescription: String = "Loading more"
    public var noMoreDataDescription: String  = "No more data"
    public var loadingDescription: String     = "Loading..."

    public var view: UIView { return self }
    public var insets: UIEdgeInsets = UIEdgeInsetsZero
    public var trigger: CGFloat = 42.0
    public var executeIncremental: CGFloat = 42.0
    
    private let titleLabel: UILabel = {
        let label = UILabel.init(frame: CGRect.zero)
        label.font = UIFont.systemFontOfSize(14.0)
        label.textColor = UIColor.init(white: 160.0 / 255.0, alpha: 1.0)
        label.textAlignment = .Center
        return label
    }()
    
    private let indicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView.init(activityIndicatorStyle: .Gray)
        indicatorView.hidden = true
        return indicatorView
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel.text = loadingMoreDescription
        addSubview(titleLabel)
        addSubview(indicatorView)
    }
    
    public required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func refreshAnimationDidBegin(view: ESRefreshComponent) {
        indicatorView.startAnimating()
        titleLabel.text = loadingDescription
        indicatorView.hidden = false
    }
    
    public func refreshAnimationDidEnd(view: ESRefreshComponent) {
        indicatorView.stopAnimating()
        titleLabel.text = loadingMoreDescription
        indicatorView.hidden = true
    }
    
    public func refresh(view: ESRefreshComponent, progressDidChange progress: CGFloat) {
        // do nothing
    }
    
    public func refresh(view: ESRefreshComponent, stateDidChange state: ESRefreshViewState) {
        switch state {
        case .Loading:
            titleLabel.text = loadingDescription
            break
        case .NoMoreData:
            titleLabel.text = noMoreDataDescription
            break
        default:
            titleLabel.text = loadingMoreDescription
            break
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        let s = self.bounds.size
        let w = s.width
        let h = s.height
        let s1 = titleLabel.sizeThatFits(self.bounds.size)
        
        titleLabel.frame = CGRect.init(x: (w - s1.width) / 2.0 + 8.0, y: (h - s1.height) / 2.0, width: s1.width, height: s1.height)
        indicatorView.center = CGPoint.init(x: titleLabel.frame.origin.x - 18.0, y: h / 2.0)
    }
}
