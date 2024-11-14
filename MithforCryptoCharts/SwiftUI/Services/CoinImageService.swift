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
    var coinImageSubsription: AnyCancellable?
    
    init(urlString: String) {
        fetchCoinImage(urlString: urlString)
    }
    
    private func fetchCoinImage(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
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
