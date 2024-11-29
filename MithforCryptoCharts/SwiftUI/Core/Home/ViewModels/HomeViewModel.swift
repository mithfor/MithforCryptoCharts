//
//  HomeViewModel.swift
//  MithforCryptoCharts
//
//  Created by Dmitrii Voronin on 31.10.2024.
//

import Foundation
import Combine

enum HomeViewModelState {
    case inititate, loading, pending
}

class HomeViewModel: ObservableObject {
    @Published var statistics: [StatisticModel] = []
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var searchText: String = ""

    private(set) var state: HomeViewModelState = .inititate

    private var coinDataService: CoinDataService
    private var marketDataService: MarketDataService
    private var portfolioDataService: PortfolioDataService

    private var cancellables = Set<AnyCancellable>()
     
    init(serviceLocator: ServiceLocating? = nil ) {

        coinDataService = serviceLocator?.resolve() ?? CoinDataService()
        marketDataService = serviceLocator?.resolve() ?? MarketDataService()
        portfolioDataService = serviceLocator?.resolve() ?? PortfolioDataService()

        addSubscribers()
    }

    func reloadData() {
        state = .loading

        coinDataService.fetchData()
        marketDataService.fetchData()
        HapticManager.notification(type: .success)
    }

    private func addSubscribers() {
        
        // update allCoins
        $searchText
            .combineLatest(coinDataService.$allCoins)
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables )

        // updates portfolioCoins
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map (mapAllCoinToPortfolioCoins)
            .sink { [weak self] returnedCoins in
                self?.portfolioCoins = returnedCoins
            }
            .store(in: &cancellables)

        // updates marketData
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(mapGlobalMarketData)
            .sink { [weak self] returnedStats in
                self?.statistics = returnedStats
                self?.state = .pending
            }
            .store(in: &cancellables)
    }
    
    func updatePortfolio(coin: CoinModel, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else { return coins }
        
        let lowercasedText = text.lowercased()
        
        let filteredCoins = coins.filter {(coin) -> Bool in
            return coin.name.lowercased().contains(lowercasedText) || coin.symbol.lowercased().contains(lowercasedText) ||
            coin.id.lowercased().contains(lowercasedText)
        }
        
        return filteredCoins
    }

    private func mapAllCoinToPortfolioCoins(allCoins: [CoinModel],
                                            portfolioEntities: [PortfolioEntity] ) -> [CoinModel] {
        allCoins
            .compactMap { (coin) -> CoinModel? in
                guard let entity = portfolioEntities.first(where: {$0.coinID == coin.id})
                else {
                    return nil
                }

                return coin.updatedHoldings(amount: entity.amount)
            }
    }

    private func mapGlobalMarketData(marketData: MarketDatalModel?, portfolioCoins: [CoinModel]) -> [StatisticModel] {

        var stats: [StatisticModel] = []
                       
        guard let data = marketData else { return stats }
        
        let marketCap = StatisticModel(title: "Market Cap",
                                       value: data.marketCap,
                                       percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = StatisticModel(title: "24h Volume",
                                    value: data.volume)
        let btcDominance = StatisticModel(title: "BTC Dominance",
                                          value: data.bitcoinDominance)

        let portfolioValue = portfolioCoins
            .map(\.currentHoldingsValue)
            .reduce(0, +)

        let previousValue = portfolioCoins
            .map {(coin) -> Double in
                let currentValue = coin.currentHoldingsValue
                let percentChange = (coin.priceChangePercentage24H ?? 0) / 100
                let previousValue = currentValue / (1 + percentChange)
                return previousValue
            }
            .reduce(0, +)

        let percentageChange = ((portfolioValue - previousValue) / previousValue) * 100

        let portfolio = StatisticModel(title: "Portfolio Value",
                                       value:  portfolioValue.asCurrencyWith2Decimals(),
                                       percentageChange: percentageChange)

        stats.append( contentsOf: [
            marketCap,
            volume,
            btcDominance,
            portfolio
        ])
        return stats
        
    }
}
