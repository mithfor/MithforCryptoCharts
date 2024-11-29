//
//  ViewModelsFactory.swift
//  MithforCryptoCharts
//
//  Created by Dmitriy Voronin on 29.11.2024.
//

import Foundation

final class ViewModelsFactory {
    static let shared = ViewModelsFactory()

    private init() {}

    func createHomeViewModel() -> HomeViewModel {

        let locator = ServiceLocator.shared

        locator.register(service: CoinDataService())
        locator.register(service: MarketDataService())
        locator.register(service: PortfolioDataService())

        return HomeViewModel(serviceLocator: locator)
    }
}
