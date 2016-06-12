//
//  ESRefreshComponent.swift
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

import Foundation
import UIKit

public typealias ESRefreshHandler = () -> ()

public class ESRefreshComponent: UIView {
    
    private static var context = "ESRefreshKVOContext"
    private static let offsetKeyPath = "contentOffset"
    private static let contentSizeKeyPath = "contentSize"
    
    public weak var scrollView: UIScrollView?
    /// @param handler Refresh callback method
    public var handler: ESRefreshHandler?
    /// @param animator Animated view refresh controls, custom must comply with the following two protocol
    public var animator: protocol<ESRefreshProtocol, ESRefreshAnimatorProtocol>!
    public var animating: Bool = false
    public var loading: Bool = false {
        didSet {
            if loading != oldValue {
                if loading { startAnimating() }
                else { stopAnimating() }
            }
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        autoresizingMask = [.FlexibleLeftMargin, .FlexibleWidth, .FlexibleRightMargin]
    }
    
    public convenience init(frame: CGRect, handler: ESRefreshHandler) {
        self.init(frame: frame)
        self.handler = handler
        self.animator = ESRefreshAnimator.init()
    }
    
    public convenience init(frame: CGRect, handler: ESRefreshHandler, customAnimator animator: protocol<ESRefreshProtocol, ESRefreshAnimatorProtocol>) {
        self.init(frame: frame)
        self.handler = handler
        self.animator = animator
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        removeObserver()
    }
    
    public override func willMoveToSuperview(newSuperview: UIView?) {
        super.willMoveToSuperview(newSuperview)
        /// Remove observer from superview
        removeObserver()
        /// Add observer to new superview
        addObserver(newSuperview)
    }
    
    public override func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.scrollView = self.superview as? UIScrollView
        if let _ = animator {
            let v = animator.view
            if v.superview == nil {
                let inset = animator.insets
                self.addSubview(v)
                v.frame = CGRect.init(x: inset.left,
                                      y: inset.right,
                                      width: self.bounds.size.width - inset.left - inset.right,
                                      height: self.bounds.size.height - inset.top - inset.bottom)
                v.autoresizingMask = [.FlexibleLeftMargin,
                                      .FlexibleWidth,
                                      .FlexibleRightMargin,
                                      .FlexibleTopMargin,
                                      .FlexibleHeight,
                                      .FlexibleBottomMargin]
            }
        }
    }
    
}

public extension ESRefreshComponent /* KVO methods */ {
    
    private func addObserver(view: UIView?) {
        if let scrollView = view as? UIScrollView {
            scrollView.addObserver(self, forKeyPath: ESRefreshComponent.offsetKeyPath, options: [.Initial, .New], context: &ESRefreshComponent.context)
            scrollView.addObserver(self, forKeyPath: ESRefreshComponent.contentSizeKeyPath, options: [.Initial, .New], context: &ESRefreshComponent.context)
        }
    }
    
    private func removeObserver() {
        if let scrollView = superview as? UIScrollView {
            scrollView.removeObserver(self, forKeyPath: ESRefreshComponent.offsetKeyPath, context: &ESRefreshComponent.context)
            scrollView.removeObserver(self, forKeyPath: ESRefreshComponent.contentSizeKeyPath, context: &ESRefreshComponent.context)
        }
    }
    
    public override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if context == &ESRefreshComponent.context {
            guard userInteractionEnabled == true && hidden == false else {
                return
            }
            if keyPath == ESRefreshComponent.contentSizeKeyPath {
                sizeChangeAction(object: object, change: change)
            } else if keyPath == ESRefreshComponent.offsetKeyPath {
                offsetChangeAction(object: object, change: change)
            }
        } else {
            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
        }
    }
    
}

public extension ESRefreshComponent /* Action */ {

    public func startAnimating() -> Void {
        animating = true
    }
    
    public func stopAnimating() -> Void {
        animating = false
    }

    //  ScrollView contentSize change action
    public func sizeChangeAction(object object: AnyObject?, change: [String : AnyObject]?) {
        
    }
    
    //  ScrollView offset change action
    public func offsetChangeAction(object object: AnyObject?, change: [String : AnyObject]?) {
        
    }
    
}

