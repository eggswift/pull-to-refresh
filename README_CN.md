# ESPullToRefresh

ESPullToRefresh是一个非常易于开发者使用的下拉刷新和加载更多组件。通过一个UIScrollView的扩展，可以轻松为UIScrollView的所有子类添加下拉刷新功能。 如果你想定制组件的UI样式，只要实现指定的协议方法即可。

感谢: [SVPullToRefresh](https://github.com/samvermette/SVPullToRefresh) by [Sam Vermette](https://github.com/samvermette),  [EGOTableViewPullRefresh](https://github.com/enormego/EGOTableViewPullRefresh) by [enormego](http://www.enormego.com),  这些开源项目给了我很多灵感。

## Requirements

* Xcode 7 or later
* iOS 8.0 or later
* ARC
* Swift 2.0

## Demo

下载后运行ESPullToRefreshExample工程，你可以看到一些使用ESPullToRefresh实现的自定义下拉刷新和加载更多例子。


## Installation

### 使用CocoaPods

``` ruby
pod "ESPullToRefresh"
```

### 手动安装

``` ruby
git clone https://github.com/eggswift/pull-to-refresh.git
open ESPullToRefresh
```

## 开始使用

### 使用默认样式:

#### 效果如下:

![](example_default.gif)



设置默认下拉刷新组件
``` swift
self.tableView.es_addPullToRefresh {
    [weak self] in
    /// 在这里做刷新相关事件
    /// ...
    /// 如果你的刷新事件成功，设置completion自动重置footer的状态
    self?.tableView.es_stopPullToRefresh(completion: true)
    /// 设置ignoreFooter来处理不需要显示footer的情况
    self?.tableView.es_stopPullToRefresh(completion: true, ignoreFooter: false)
    })
}
```

设置默认加载更多组件
``` swift
self.tableView.es_addInfiniteScrolling {
    [weak self] in
    /// 在这里做加载更多相关事件
    /// ...
    /// 如果你的加载更多事件成功，调用es_stopLoadingMore()重置footer状态
    self?.tableView.es_stopLoadingMore()
    /// 通过es_noticeNoMoreData()设置footer暂无数据状态
    self?.tableView.es_noticeNoMoreData()
    })
}
```


### 使用自定义样式

#### 效果如下:

![](example_meituan.gif)

注: 加载动画资源来自美团 iOS app。

![](example_wechat.gif)


`ESPullToRefresh`通过`ESRefreshProtocol`和`ESRefreshAnimatorProtocol`来约束刷新组件的使用，自定义的组件必须遵守这两个协议，并实现协议中的方法。

设置自定义下拉刷新组件
``` swift
func es_addPullToRefresh(animator animator: protocol<ESRefreshProtocol, ESRefreshAnimatorProtocol>, 
handler: ESRefreshHandler)
```

设置自定义加载更多组件
``` swift
func es_addInfiniteScrolling(animator animator: protocol<ESRefreshProtocol, ESRefreshAnimatorProtocol>, 
handler: ESRefreshHandler)
```

### 移除方法

``` swift
func es_removeRefreshHeader()
func es_removeRefreshFooter()
```


## Contribution

欢迎提交 issue 和 pull request，有任何疑问可以随时交流。

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

