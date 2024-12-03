//
//  DetailViewModel.swift
//  MithforCryptoCharts
//
//  Created by Dmitriy Voronin on 03.12.2024.
//

import Foundation
import Combine

final class DetailViewModel: ObservableObject {

    @Published var overviewStatistics: [StatisticModel] = []
    @Published var additionalStatistics: [StatisticModel] = []

    @Published var coin: CoinModel
    private var coinDetailService: DetailDataService
    private var cancellables = Set<AnyCancellable>()

    init(coin: CoinModel) {
        self.coin = coin
        self.coinDetailService = DetailDataService(coin: coin)

        self.addSubscribers()
    }

    private func addSubscribers() {
        coinDetailService.$coinDetails
            .combineLatest($coin)
            .map({ [weak self] (coinDetailModel, coinModel) -> (overview: [StatisticModel],
                                                    additional: [StatisticModel]) in

                guard let self = self else { return ([], [] ) }

                let priceStat = self.createPriceStat(coin: coinModel)
                let marketCapStat = self.createMarketCapStat(coin: coinModel)
                let rankStat = self.createRankStat(coin: coinModel)
                let volumeStat = self.createVolumeStat(coin: coinModel)

                let overviewArray: [StatisticModel] = [
                    priceStat,
                    marketCapStat,
                    rankStat,
                    volumeStat
                ]

                let highStat = self.createHighStat(coin: coinModel)
                let lowStat = self.createLowStat(coin: coinModel)
                let priceChangeStat = self.createPriceChangeStat(coin: coinModel)
                let marketCapChangeStat = self.createMarketCapChangeStat(coin: coinModel)
                let blockTimeStat = self.createBlockTimeStat(coinDetails: coinDetailModel)
                let hashingStat = self.createHashingStat(coinDetail: coinDetailModel)



                let additionalArray: [StatisticModel] = [
                    highStat,
                    lowStat,
                    priceChangeStat,
                    marketCapChangeStat,
                    blockTimeStat,
                    hashingStat
                ]

                return (overviewArray, additionalArray)
            })
            .sink { [weak self] (returnedArrays) in
                self?.overviewStatistics = returnedArrays.overview
                self?.additionalStatistics = returnedArrays.additional
            }
            .store(in: &cancellables)
    }
}

private extension DetailViewModel {
    func createPriceStat(coin: CoinModel) -> StatisticModel {
        let price = coin.currentPrice?.asCurrencyWith6Decimals()
        let priceChange = coin.priceChangePercentage24H
        return StatisticModel(title: coin.name,
                                       value: price ?? "0.0",
                                       percentageChange: priceChange)
    }

    func createMarketCapStat(coin: CoinModel) -> StatisticModel {
        let marketCap = "$" + (coin.marketCap?.formatedWithAbbreviations() ?? "")
        let marketCapChange = coin.marketCapChangePercentage24H
        return StatisticModel(title: "Market Capitalization",
                                           value: marketCap,
                                           percentageChange: marketCapChange)
    }

    func createRankStat(coin: CoinModel) -> StatisticModel {
        let rank = "\(coin.rank)"
        return StatisticModel(title: "Rank", value: rank)
    }

    func createVolumeStat(coin: CoinModel) -> StatisticModel {
        let volume = "$" + (coin.totalVolume?.formatedWithAbbreviations() ?? "")
        return  StatisticModel(title: "Volume", value: volume)
    }

    func createHighStat(coin: CoinModel) -> StatisticModel {
        let high = coin.high24H?.asCurrencyWith6Decimals() ?? "n/a"
        return StatisticModel(title: "24h High", value: high)
    }

    func createLowStat(coin: CoinModel) -> StatisticModel {
        let low = coin.low24H?.asCurrencyWith6Decimals() ?? "n/a"
        return StatisticModel(title: "24h Low", value: low)
    }

    func createPriceChangeStat(coin: CoinModel) -> StatisticModel {
        let priceChange = coin.priceChange24H?.asCurrencyWith6Decimals() ?? "n/a"
        let pricePercentChange = coin.priceChangePercentage24H
        return StatisticModel(title: "24h Price Change",
                                             value: priceChange,
                                             percentageChange: pricePercentChange)
    }

    func createMarketCapChangeStat(coin: CoinModel) -> StatisticModel {
        let marketCapChange = "$" + (coin.marketCapChange24H?.formatedWithAbbreviations() ?? "")
        let marketCapPercentChange = coin.marketCapChangePercentage24H
        return StatisticModel(title: "24h Market Capitalization Change",
                                                 value: marketCapChange,
                                                 percentageChange: marketCapPercentChange)
    }

    func createBlockTimeStat(coinDetails: CoinDetailModel?) -> StatisticModel {
        let blockTime = coinDetails?.blockTimeInMinutes ?? 0
        let blockTimeString = blockTime == 0 ? "n/a" : "\(blockTime)"
        return StatisticModel(title: "Block Time", value: blockTimeString)
    }

    func createHashingStat(coinDetail: CoinDetailModel?) -> StatisticModel {
        let hashing = coinDetail?.hashingAlgorithm ?? "n/a"
        return StatisticModel(title: "Hashing Algorithm", value: hashing)
    }
}


