//
//  ESRefreshProtocol.swift
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

/**
 *  ESRefreshProtocol     
 *  Animation event handling callback protocol
 *  You can customize the refresh or custom animation effects
 */
public protocol ESRefreshProtocol {
    // Mutating is to be able to modify or enum struct variable in the method
    // http://swifter.tips/protocol-mutation/ by ONEVCAT
    /**
     Refresh operation begins execution method
     You can refresh your animation logic here, it will need to start the animation each time a refresh
    */
    mutating func refreshAnimationDidBegin(view: ESRefreshComponent)
    /**
     Refresh operation stop execution method
     Here you can reset your refresh control UI, such as a Stop UIImageView animations or some opened Timer refresh, etc., it will be executed once each time the need to end the animation
     */
    mutating func refreshAnimationDidEnd(view: ESRefreshComponent)
    mutating func refresh(view: ESRefreshComponent, progressDidChange progress: CGFloat)
    mutating func refresh(view: ESRefreshComponent, stateDidChange state: ESRefreshViewState)
}

public protocol ESRefreshAnimatorProtocol {
    var view: UIView {get}
    var insets: UIEdgeInsets {set get}
    var trigger: CGFloat {set get}
    var executeIncremental: CGFloat {set get}
    
    
}
