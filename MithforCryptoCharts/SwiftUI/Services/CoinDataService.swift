//
//  CoinDataService.swift
//  MithforCryptoCharts
//
//  Created by Dmitrii Voronin on 01.11.2024.
//

import Foundation
import Combine

class CoinDataService {
    @Published var allCoins: [CoinModel] = []
    var coinSubscription: AnyCancellable?
    
    init() {
        fetchData()
    }
    
    private func fetchCoins() {
        
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=eur&ids=bitcoin&category=layer-1&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else { return }
        
        coinSubscription = NetworkingManager.download(url: url)
            .decode(
                type: [CoinModel].self,
                decoder: JSONDecoder()
            )
            .sink(receiveCompletion: NetworkingManager.handleCompletion,
                  receiveValue: { [weak self] returnedCoins in
                guard let self = self else { return }
                self.allCoins = returnedCoins
                self.coinSubscription?.cancel()
            })
    }
}

extension CoinDataService: DataService {
    func fetchData() {
        fetchCoins()
    }
}
