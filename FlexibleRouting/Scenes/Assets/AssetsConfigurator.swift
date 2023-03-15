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
        let interactor = AssetsInteractor()
        let presenter = AssetsPresenter()
        vc.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = vc
        
        return vc
    }
}
