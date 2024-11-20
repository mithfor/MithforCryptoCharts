//
//  MarketDataService.swift
//  MithforCryptoCharts
//
//  Created by Dmitrii Voronin on 19.11.2024.
//

import Foundation
import Combine

class MarketDataService {
    
//    private var logger = Logger()
    
    @Published var marketData: MarketDatalModel? = nil
    
    var marketDataSubscription: AnyCancellable?
    
    init() {
        fetchMarketData()
    }
    
    private func fetchMarketData() {
        let urlString = "https://api.coingecko.com/api/v3/global"
        
        guard let url = URL(string: urlString)
        else { return }
        
        marketDataSubscription = NetworkingManager.download(url: url)
            .decode(type: GlobalData.self,
                    decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion,
                  receiveValue: { [weak self] returnedGlobalData in
                self?.marketData = returnedGlobalData.data
                self?.marketDataSubscription?.cancel()
            })
    }
}
