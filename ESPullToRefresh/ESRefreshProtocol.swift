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

public protocol ESRefreshProtocol {
    // Swift 的 mutating 关键字修饰方法是为了能在该方法中修改 struct 或是 enum 的变量
    // http://swifter.tips/protocol-mutation/ by ONEVCAT
    mutating func refreshAnimationDidBegin(view: ESRefreshComponent)
    mutating func refreshAnimationDidEnd(view: ESRefreshComponent)
    mutating func refresh(view: ESRefreshComponent, progressDidChange progress: CGFloat)
    mutating func refresh(view: ESRefreshComponent, stateDidChange state: ESRefreshViewState)
}

public protocol ESRefreshAnimatorProtocol {
    var animatorView: UIView {get}
}
