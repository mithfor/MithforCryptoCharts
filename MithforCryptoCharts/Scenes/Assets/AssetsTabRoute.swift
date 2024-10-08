//
//  CryptoAssetsTabRoute.swift
//  MithforCryptoCharts
//
//  Created by Dmitrii Voronin on 14.03.2023.
//

import UIKit

protocol CryptoAssetsTabRoute {
    func makeCryptoAssetsTab() -> UIViewController
}

extension CryptoAssetsTabRoute where Self: Router {
    func makeCryptoAssetsTab() -> UIViewController {
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let model = AssetListViewModel(router: router)
        let viewController = CryptoAssetsConfigurator.configured(CryptoAssetsViewController(viewModel: model))
        router.root = viewController
        
        let navigation = UINavigationController(rootViewController: viewController)
        navigation.tabBarItem = MainTabs.assets.item
        return navigation
    }
    
    func selectCryptoAssetsTab() {
        root?.tabBarController?.selectedIndex = MainTabs.allCases.firstIndex(of: .assets) ?? 0
    }
}

extension DefaultRouter: CryptoAssetsTabRoute {}
