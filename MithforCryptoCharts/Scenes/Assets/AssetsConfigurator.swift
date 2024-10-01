//
//  AssetsConfigurator.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 27.02.2023.
//

import Foundation

protocol AssetsCongfiguratorProtocol {
    static func configured(_ vc: AssetsViewController) -> AssetsViewController
}

class AssetsConfigurator: AssetsCongfiguratorProtocol {
        static func configured(_ vc: AssetsViewController) -> AssetsViewController {
        let networkService = AssetNetworkService()
        let interactor = AssetsInteractor()
        let presenter = AssetsPresenter()
        interactor.networkService = networkService
        vc.presenter = presenter
        presenter.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = vc
        
        return vc
    }
}
