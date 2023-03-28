//
//  AssetsTabRoute.swift
//  FlexibleRouting
//
//  Created by Dmitrii Voronin on 14.03.2023.
//

import UIKit

protocol AssetsTabRoute {
    func makeAssetsTab() -> UIViewController
}

extension AssetsTabRoute where Self: Router {
    func makeAssetsTab() -> UIViewController {
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let model = AssetListViewModel(router: router)
        let viewController = AssetsConfigurator.configured(AssetsViewController(viewModel: model))
        router.root = viewController
        
        let navigation = UINavigationController(rootViewController: viewController)
        navigation.tabBarItem = Tabs.assets.item
        return navigation
    }
    
    func selectAssetsTab() {
        root?.tabBarController?.selectedIndex = Tabs.assets.index
    }
}

extension DefaultRouter: AssetsTabRoute {}
