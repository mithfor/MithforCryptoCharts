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
//            .receive(on: DispatchQueue.main)
//            .tryMap({data in
//                let decoder = JSONDecoder()
//                do {
//                    print(data)
//                    return try decoder.decode(
//                        GlobalData.self, from: data
//                    )
//                } catch let error as DecodingError {
//                    print("\(#function) : \(NetworkError.unableToDecode.rawValue)")
//                    print("DecodingError: \(error)")
//                    throw NetworkError.unableToDecode
//                }
//            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion,
                  receiveValue: { [weak self] returnedGlobalData in
                self?.marketData = returnedGlobalData.data
                self?.marketDataSubscription?.cancel()
            })
    }
}
