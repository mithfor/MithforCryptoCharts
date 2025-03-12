//
//  CryptoAssetsTabRoute.swift
//  MithforCryptoCharts
//
//  Created by Dmitrii Voronin on 14.03.2023.
//

import UIKit
import SwiftUI

protocol CryptoAssetsTabRoute {
    func makeCryptoAssetsTab(enableSwiftUI: Bool) -> UIViewController
}

extension CryptoAssetsTabRoute where Self: Router {

    func makeCryptoAssetsTab(enableSwiftUI: Bool = false) -> UIViewController {
        
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let model = CryptoAssetListViewModel(router: router)

        // MARK: - create HomeViewModel

        @ObservedObject var homeViewModel = ViewModelsFactory.shared.createHomeViewModel()

        let viewController: UIViewController?
        
        // TODO: - Test SwiftUI in UIKit with enableSwiftUI option
        if enableSwiftUI {
            viewController = UIHostingController(
                rootView: HomeView()
                    .environmentObject(homeViewModel))
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
