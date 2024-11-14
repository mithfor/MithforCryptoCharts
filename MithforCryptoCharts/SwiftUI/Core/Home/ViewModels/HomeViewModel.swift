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
    
    private var dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
     
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        dataService.$allCoins
            .sink { [weak self] returnedCoins in
                guard let self = self else { return }
            
                self.allCoins = returnedCoins
            }
            .store(in: &cancellables)
    }
}
