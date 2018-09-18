//
//  ESPullToRefresh+Manager.swift
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

open class ESRefreshDataManager {
    
    static let sharedManager = ESRefreshDataManager.init()
    
    static let lastRefreshKey: String = "com.espulltorefresh.lastRefreshKey"
    static let expiredTimeIntervalKey: String = "com.espulltorefresh.expiredTimeIntervalKey"
    open var lastRefreshInfo = [String: Date]()
    open var expiredTimeIntervalInfo = [String: TimeInterval]()
    
    public required init() {
        if let lastRefreshInfo = UserDefaults.standard.dictionary(forKey: ESRefreshDataManager.lastRefreshKey) as? [String: Date] {
            self.lastRefreshInfo = lastRefreshInfo
        }
        if let expiredTimeIntervalInfo = UserDefaults.standard.dictionary(forKey: ESRefreshDataManager.expiredTimeIntervalKey) as? [String: TimeInterval] {
            self.expiredTimeIntervalInfo = expiredTimeIntervalInfo
        }
    }
    
    open func date(forKey key: String) -> Date? {
        let date = lastRefreshInfo[key]
        return date
    }
    
    open func setDate(_ date: Date?, forKey key: String) {
        lastRefreshInfo[key] = date
        UserDefaults.standard.set(lastRefreshInfo, forKey: ESRefreshDataManager.lastRefreshKey)
        UserDefaults.standard.synchronize()
    }
    
    open func expiredTimeInterval(forKey key: String) -> TimeInterval? {
        let interval = expiredTimeIntervalInfo[key]
        return interval
    }
    
    open func setExpiredTimeInterval(_ interval: TimeInterval?, forKey key: String) {
        expiredTimeIntervalInfo[key] = interval
        UserDefaults.standard.set(expiredTimeIntervalInfo, forKey: ESRefreshDataManager.expiredTimeIntervalKey)
        UserDefaults.standard.synchronize()
    }
    
    open func isExpired(forKey key: String) -> Bool {
        guard let date = date(forKey: key) else {
            return true
        }
        guard let interval = expiredTimeInterval(forKey: key) else {
            return false
        }
        if date.timeIntervalSinceNow < -interval {
            return true // Expired
        }
        return false
    }
    
    open func isExpired(forKey key: String, block: ((Bool) -> ())?) {
        DispatchQueue.global().async {
            [weak self] in
            let result = self?.isExpired(forKey: key) ?? true
            DispatchQueue.main.async(execute: {
                block?(result)
            })
        }
    }
    
    public static func clearAll() {
        self.clearLastRefreshInfo()
        self.clearExpiredTimeIntervalInfo()
    }
    
    public static func clearLastRefreshInfo() {
        UserDefaults.standard.set(nil, forKey: ESRefreshDataManager.lastRefreshKey)
    }
    
    public static func clearExpiredTimeIntervalInfo() {
        UserDefaults.standard.set(nil, forKey: ESRefreshDataManager.expiredTimeIntervalKey)
    }
    
}
