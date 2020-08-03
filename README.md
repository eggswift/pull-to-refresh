
<!-- ![logo](logo.png) -->

[![Travis](https://travis-ci.org/eggswift/pull-to-refresh.svg?branch=master)](https://travis-ci.org/eggswift/pull-to-refresh)
[![CocoaPods](https://img.shields.io/cocoapods/v/ESPullToRefresh.svg)](http://cocoapods.org/pods/pull-to-refresh)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Swift v3](https://img.shields.io/badge/Swift-v3-orange.svg?style=flat)](https://developer.apple.com/swift/)
[![Twitter](https://img.shields.io/badge/Twitter-@lihao_iOS-blue.svg?style=flat)](https://twitter.com/lihao_iOS)
[![Twitter](https://img.shields.io/badge/Weibo-@李昊_____-orange.svg?style=flat)](http://weibo.com/5120522686/profile?rightmod=1&wvr=6&mod=personinfo&is_all=1)

### [中文介绍](README_CN.md)

**ESPullToRefresh** is an easy-to-use component that give **pull-to-refresh** and **infinite-scrolling** implemention for developers. By extension to UIScrollView, you can easily add pull-to-refresh and infinite-scrolling for any subclass of UIScrollView. If you want to customize its UI style, you just need conform the specified protocol.


## Requirements

* Xcode 8 or later
* iOS 8.0 or later
* ARC
* Swift 5.0 or later

## Features

* Support `UIScrollView` and its subclasses `UICollectionView` `UITableView` `UITextView`
* Pull-Down to refresh and Pull-Up to load more
* Support customize your own style(s)

## Demo

Download and run the ESPullToRefreshExample project in Xcode to see ESPullToRefresh in action.


## Installation

### CocoaPods

``` ruby
pod "ESPullToRefresh"
```

### Carthage

```ruby
github "eggswift/pull-to-refresh"
```

### Manually

``` ruby
git clone https://github.com/eggswift/pull-to-refresh.git
open ESPullToRefresh
```

## Usage

### Default style:


![](example_default.gif)



Add `ESPullToRefresh` to your project

```swift
import ESPullToRefresh
```

Add default pull-to-refresh

``` swift
self.tableView.es.addPullToRefresh {
	[unowned self] in
	/// Do anything you want...
	/// ...
	/// Stop refresh when your job finished, it will reset refresh footer if completion is true
	self.tableView.es.stopPullToRefresh(completion: true)
	/// Set ignore footer or not
	self.tableView.es.stopPullToRefresh(completion: true, ignoreFooter: false)
}
```

Add default infinite-scrolling
``` swift
self.tableView.es.addInfiniteScrolling {
	[unowned self] in
	/// Do anything you want...
	/// ...
	/// If common end
	self.tableView.es.stopLoadingMore()
	/// If no more data
	self.tableView.es.noticeNoMoreData()
}
```


### Customize Style

#### As effect:

![](example_meituan.gif)

**PS: Load effect is from MeiTuan iOS app.**

![](example_wechat.gif)


Customize refresh need conform the **ESRefreshProtocol** and **ESRefreshAnimatorProtocol** protocol.

Add customize pull-to-refresh

``` swift
func es.addPullToRefresh(animator animator: protocol<ESRefreshProtocol, ESRefreshAnimatorProtocol>, handler: ESRefreshHandler)
```

Add customize infinite-scrolling

``` swift
func es.addInfiniteScrolling(animator animator: protocol<ESRefreshProtocol, ESRefreshAnimatorProtocol>, handler: ESRefreshHandler)
```

### Espried and auto refresh

ESPullToRefresh support for the latest expiration time and the cache refresh time, You need set an `refreshIdentifier` to your UIScrollView.
``` swift
scrollView.refreshIdentifier = "Your Identifier" // Set refresh identifier
scrollView.expriedTimeInterval = 20.0 // Set the expiration interval
```
You can use `es.autoPullToRefresh()` method, when the time over the last refresh interval expires automatically refreshed.
``` swift
scrollView.es.autoPullToRefresh()

let expried = scrollView.espried // expired or not
```


### Remove

``` swift
func es.removeRefreshHeader()
func es.removeRefreshFooter()
```


## Sponsor

You can support the project by checking out our sponsor page. It takes only one click:

<a href='https://tracking.gitads.io/?repo=pull-to-refresh'><img src="https://images.gitads.io/pull-to-refresh" alt="git-ad"/></a>
<br><i>This advert was placed by <a href="https://tracking.gitads.io/?campaign=gitads&repo=pull-to-refresh&redirect=gitads.io">GitAds</a> </i>


## About

ESPullToRefresh is developed and maintained by [Vincent Li](mailto:lihao_iOS@hotmail.com). If you have any questions or issues in using ESPullToRefresh, welcome to [issue](https://github.com/eggswift/pull-to-refresh/issues). </br>
If you want to contribute to ESPullToRefresh, Please submit [Pull Request](https://github.com/eggswift/pull-to-refresh/pulls), I will deal with it as soon as possible. </br>

[![Twitter URL](https://img.shields.io/twitter/url/http/shields.io.svg?style=social)](https://twitter.com/intent/tweet?text=https://github.com/eggswift/pull-to-refresh)
[![Twitter Follow](https://img.shields.io/twitter/follow/lihao_ios.svg?style=social)](https://twitter.com/lihao_iOS)


## License

The MIT License (MIT)

Copyright (c) 2013-2020 eggswift

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

