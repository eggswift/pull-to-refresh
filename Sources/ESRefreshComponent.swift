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

public typealias ESRefreshHandler = (() -> ())

open class ESRefreshComponent: UIView {
    
    open weak var scrollView: UIScrollView?
    
    /// @param handler Refresh callback method
    open var handler: ESRefreshHandler?
    
    /// @param animator Animated view refresh controls, custom must comply with the following two protocol
    open var animator: (ESRefreshProtocol & ESRefreshAnimatorProtocol)!
    
    /// @param refreshing or not
    fileprivate var _isRefreshing = false
    open var isRefreshing: Bool {
        get {
            return self._isRefreshing
        }
    }
    
    /// @param auto refreshing or not
    fileprivate var _isAutoRefreshing = false
    open var isAutoRefreshing: Bool {
        get {
            return self._isAutoRefreshing
        }
    }
    
    /// @param tag observing
    fileprivate var isObservingScrollView = false
    fileprivate var isIgnoreObserving = false
    fileprivate var offsetObservation: NSKeyValueObservation? {
        willSet {
            offsetObservation?.invalidate()
        }
    }
    fileprivate var sizeObservation: NSKeyValueObservation? {
        willSet {
            sizeObservation?.invalidate()
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        autoresizingMask = [.flexibleLeftMargin, .flexibleWidth, .flexibleRightMargin]
    }
    
    public convenience init(frame: CGRect, handler: @escaping ESRefreshHandler) {
        self.init(frame: frame)
        self.handler = handler
        self.animator = ESRefreshAnimator.init()
    }
    
    public convenience init(frame: CGRect, handler: @escaping ESRefreshHandler, animator: ESRefreshProtocol & ESRefreshAnimatorProtocol) {
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
    
    open override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        /// Remove observer from superview immediately
        self.removeObserver()
        DispatchQueue.main.async { [weak self, newSuperview] in
            /// Add observer to new superview in next runloop
            self?.addObserver(newSuperview)
        }
    }
    
    open override func didMoveToSuperview() {
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
                v.autoresizingMask = [
                    .flexibleWidth,
                    .flexibleTopMargin,
                    .flexibleHeight,
                    .flexibleBottomMargin
                ]
            }
        }
    }

    // MARK: - Action

    public final func startRefreshing(isAuto: Bool = false) -> Void {
        guard isRefreshing == false && isAutoRefreshing == false else {
            return
        }

        _isRefreshing = !isAuto
        _isAutoRefreshing = isAuto

        self.start()
    }

    public final func stopRefreshing() -> Void {
        guard isRefreshing == true || isAutoRefreshing == true else {
            return
        }

        self.stop()
    }

    public func start() {

    }

    public func stop() {
        _isRefreshing = false
        _isAutoRefreshing = false
    }

    //  ScrollView contentSize change action
    public func sizeChangeAction(scrollView: UIScrollView, value: NSKeyValueObservedChange<CGSize>) {
    }

    //  ScrollView offset change action
    public func offsetChangeAction(scrollView: UIScrollView, value: NSKeyValueObservedChange<CGPoint>) {
    }

}

extension ESRefreshComponent /* Block-based KVO methods */ {

    public func ignoreObserver(_ ignore: Bool = false) {
        if let scrollView = scrollView {
            scrollView.isScrollEnabled = !ignore
        }
        isIgnoreObserving = ignore
    }

    fileprivate func addObserver(_ view: UIView?) {
        guard
            let scrollView = view as? UIScrollView,
            !isObservingScrollView
        else { return }

        offsetObservation = scrollView.observe(\UIScrollView.contentOffset,
                                               options: [.initial, .new]) { [weak self] sv, value in
                                                guard
                                                    let `self` = self,
                                                    !self.isIgnoreObserving
                                                else { return }

                                                self.offsetChangeAction(scrollView: sv, value: value)
        }

        sizeObservation = scrollView.observe(\UIScrollView.contentSize,
                                             options: [.initial, .new]) { [weak self] sv, value in
                                                guard
                                                    let `self` = self,
                                                    !self.isIgnoreObserving
                                                else { return }

                                                self.sizeChangeAction(scrollView: sv, value: value)
        }

        isObservingScrollView = true
    }

    fileprivate func removeObserver() {
        guard isObservingScrollView else { return }

        offsetObservation?.invalidate()
        sizeObservation?.invalidate()
        isObservingScrollView = false
    }
}

