//
//  ESRefreshProtocol.swift
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

/**
 *  ESRefreshProtocol 动画事件处理回调协议
 *  通过ESRefreshProtocol 你可以自定义刷新动画或任何效果
 */
public protocol ESRefreshProtocol {
    // Swift 的 mutating 关键字修饰方法是为了能在该方法中修改 struct 或是 enum 的变量
    // http://swifter.tips/protocol-mutation/ by ONEVCAT
    /**
     刷新动作开始执行方法
     你可以在这里实现你的刷新动画逻辑，它会在每次刷新动画需要开始时执行一次
    */
    mutating func refreshAnimationDidBegin(view: ESRefreshComponent)
    /**
     刷新动作停止执行方法
     你可以在这里重置你的刷新控件UI，比如停止UIImageView的动画或一些刷新时开启的Timer等，它会在每次动画需要结束时执行一次
     */
    mutating func refreshAnimationDidEnd(view: ESRefreshComponent)
    mutating func refresh(view: ESRefreshComponent, progressDidChange progress: CGFloat)
    mutating func refresh(view: ESRefreshComponent, stateDidChange state: ESRefreshViewState)
}

public protocol ESRefreshAnimatorProtocol {
    var animatorView: UIView {get}
    var animatorInsets: UIEdgeInsets {set get}
}
