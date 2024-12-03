//
//  DetailViewModel.swift
//  MithforCryptoCharts
//
//  Created by Dmitriy Voronin on 03.12.2024.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {

    private var coinDetailService: DetailDataService
    private var cancellables = Set<AnyCancellable>()

    init(coin: CoinModel) {
        self.coinDetailService = DetailDataService(coin: coin)

        self.addSubscribers()
    }

    private func addSubscribers() {
        print( "DetailViewModel: " + #function)
        coinDetailService.$coinDetails
            .sink { (returnedCoinDetails) in
                print("RECEIVED COIN DETAIL DATA")
                print(returnedCoinDetails as Any)
            }
            .store(in: &cancellables)
    }
}


