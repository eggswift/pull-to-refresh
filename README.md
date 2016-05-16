# ESPullToRefresh  [中文介绍](README_CN.md)

ESPullToRefresh is an easy-to-use component that give `pull-to-refresh` and `infinite-scrolling` implemention for developers. By extension to UIScrollView, you can easily add pull-to-refresh and infinite-scrolling for any subclass of UIScrollView. If you want to customize its UI style, you just need conform the specified protocol.

Thanks to: [SVPullToRefresh](https://github.com/samvermette/SVPullToRefresh) by [Sam Vermette](https://github.com/samvermette),  [EGOTableViewPullRefresh](https://github.com/enormego/EGOTableViewPullRefresh) by [enormego](http://www.enormego.com),  these projects inspired me a lot.

## Requirements

* Xcode 7 or later
* iOS 8.0 or later
* ARC
* Swift 2.0

## Demo

Download and run the ESPullToRefreshExample project in Xcode to see ESPullToRefresh in action.


## Installation

### 使用CocoaPods

``` ruby
pod "ESPullToRefresh"
```

### Manual

``` ruby
git clone https://github.com/eggswift/pull-to-refresh.git
open ESPullToRefresh
```

## Start usage

### Default style:

#### As effect:

![](example_default.gif)



Add default pull-to-refresh
``` swift
self.tableView.es_addPullToRefresh {
[weak self] in
/// Do anything you want...
/// ...
/// Stop refresh when your job finished, it will reset refresh footer if completion is true
self?.tableView.es_stopPullToRefresh(completion: true)
/// Set ignore footer or not
self?.tableView.es_stopPullToRefresh(completion: true, ignoreFooter: false)
})
}
```

Add default infinite-scrolling
``` swift
self.tableView.es_addInfiniteScrolling {
[weak self] in
/// Do anything you want...
/// ...
/// If common end
self?.tableView.es_stopLoadingMore()
/// If no more data
self?.tableView.es_noticeNoMoreData()
})
}
```


### Customize Style

#### As effect:

![](example_meituan.gif)

注: 加载动画资源来自美团 iOS app。

![](example_wechat.gif)


Customize refresh need conform the `ESRefreshProtocol` and `ESRefreshAnimatorProtocol` protocol.

Add customize pull-to-refresh
``` swift
func es_addPullToRefresh(animator animator: protocol<ESRefreshProtocol, ESRefreshAnimatorProtocol>, 
handler: ESRefreshHandler)
```

Add customize infinite-scrolling
``` swift
func es_addInfiniteScrolling(animator animator: protocol<ESRefreshProtocol, ESRefreshAnimatorProtocol>, 
handler: ESRefreshHandler)
```

### Remove

``` swift
func es_removeRefreshHeader()
func es_removeRefreshFooter()
```


## Contribution

You are welcome to contribute to the project by forking the repo, modifying the code and opening issues or pull requests.

## License

The MIT License (MIT)

Copyright (c) 2013-2015 eggswift (https://github.com/eggswift/pull-to-refresh)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

