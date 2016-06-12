//
//  ESPullToRefresh.swift
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

public enum ESRefreshViewState {
    case Loading
    case PullToRefresh
    case ReleaseToRefresh
    case NoMoreData
}

private var kESRefreshHeaderKey: String = ""
private var kESRefreshFooterKey: String = ""

public extension UIScrollView {
    
    /// Pull-to-refresh associated property
    public var es_header: ESRefreshHeaderView? {
        get { return (objc_getAssociatedObject(self, &kESRefreshHeaderKey) as? ESRefreshHeaderView) }
        set(newValue) { objc_setAssociatedObject(self, &kESRefreshHeaderKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    /// Infinitiy scroll associated property
    public var es_footer: ESRefreshFooterView? {
        get { return (objc_getAssociatedObject(self, &kESRefreshFooterKey) as? ESRefreshFooterView) }
        set(newValue) { objc_setAssociatedObject(self, &kESRefreshFooterKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN) }
    }
    
    /// Add pull-to-refresh
    public func es_addPullToRefresh(handler handler: ESRefreshHandler) -> ESRefreshHeaderView {
        es_removeRefreshHeader()
        let header = ESRefreshHeaderView(frame: CGRect.zero, handler: handler)
        let headerH = header.animator.executeIncremental
        header.frame = CGRect.init(x: 0.0, y: -headerH /* - contentInset.top */, width: bounds.size.width, height: headerH)
        addSubview(header)
        es_header = header
        return header
    }
    
    public func es_addPullToRefresh(animator animator: protocol<ESRefreshProtocol, ESRefreshAnimatorProtocol>, handler: ESRefreshHandler) -> ESRefreshHeaderView {
        es_removeRefreshHeader()
        let header = ESRefreshHeaderView(frame: CGRect.zero, handler: handler, customAnimator: animator)
        let headerH = animator.executeIncremental
        header.frame = CGRect.init(x: 0.0, y: -headerH /* - contentInset.top */, width: bounds.size.width, height: headerH)
        addSubview(header)
        es_header = header
        return header
    }
    
    /// Add infinite-scrolling
    public func es_addInfiniteScrolling(handler handler: ESRefreshHandler) -> ESRefreshFooterView {
        es_removeRefreshFooter()
        let footer = ESRefreshFooterView(frame: CGRect.zero, handler: handler)
        let footerH = footer.animator.executeIncremental
        footer.frame = CGRect.init(x: 0.0, y: contentSize.height + contentInset.bottom, width: bounds.size.width, height: footerH)
        addSubview(footer)
        es_footer = footer
        return footer
    }

    public func es_addInfiniteScrolling(animator animator: protocol<ESRefreshProtocol, ESRefreshAnimatorProtocol>, handler: ESRefreshHandler) -> ESRefreshFooterView {
        es_removeRefreshFooter()
        let footer = ESRefreshFooterView(frame: CGRect.zero, handler: handler, customAnimator: animator)
        let footerH = footer.animator.executeIncremental
        footer.frame = CGRect.init(x: 0.0, y: contentSize.height + contentInset.bottom, width: bounds.size.width, height: footerH)
        es_footer = footer
        addSubview(footer)
        return footer
    }
    
    /// Remove
    public func es_removeRefreshHeader() {
        es_header?.loading = false
        es_header?.removeFromSuperview()
        es_header = nil
    }
    
    public func es_removeRefreshFooter() {
        es_footer?.loading = false
        es_footer?.removeFromSuperview()
        es_footer = nil
    }
    
    /// Manual refresh
    public func es_startPullToRefresh() {
        es_header?.loading = true
    }
    
    /// Auto refresh if expried.
    public func es_autoPullToRefresh() {
        if self.expried == true {
            es_startPullToRefresh()
        }
    }
    
    /// Stop pull to refresh
    public func es_stopPullToRefresh(completion completion: Bool, ignoreFooter: Bool) {
        es_header?.loading = false
        if completion {
            // Refresh succeed
            if let key = self.es_header?.refreshIdentifier {
                ESRefreshDataManager.sharedManager.setDate(NSDate(), forKey: key)
            }
            es_footer?.resetNoMoreData()
        }
        es_footer?.hidden = ignoreFooter
    }
    
    public func es_stopPullToRefresh(completion completion: Bool) {
        es_stopPullToRefresh(completion: completion, ignoreFooter: false)
    }
    
    /// Footer notice method
    public func  es_noticeNoMoreData() {
        es_footer?.loading = false
        es_footer?.noMoreData = true
    }
    
    public func es_resetNoMoreData() {
        es_footer?.noMoreData = false
    }
    
    public func es_stopLoadingMore() {
        es_footer?.loading = false
    }
    
}

extension UIScrollView /* Date Manager */ {
    
    /// Identifier for cache expried timeinterval and last refresh date.
    public var refreshIdentifier: String? {
        get { return self.es_header?.refreshIdentifier }
        set { self.es_header?.refreshIdentifier = newValue }
    }
    
    /// If you setted refreshIdentifier and expriedTimeInterval, return nearest refresh expried or not. Default is false.
    public var expried: Bool {
        get {
            if let key = self.es_header?.refreshIdentifier {
                return ESRefreshDataManager.sharedManager.isExpried(forKey: key)
            }
            return false
        }
    }
    
    public var expriedTimeInterval: NSTimeInterval? {
        get {
            if let key = self.es_header?.refreshIdentifier {
                let interval = ESRefreshDataManager.sharedManager.expriedTimeInterval(forKey: key)
                return interval
            }
            return nil
        }
        set {
            if let key = self.es_header?.refreshIdentifier {
                ESRefreshDataManager.sharedManager.setExpriedTimeInterval(newValue, forKey: key)
            }
        }
    }
    
    /// Auto cached last refresh date when you setted refreshIdentifier.
    public var lastRefreshDate: NSDate? {
        get {
            if let key = self.es_header?.refreshIdentifier {
                return ESRefreshDataManager.sharedManager.date(forKey: key)
            }
            return nil
        }
    }
    
}


public class ESRefreshHeaderView: ESRefreshComponent {
    private var previousOffset: CGFloat = 0.0
    private var bounces: Bool = false
    private var scrollViewInsets: UIEdgeInsets = UIEdgeInsetsZero
    
    public var lastRefreshTimestamp: NSTimeInterval?
    public var refreshIdentifier: String?
    
    public convenience init(frame: CGRect, handler: ESRefreshHandler) {
        self.init(frame: frame)
        self.handler = handler
        self.animator = ESRefreshHeaderAnimator.init()
    }
    
    public override func didMoveToSuperview() {
        super.didMoveToSuperview()
        bounces = scrollView?.bounces ?? false
        scrollViewInsets = scrollView?.contentInset ?? UIEdgeInsetsZero
    }
    
    public override func offsetChangeAction(object object: AnyObject?, change: [String : AnyObject]?) {
        guard let scrollView = scrollView else { return }
        super.offsetChangeAction(object: object, change: change)
        var update = false // Check needs re-set animator's progress or not.
        let offsetWithoutInsets = previousOffset + scrollViewInsets.top
        if offsetWithoutInsets < -self.animator.trigger {
            // Reached critical
            if loading == false && animating == false {
                if scrollView.dragging == false {
                    // Start to refresh!
                    self.loading = true
                } else {
                    // Release to refresh! Please drop down hard...
                    self.animator.refresh(self, stateDidChange: .ReleaseToRefresh)
                    update = true
                }
            }
        } else if offsetWithoutInsets < 0 {
            // Pull to refresh!
            if loading == false && animating == false {
                self.animator.refresh(self, stateDidChange: .PullToRefresh)
                update = true
            }
        } else {
            
        }
        defer {
            previousOffset = scrollView.contentOffset.y
            if update == true {
                let percent = -offsetWithoutInsets / self.animator.trigger
                self.animator.refresh(self, progressDidChange: percent)
            }
        }
    }
    
    public override func startAnimating() {
        guard let scrollView = scrollView else { return }
        super.startAnimating()
        self.animator.refreshAnimationDidBegin(self)
        var insets = scrollView.contentInset
        insets.top += animator.executeIncremental
        // we need to restore previous offset because we will animate scroll view insets and regular scroll view animating is not applied then
        scrollView.contentOffset.y = previousOffset
        scrollView.bounces = false
        UIView.animateWithDuration(0.2, delay: 0, options: .CurveLinear, animations: {
            scrollView.contentInset = insets
            scrollView.contentOffset = CGPoint.init(x: scrollView.contentOffset.x, y: -insets.top)
            }, completion: { (finished) in
                self.animator.refresh(self, stateDidChange: .Loading) // Loading state
                // Navigation will automatically add 64, we are here to deal with part of the logic
                if scrollView.contentInset.top != insets.top || scrollView.contentOffset.x != -insets.top {
                    UIView .animateWithDuration(0.2, animations: {
                        scrollView.contentInset = insets
                        scrollView.contentOffset = CGPoint.init(x: scrollView.contentOffset.x, y: -insets.top)
                    })
                }
                self.handler?()
        })
    }
    
    public override func stopAnimating() {
        guard let scrollView = scrollView else {
            return
        }
        self.animator.refreshAnimationDidEnd(self)
        self.animator.refresh(self, stateDidChange: .PullToRefresh)
        scrollView.bounces = self.bounces
        UIView.animateWithDuration(0.3, delay: 0, options: .CurveLinear, animations: {
            scrollView.contentInset.top = self.scrollViewInsets.top
            self.animator.refresh(self, progressDidChange: 0.0) // If you need to complete with animation
            }, completion: { (finished) in
                super.stopAnimating()
        })
    }
    
}

public class ESRefreshFooterView: ESRefreshComponent {
    private var scrollViewInsets: UIEdgeInsets = UIEdgeInsetsZero
    public var noMoreData = false {
        didSet {
            if noMoreData != oldValue {
                if noMoreData {
                    self.animator.refresh(self, stateDidChange: .NoMoreData)
                } else {
                    self.animator.refresh(self, stateDidChange: .PullToRefresh)
                }
            }
        }
    }
    public override var hidden: Bool {
        didSet {
            if hidden == true {
                scrollView?.contentInset.bottom = scrollViewInsets.bottom
                var rect = self.frame
                rect.origin.y = scrollView?.contentSize.height ?? 0.0
                self.frame = rect
            } else {
                scrollView?.contentInset.bottom = scrollViewInsets.bottom + animator.executeIncremental
                var rect = self.frame
                rect.origin.y = scrollView?.contentSize.height ?? 0.0
                self.frame = rect
            }
        }
    }
    
    public convenience init(frame: CGRect, handler: ESRefreshHandler) {
        self.init(frame: frame)
        self.handler = handler
        self.animator = ESRefreshFooterAnimator.init()
    }
    
    public override func didMoveToSuperview() {
        super.didMoveToSuperview()
        // Cache superview's contentInset etc.
        scrollViewInsets = scrollView?.contentInset ?? UIEdgeInsetsZero
        scrollView?.contentInset.bottom = scrollViewInsets.bottom + self.bounds.size.height
        var rect = self.frame
        rect.origin.y = scrollView?.contentSize.height ?? 0.0
        self.frame = rect
    }
 
    public override func sizeChangeAction(object object: AnyObject?, change: [String : AnyObject]?) {
        guard let scrollView = scrollView else { return }
        super.sizeChangeAction(object: object, change: change)
        let targetY = scrollView.contentSize.height + scrollViewInsets.bottom
        if self.frame.origin.y != targetY {
            var rect = self.frame
            rect.origin.y = targetY
            self.frame = rect
        }
    }
    
    public override func offsetChangeAction(object object: AnyObject?, change: [String : AnyObject]?) {
        guard let scrollView = scrollView else { return }
        super.offsetChangeAction(object: object, change: change)
        if self.loading == true  || self.noMoreData == true || animating == true || hidden == true {
            // 正在loading more或者内容为空时不相应变化
            return
        }
        if scrollView.contentSize.height <= 0.0 || scrollView.contentOffset.y + scrollView.contentInset.top <= 0.0 {
            self.alpha = 0.0
            return
        } else {
            self.alpha = 1.0
        }
        if scrollView.contentSize.height + scrollView.contentInset.top > scrollView.bounds.size.height {
            // 内容超过一个屏幕 计算公式，判断是不是在拖在到了底部
            if scrollView.contentSize.height - scrollView.contentOffset.y + scrollView.contentInset.bottom  <= scrollView.bounds.size.height {
                self.loading = true
            }
        } else {
            //内容没有超过一个屏幕，这时拖拽高度大于1/2footer的高度就表示请求上拉
            if scrollView.contentOffset.y + scrollView.contentInset.top >= animator.trigger / 2.0 {
                self.loading = true
            }
        }
    }
    
    public override func startAnimating() {
        if let _ = scrollView {
            super.startAnimating()
            self.animator.refreshAnimationDidBegin(self)
            UIView.animateWithDuration(0.3, delay: 0.0, options: .CurveLinear, animations: {
                if let scrollView = self.scrollView {
                    let x = scrollView.contentOffset.x
                    let y = max(0.0, scrollView.contentSize.height - scrollView.bounds.size.height + scrollView.contentInset.bottom)
                    scrollView.contentOffset = CGPoint.init(x: x, y: y)
                }
                }, completion: { (animated) in
                    self.animator.refresh(self, stateDidChange: .Loading)
                    self.handler?()
            })
        }
    }
    
    public override func stopAnimating() {
        guard let _ = scrollView else {
            return
        }
        self.animator.refreshAnimationDidEnd(self)
        self.animator.refresh(self, stateDidChange: .PullToRefresh)
        self.animator.refresh(self, progressDidChange: 0.0)
        super.stopAnimating()
    }
    
    /// Change to no-more-data status.
    public func noticeNoMoreData() {
        self.noMoreData = true
    }
    
    /// Reset no-more-data status.
    public func resetNoMoreData() {
        self.noMoreData = false
    }
    
}
