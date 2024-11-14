//
//  CoinImageService.swift
//  MithforCryptoCharts
//
//  Created by Dmitrii Voronin on 14.11.2024.
//

import SwiftUI
import Combine

class CoinImageService {
    @Published var image: UIImage?
    private var coinImageSubsription: AnyCancellable?
    
    private var coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        fetchCoinImage()
    }
    
    private func fetchCoinImage() {
        guard let url = URL(string: coin.image) else { return }
        
        coinImageSubsription = NetworkingManager.download(url: url)
            .tryMap({ data -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion,
                  receiveValue: { [weak self] returnedImage in
                guard let self = self else { return }
                self.image = returnedImage
                self.coinImageSubsription?.cancel()
            })
    }
}
