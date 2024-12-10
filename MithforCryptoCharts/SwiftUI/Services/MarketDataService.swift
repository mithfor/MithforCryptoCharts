//
//  MarketDataService.swift
//  MithforCryptoCharts
//
//  Created by Dmitrii Voronin on 19.11.2024.
//

import Foundation
import Combine

class MarketDataService: NetworkDataService {    
    var networkingManager: NetworkingManager

//    private var logger = Logger()
    
    @Published var marketData: MarketDatalModel?
    
    var marketDataSubscription: AnyCancellable?
    
    init() {
        //
        networkingManager = NetworkingManager.shared
        fetchData()
    }

    func fetchData() {
        fetchMarketData()
    }

    private func fetchMarketData() {
        let urlString = "https://api.coingecko.com/api/v3/global"
        
        guard let url = URL(string: urlString)
        else { return }
        
        marketDataSubscription = networkingManager.download(url: url)
            .decode(type: GlobalData.self,
                    decoder: JSONDecoder())
            .sink(receiveCompletion: networkingManager.handleCompletion,
                  receiveValue: { [weak self] returnedGlobalData in
                self?.marketData = returnedGlobalData.data
                self?.marketDataSubscription?.cancel()
            })
    }
}
