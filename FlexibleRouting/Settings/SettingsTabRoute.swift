//
//  SettingsTabRoute.swift
//  FlexibleRouting
//
//  Created by Dmitrii Voronin on 14.03.2023.
//

import UIKit

protocol SettingsTabRoute {
    func makeSettingsTab() -> UIViewController
}

extension SettingsTabRoute where Self: Router {
    func makeSettingsTab() -> UIViewController {
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let model = SettingsViewModel(router: router)
        let viewController = SettingsViewController(viewModel: model)
        router.root = viewController
        
        let navigation = UINavigationController(rootViewController: viewController)
        navigation.tabBarItem = Tabs.settings.item
        
        return navigation
    }
    
    func selectSettingsTab() {
        root?.tabBarController?.selectedIndex = Tabs.settings.index
    }
}

extension DefaultRouter: SettingsTabRoute {}
