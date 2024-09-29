//
//  AssetListViewModel.swift
//  MithforCryptoCharts
//
//  Created by Dmitrii Voronin on 17.03.2023.
//

import Foundation

//MARK: - AssetListViewModel
final class AssetListViewModel {
    typealias Routes = AssetDetailsRoute
    private let router: Routes
    
    init(router: Routes) {
        self.router = router
    }
    
    func assetDetailsTapped(asset: Asset) {
        router.openAssetDetails(asset)
    }
}
