//
//  AssetDetailsRoute.swift
//  MithforCryptoCharts
//
//  Created by Dmitrii Voronin on 15.03.2023.
//

import Foundation

protocol AssetDetailsRoute {
    func openAssetDetails(_ asset: CryptoAsset)
}

extension AssetDetailsRoute where Self: Router {
    func openAssetDetails(_ asset: CryptoAsset) {
        let push = PushTransition()
        let router = DefaultRouter(rootTransition: push)
        let model = AssetDetailsViewModel(router: router, asset: asset)
        let viewController = AssetDetailsConfigurator.configured(AssetDetailsViewController(viewModel: model))
        router.root = viewController
        
        route(to: viewController, as: push)
        
    }
}

extension DefaultRouter: AssetDetailsRoute {}
