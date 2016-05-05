//
//  ESRefreshComponent.swift
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
import UIKit

public typealias ESRefreshHandler = () -> ()

public class ESRefreshComponent: UIView {
    
    private static var context = "ESRefreshKVOContext"
    private static let offsetKeyPath = "contentOffset"
    private static let contentSizeKeyPath = "contentSize"
    
    public weak var scrollView: UIScrollView?
    /// 刷新事件的回调函数
    public var handler: ESRefreshHandler?
    /// @param animator 刷新控件的动画处理视图，自定义必须遵守以下两个协议
    public var animator: protocol<ESRefreshProtocol, ESRefreshAnimatorProtocol>!
    /// 设置是否为加载状态
    public var animating: Bool = false
    public var loading: Bool = false {
        didSet {
            if loading != oldValue {
                if loading {
                    startAnimating()
                } else {
                    stopAnimating()
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        autoresizingMask = [.FlexibleWidth]
        configUI()
    }
    
    public convenience init(frame: CGRect, handler: ESRefreshHandler) {
        self.init(frame: frame)
        self.handler = handler
    }
    
    public convenience init(frame: CGRect, handler: ESRefreshHandler, customAnimator animator: protocol<ESRefreshProtocol, ESRefreshAnimatorProtocol>) {
        self.init(frame: frame)
        self.handler = handler
        self.animator = animator
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        removeObserver()
    }
    
    override public func willMoveToSuperview(newSuperview: UIView?) {
        super.willMoveToSuperview(newSuperview)
        // 删除老superView的监听事件
        removeObserver()
        // 添加新的superView的监听事件
        addObserver(newSuperview)
    }
    
    override public func didMoveToSuperview() {
        super.didMoveToSuperview()
        // 更新当前scrollView属性
        self.scrollView = self.superview as? UIScrollView
    }
    
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
    
    //MARK: KVO methods
    override public func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
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
    
    // 开始刷新动画
    func startAnimating() -> Void {
        animating = true
    }
    
    // 结束刷新动画
    func stopAnimating() -> Void {
        animating = false
    }
    
    // 初始化时配置方法
    func configUI() {
        if let _ = animator {
            self.addSubview(animator.animatorView)
            self.animator.animatorView.autoresizingMask = [.FlexibleWidth]
        }
    }

    //  scrollView contentSize 变化响应事件
    func sizeChangeAction(object object: AnyObject?, change: [String : AnyObject]?) {
        
    }
    
    //  scrollView offset 变化响应事件
    func offsetChangeAction(object object: AnyObject?, change: [String : AnyObject]?) {
        
    }
    
}
