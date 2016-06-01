//
//  ESPullToRefresh+Cache.swift
//  ESPullToRefreshExample
//
//  Created by lihao on 16/6/1.
//  Copyright © 2016年 egg swift. All rights reserved.
//

import Foundation

public class ESRefreshDataManager {
    
    static let sharedManager = ESRefreshDataManager.init()
    
    static let lastRefreshKey: String = "com.espulltorefresh.lastRefreshKey"
    static let expiredTimeIntervalKey: String = "com.espulltorefresh.expiredTimeIntervalKey"
    public var lastRefreshInfo = [String: NSDate]()
    public var expiredTimeIntervalInfo = [NSString: NSTimeInterval]()
    
    public required init() {
        if let lastRefreshInfo = NSUserDefaults.standardUserDefaults().dictionaryForKey(ESRefreshDataManager.lastRefreshKey) as? [String: NSDate] {
            self.lastRefreshInfo = lastRefreshInfo
        }
        if let expiredTimeIntervalInfo = NSUserDefaults.standardUserDefaults().dictionaryForKey(ESRefreshDataManager.expiredTimeIntervalKey) as? [String: NSTimeInterval] {
            self.expiredTimeIntervalInfo = expiredTimeIntervalInfo
        }
    }
    
    public func date(forKey key: String) -> NSDate? {
        let date = lastRefreshInfo[key]
        return date
    }
    
    public func setDate(date: NSDate?, forKey key: String) {
        lastRefreshInfo[key] = date
        NSUserDefaults.standardUserDefaults().setObject(lastRefreshInfo, forKey: ESRefreshDataManager.lastRefreshKey)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    public func expriedTimeInterval(forKey key: String) -> NSTimeInterval? {
        let interval = expiredTimeIntervalInfo[key]
        return interval
    }
    
    public func setExpriedTimeInterval(interval: NSTimeInterval?, forKey key: String) {
        expiredTimeIntervalInfo[key] = interval
        NSUserDefaults.standardUserDefaults().setObject(expiredTimeIntervalInfo, forKey: ESRefreshDataManager.expiredTimeIntervalKey)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    public func isExpried(forKey key: String) -> Bool {
        guard let date = date(forKey: key) else {
            return true
        }
        guard let interval = expriedTimeInterval(forKey: key) else {
            return false
        }
        if date.timeIntervalSinceNow < -interval {
            return true // Expried
        }
        return false
    }
    
    public func isExpried(forKey key: String, block: ((Bool) -> ())?) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)) {
            [weak self] in
            guard let weakSelf = self else {
                return
            }
            let result = weakSelf.isExpried(forKey: key)
            dispatch_async(dispatch_get_main_queue(), { 
                block?(result)
            })
        }
    }
    
    public static func clearAll() {
        self.clearLastRefreshInfo()
        self.clearExpriedTimeIntervalInfo()
    }
    
    public static func clearLastRefreshInfo() {
        NSUserDefaults.standardUserDefaults().setObject(nil, forKey: ESRefreshDataManager.lastRefreshKey)
    }
    
    public static func clearExpriedTimeIntervalInfo() {
        NSUserDefaults.standardUserDefaults().setObject(nil, forKey: ESRefreshDataManager.expiredTimeIntervalKey)
    }
    
}
