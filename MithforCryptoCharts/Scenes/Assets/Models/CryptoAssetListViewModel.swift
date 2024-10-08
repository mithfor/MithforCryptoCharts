//
//  CryptoAssetListViewModel.swift
//  MithforCryptoCharts
//
//  Created by Dmitrii Voronin on 17.03.2023.
//

import Foundation

// MARK: - CryptoAssetListViewModel
final class CryptoAssetListViewModel {
    typealias Routes = AssetDetailsRoute
    private let router: Routes
    
    init(router: Routes) {
        self.router = router
    }
    
    func assetDetailsTapped(asset: CryptoAsset) {
        router.openAssetDetails(asset)
    }
}
