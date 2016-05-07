# pull-to-refresh
ESPullToRefresh is an easy way to give pull-to-refresh and loading-more to any UIScrollView. Using swift!

Thanks to: [SVPullToRefresh](https://github.com/samvermette/SVPullToRefresh) by [Sam Vermette](https://github.com/samvermette), [EGOTableViewPullRefresh](https://github.com/enormego/EGOTableViewPullRefresh) by [enormego](http://www.enormego.com).
 
They inspired me a lot.

![](https://github.com/eggswift/pull-to-refresh/blob/master/example_meituan.gif)

注: 加载动画资源来自美团 iOS app。

## Requirements
* Xcode 7 or later
* iOS 8.0 or later
* ARC
* Swift 2.0

## Demo

Open and run the ESPullToRefreshExample project in Xcode to see ESPullToRefresh in action.

## Installation

### CocoaPods

``` ruby
pod "ESPullToRefresh"
```

### Manual

Input ESPullToRefresh folder into your project.

## Example usage
Add an pull-to-refresh header to UITableView:
``` swift
self.tableView.es_addPullToRefresh {
[weak self] in
/// Do anything you want
/// ...
/// Stop refresh when your job finished, it will reset refresh footer if completion is true
self?.tableView.stopPullToRefresh(completion: true)
}
```

Add an infinite-scrolling footer to UITableView:
``` swift
self.tableView.es_addInfiniteScrolling {
[weak self] in
/// Do anything you want...
/// ...
/// If common end
self?.tableView.stopLoadingMore()
/// If no more data
self?.tableView.noticeNoMoreData()
}
```

### Description

Add default pull to refresh animator:

``` swift
func es_addPullToRefresh(handler: ESRefreshHandler)
```

Add default pull to refresh animator with custom height:

``` swift
func es_addPullToRefresh(height headerH: CGFloat, handler: ESRefreshHandler)
```

Add custom pull to refresh animator with custom height:

``` swift
func es_addPullToRefresh(height headerH: CGFloat, animator: protocol<ESRefreshProtocol, ESRefreshAnimatorProtocol>, handler: ESRefreshHandler)
```

Add default infinite scrolling animator:

``` swift
func es_addInfiniteScrolling(handler: ESRefreshHandler)
```

Add default infinite scrolling animator with custom height:

``` swift
func es_addInfiniteScrolling(height footerH: CGFloat, handler: ESRefreshHandler) 
```

Add custom infinite scrolling animator with custom height:

``` swift
func es_addInfiniteScrolling(height footerH: CGFloat, animator: protocol<ESRefreshProtocol, ESRefreshAnimatorProtocol>, handler: ESRefreshHandler)
```

Remove refresh:

``` swift
func removeRefreshHeader()
func removeRefreshFooter()
```

Start manual refresh:

``` swift
func startPullToRefresh()
```

Stop refresh:

``` swift
func stopPullToRefresh(completion completion: Bool, ignoreFooter: Bool)
func stopPullToRefresh(completion completion: Bool)
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

