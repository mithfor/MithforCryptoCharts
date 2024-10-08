//
//  CryptoAssetsConfigurator.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 27.02.2023.
//

import Foundation

protocol CryptoAssetsCongfiguratorProtocol {
    static func configured(_ vc: CryptoAssetsViewController) -> CryptoAssetsViewController
}

class CryptoAssetsConfigurator: CryptoAssetsCongfiguratorProtocol {
        static func configured(_ vc: CryptoAssetsViewController) -> CryptoAssetsViewController {
        let networkService = AssetNetworkService()
        let interactor = CryptoAssetsInteractor()
        let presenter = CryptoAssetsPresenter()
        interactor.networkService = networkService
        vc.interactor = interactor
        presenter.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = vc
        
        return vc
    }
}
