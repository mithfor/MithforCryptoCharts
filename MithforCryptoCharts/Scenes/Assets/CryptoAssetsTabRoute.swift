//
//  CryptoAssetsTabRoute.swift
//  MithforCryptoCharts
//
//  Created by Dmitrii Voronin on 14.03.2023.
//

import UIKit
import SwiftUI

protocol CryptoAssetsTabRoute {
    func makeCryptoAssetsTab() -> UIViewController
}

extension CryptoAssetsTabRoute where Self: Router {
    func makeCryptoAssetsTab() -> UIViewController {
        
        let enableSwiftUI: Bool = true
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let model = CryptoAssetListViewModel(router: router)
        let viewController: UIViewController?
        
        if enableSwiftUI {
            viewController = UIHostingController(rootView: SwiftUICryptoAssetsView())
        } else {
            viewController = CryptoAssetsConfigurator.configured(
                CryptoAssetsViewController(
                    viewModel: model))
        }
        router.root = viewController
        
        let navigation = UINavigationController(rootViewController: viewController ?? UIViewController(nibName: nil, bundle: nil) )
        navigation.tabBarItem = MainTabs.assets.item
        return navigation
    }
    
    func selectCryptoAssetsTab() {
        root?.tabBarController?.selectedIndex = MainTabs.allCases.firstIndex(of: .assets) ?? 0
    }
}

extension DefaultRouter: CryptoAssetsTabRoute {}
