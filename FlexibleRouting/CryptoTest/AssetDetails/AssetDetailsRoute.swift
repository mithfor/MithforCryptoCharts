//
//  AssetDetailsRoute.swift
//  FlexibleRouting
//
//  Created by Dmitrii Voronin on 15.03.2023.
//

import Foundation

protocol AssetDetailsRoute {
    func openAssetDetails()
}

extension AssetDetailsRoute where Self: Router {
    func openAssetDetails() {
        let push = PushTransition()
        let router = DefaultRouter(rootTransition: push)
        
    }
}

extension DefaultRouter: AssetDetailsRoute {}
