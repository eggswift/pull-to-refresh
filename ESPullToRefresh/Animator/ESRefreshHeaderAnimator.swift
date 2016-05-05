//
//  ESRefreshHeaderView.swift
//
//  Created by egg swift on 16/4/7.
//  Copyright (c) 2013-2015 ESPullToRefresh (https://github.com/eggswift/pull-to-refresh)
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
    private var imageView: UIImageView!
    
    public var animatorInsets: UIEdgeInsets = UIEdgeInsetsZero
    
    public var animatorView: UIView {
        return self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        imageView = UIImageView.init()
        self.addSubview(imageView)
    }
    
    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func refreshAnimationDidBegin(view: ESRefreshComponent) {
        imageView.startAnimating()
    }
  
    public func refreshAnimationDidEnd(view: ESRefreshComponent) {
        imageView.stopAnimating()
    }
    
    public func refresh(view: ESRefreshComponent, progressDidChange progress: CGFloat) {
        let percent = max(0.0, min(1.0, progress * 1.2))
        let s = CGSize.init(width: 139 * 0.7, height: 110 * 0.7)
        let p = CGPoint.init(x: (self.bounds.size.width - s.width) / 2.0, y: (self.bounds.size.height / 2.0) * (1 + percent) - (s.height - 15 * 0.7) * percent)
        imageView.alpha = percent
        imageView.frame = CGRect.init(origin: p, size: s)
    }
    
    public func refresh(view: ESRefreshComponent, stateDidChange state: ESRefreshViewState) {
        
    }

}
