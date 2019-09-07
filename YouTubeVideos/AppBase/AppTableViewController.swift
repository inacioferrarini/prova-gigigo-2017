//
//  AppTableViewController.swift
//  YouTubeVideos
//
//  Created by Inacio Ferrarini on 17/06/17.
//  Copyright © 2017 Inacio Ferrarini. All rights reserved.
//

import UIKit
import York

class AppTableViewController: BaseTableViewController, BaseAppContextAwareProtocol {
    
    
    // MARK: - Properties
    
    var appContext: AppContext!
    
    
    // MARK: - Data Syncrhonization
    
    func viewControllerSyncIdentifier() -> String {
        return self.instanceSimpleClassName()
    }
    
    override public func shouldSyncData() -> Bool {
        var shouldSyncData = true
        let viewControllerName = self.viewControllerSyncIdentifier()
        if let status = self.appContext.viewControllerShouldSyncData[viewControllerName] {
            shouldSyncData = status
        } else {
            shouldSyncData = true
        }
        return shouldSyncData
    }
    
    public func updateViewControllerShouldSyncData(shouldSyncData: Bool) {
        let viewControllerName = self.viewControllerSyncIdentifier()
        self.appContext.viewControllerShouldSyncData[viewControllerName] = shouldSyncData
    }
    
    override public func didSyncData() {
        super.didSyncData()
        if self.refreshControl?.isRefreshing ?? false {
            self.refreshControl?.endRefreshing()
        }
    }
    
}
