//
//  WatchListConfigurator.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 07.03.2023.
//

import Foundation

protocol WatchListConfiguratorProtocol {
    static func configured(_ vc: WatchlistViewController,
                           with watchList: WatchList) -> WatchlistViewController
}

class WatchListConfigurator: WatchListConfiguratorProtocol {
    static func configured(_ vc: WatchlistViewController,
                           with watchList: WatchList = WatchList()) -> WatchlistViewController {
        let interactor = WatchListInteractor()
        let presenter = WatchListPresenter()
        vc.interactor = interactor
        vc.watchlist = watchList
        interactor.presenter = presenter
        presenter.viewController = vc
        
        return vc
    }
}
