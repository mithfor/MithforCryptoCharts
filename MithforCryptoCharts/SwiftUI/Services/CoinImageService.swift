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
    private let coin: CoinModel
    private let fileManager = LocalFileManager.instance
    private let folderName = "coin_images"
    private let imageName: String

    init(coin: CoinModel) {
        self.coin = coin
        self.imageName = coin.id
        fetchCoinImage()
    }

    private func fetchCoinImage() {
        if let savedImage = fileManager.loadImage(imageName: imageName,
                                             folderName: folderName) {
            image = savedImage
            print("Retrieved image from File Manager!")
        } else {
            downloadCoinImage()
            print("Downloaded image")
        }
    }

    private func downloadCoinImage() {
        guard let url = URL(string: coin.image) else { return }
        
        coinImageSubsription = NetworkingManager.download(url: url)
            .tryMap({ data -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion,
                  receiveValue: { [weak self] returnedImage in
                guard let self = self,
                let downloadedImage = returnedImage else { return }
                self.image = downloadedImage
                self.coinImageSubsription?.cancel()
                do {
                    try self.fileManager.saveImage(image: downloadedImage,
                                                   imageName: self.imageName,
                                                   folderName: self.folderName)
                } catch let error {
                    print("Error saving image file: \(error)")
                }

            })
    }
}
