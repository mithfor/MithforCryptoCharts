//
//  WatchlistTabRoute.swift
//  FlexibleRouting
//
//  Created by Dmitrii Voronin on 14.03.2023.
//

import UIKit

protocol WatchlistTabRoute {
    func makeWatchlistTab() -> UIViewController
}

extension WatchlistTabRoute where Self: Router {
    func makeWatchlistTab() -> UIViewController {
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let model = WatchlistViewModel(router: router)
        let viewController = WatchlistViewController(viewModel: model)
        router.root = viewController
        
        let navigation = UINavigationController(rootViewController: viewController)
        navigation.tabBarItem = Tabs.watchlist.item
        return navigation
    }
    
    func selectWatchlistTab() {
        root?.tabBarController?.selectedIndex = Tabs.watchlist.index
    }
}

extension DefaultRouter: WatchlistTabRoute {}
