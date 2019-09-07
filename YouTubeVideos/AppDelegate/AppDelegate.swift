//
//  AppDelegate.swift
//  YouTubeVideos
//
//  Created by Inacio Ferrarini on 16/06/17.
//  Copyright © 2017 Inacio Ferrarini. All rights reserved.
//

import UIKit
import York

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appContext: AppContext?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

//        // theme setup - to be refactored
//        SVProgressHUD.setDefaultStyle(.Dark)
//        application.setStatusBarStyle(UIStatusBarStyle.LightContent, animated: false)
//        
//        IQKeyboardManager.sharedManager().enable = true
//        IQKeyboardManager.sharedManager().overrideKeyboardAppearance = true
//        IQKeyboardManager.sharedManager().keyboardAppearance = .Default
//        // theme setup - to be refactored

        let apiClient = YouTubeApiClient()
        let appContext = AppContext(apiClient: apiClient)
        
        if let window = self.window,
            let rootNavigationController = window.rootViewController as? UINavigationController,
            let firstViewController = rootNavigationController.topViewController as? AppTableViewController {
            firstViewController.appContext = appContext
        }
        
        self.appContext = appContext
        
        return true
    }
    
}

