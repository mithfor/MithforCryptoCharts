//
//  AssetDetailsRoute.swift
//  FlexibleRouting
//
//  Created by Dmitrii Voronin on 15.03.2023.
//

import Foundation

protocol AssetDetailsRoute {
    func openAssetDetails(_ asset: Asset)
}

extension AssetDetailsRoute where Self: Router {
    func openAssetDetails(_ asset: Asset) {
        let push = PushTransition()
        let router = DefaultRouter(rootTransition: push)
        let model = AssetDetailsViewModel(router: router, asset: asset)
        let viewController = AssetDetailsConfigurator.configured(AssetDetailsViewController(viewModel: model))
        router.root = viewController
        
        route(to: viewController, as: push)
        
    }
}

extension DefaultRouter: AssetDetailsRoute {}
