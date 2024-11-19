//
//  HomeViewModel.swift
//  MithforCryptoCharts
//
//  Created by Dmitrii Voronin on 31.10.2024.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var searchText: String = ""
    
    private var dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
     
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
        $searchText
            .combineLatest(dataService.$allCoins)
            .map(filterCoins)
            .sink(receiveValue: { [weak self] (returnedCoins) in
                guard let self = self else { return }
                self.allCoins = returnedCoins
            })
            .store(in: &cancellables )
    }
    
    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else { return coins }
        
        let lowercasedText = text.lowercased()
        
        let filteredCoins = coins.filter{(coin) -> Bool in
            return coin.name.lowercased().contains(lowercasedText) || coin.symbol.lowercased().contains(lowercasedText) ||
            coin.id.lowercased().contains(lowercasedText)
        }
        
        return filteredCoins
    }
}
