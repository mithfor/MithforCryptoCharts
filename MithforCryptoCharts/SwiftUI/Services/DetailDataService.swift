//
//  DetailDataService.swift
//  MithforCryptoCharts
//
//  Created by Dmitriy Voronin on 03.12.2024.
//

import Foundation
import Combine

class DetailDataService: DataService {
    var networkingManager: NetworkingManager
    
    @Published var coinDetails: CoinDetailModel?
    private let selfCoin: CoinModel?
    private let decoder: JSONDecoder

    var coinDetailSubscription: AnyCancellable?

    init(coin: CoinModel) {
        self.selfCoin = coin
        networkingManager = NetworkingManager.shared
        decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        self.fetchData()
    }

    func fetchData() {
        do {
            try loadDetails()
        } catch let error as NetworkingManager.NetworkingError {
            print(error.errorDescription as Any)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    private func loadDetails() throws {
        print(#function)


        let id = selfCoin?.id ?? ""

        let urlString = "https://api.coingecko.com/api/v3/coins/\(id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false"

        guard let url = URL(string: urlString) else {
            throw NetworkingManager.NetworkingError.badURL(urlString: urlString)
        }

        coinDetailSubscription = networkingManager.download(url: url)
            .decode(type: CoinDetailModel.self,
                    decoder: decoder)
            .sink(receiveCompletion: networkingManager.handleCompletion,
                  receiveValue: { [weak self] (retrundeCoinDetails) in
                self?.coinDetails = retrundeCoinDetails
                self?.coinDetailSubscription?.cancel()
            })
    }
}
