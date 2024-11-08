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
        fetchCoins()
    }
    
    private func fetchCoins() {
        
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=eur&ids=bitcoin&category=layer-1&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else { return }
        
        coinSubscription = URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap { [weak self] output in
                
                guard let response = output.response as? HTTPURLResponse,
                      self?.isSuccessfull(statusCode: response.statusCode) == true
                else {
                    throw URLError(.badServerResponse)
                }
                
                return output.data
            }
            .receive(on: DispatchQueue.main)
            .decode(
                type: [CoinModel].self,
                decoder: JSONDecoder())
            .sink { (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    
                }
            } receiveValue: { [weak self] returnedCoins in
                guard let self = self else { return }
                self.allCoins = returnedCoins
                self.coinSubscription?.cancel()
            }

    }
    
    private func isSuccessfull(statusCode: Int) -> Bool {
        return (statusCode >= 200 && statusCode < 300) ? true : false
    }
}
