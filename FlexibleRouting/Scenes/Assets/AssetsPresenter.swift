//
//  AssetsPresenter.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 27.02.2023.
//

import Foundation

typealias AssetsPresenterInput = AssetsInteractorOutput
typealias AssetsPresenterOutput = AssetsViewControllerInput

final class AssetsPresenter {
    weak var viewController: AssetsPresenterOutput?
}

extension AssetsPresenter: AssetsPresenterInput {

    
    func fetched(assetIcon: AssetIcon, for asset: Asset) {
        viewController?.updateAsset(asset, with: assetIcon)
    }
    
    func fetchFailure(error: NetworkError) {
        viewController?.updateFailed(with: error)
    }
    
    func fetched(assets: Assets) {
        viewController?.updateAssets(assets)
    }
}
