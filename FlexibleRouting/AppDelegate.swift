//
//  AppDelegate.swift
//  FlexibleRouting
//
//  Created by Dmitrii Voronin on 13.03.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        let mainRouter = DefaultRouter(rootTransition:  EmptyTransition())
        let tabs = [mainRouter.makeAssetsTab(), mainRouter.makeWatchlistTab(), mainRouter.makeSettingsTab()]

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = MainTabBarController(viewControllers: tabs)
        window?.makeKeyAndVisible()
        return true
    }

}

