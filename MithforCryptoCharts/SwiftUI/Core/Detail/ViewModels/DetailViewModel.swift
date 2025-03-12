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
    @Published var coinDescription: String?
    @Published var websiteURL: String?
    @Published var redditURL: String?
    @Published var coin: CoinModel
    
    private var coinDetailService: DetailDataService
    private var cancellables = Set<AnyCancellable>()

    init(coin: CoinModel) {
        self.coin = coin
        self.coinDetailService = DetailDataService(coin: coin)

        self.addSubscribers()
    }
    
    private func mapDataToStatistic(
        coinDetails: CoinDetailModel?,
        coin: CoinModel) -> (
            overview: [StatisticModel],
            additional: [StatisticModel]) {
                
                return (
                    createOverviewStats(coin: coin),
                    createAdditionalStats(
                        coin: coin,
                        coinDetails: coinDetails
                    )
                )
            }
}

extension DetailViewModel: Subscriptable {
    func addSubscribers() {
        coinDetailService.$coinDetails
            .combineLatest($coin)
            .map(mapDataToStatistic)
            .sink { [weak self] (returnedArrays) in
                self?.overviewStatistics = returnedArrays.overview
                self?.additionalStatistics = returnedArrays.additional
            }
            .store(in: &cancellables)

        coinDetailService.$coinDetails
            .sink { [weak self] (returnedCoinDetails) in
                guard let self = self else { return }
                self.coinDescription = returnedCoinDetails?.readableDescription
                self.websiteURL = returnedCoinDetails?.links?.homepage?.first
                self.redditURL = returnedCoinDetails?.links?.subredditURL
            }
            .store(in: &cancellables)
    }
}

private extension DetailViewModel {

    func createOverviewStats(coin: CoinModel) -> [StatisticModel] {
        let priceStat = self.createPriceStat(coin: coin)
        let marketCapStat = self.createMarketCapStat(coin: coin)
        let rankStat = self.createRankStat(coin: coin)
        let volumeStat = self.createVolumeStat(coin: coin)

        let overviewStats: [StatisticModel] = [
            priceStat,
            marketCapStat,
            rankStat,
            volumeStat
        ]

        return overviewStats
    }

    func createAdditionalStats(
        coin: CoinModel,
        coinDetails: CoinDetailModel?
    ) -> [StatisticModel] {
        let highStat = self.createHighStat(coin: coin)
        let lowStat = self.createLowStat(coin: coin)
        let priceChangeStat = self.createPriceChangeStat(coin: coin)
        let marketCapChangeStat = self.createMarketCapChangeStat(coin: coin)
        let blockTimeStat = self.createBlockTimeStat(coinDetails: coinDetails)
        let hashingStat = self.createHashingStat(coinDetail: coinDetails)

        let additionalStats: [StatisticModel] = [
            highStat,
            lowStat,
            priceChangeStat,
            marketCapChangeStat,
            blockTimeStat,
            hashingStat
        ]

        return additionalStats
    }

    func createPriceStat(coin: CoinModel) -> StatisticModel {
        let price = coin.currentPrice?.asCurrencyWith6Decimals()
        let priceChange = coin.priceChangePercentage24H
        
        return StatisticModel(
            title: coin.name,
            value: price ?? "0.0",
            percentageChange: priceChange
        )
    }

    func createMarketCapStat(coin: CoinModel) -> StatisticModel {
        let marketCap = "$" + (coin.marketCap?.formatedWithAbbreviations() ?? "")
        let marketCapChange = coin.marketCapChangePercentage24H
        
        return StatisticModel(
            title: "Market Capitalization",
            value: marketCap,
            percentageChange: marketCapChange
        )
    }

    func createRankStat(coin: CoinModel) -> StatisticModel {
        let rank = "\(coin.rank)"
        
        return StatisticModel(
            title: "Rank",
            value: rank
        )
    }

    func createVolumeStat(coin: CoinModel) -> StatisticModel {
        let volume = "$" + (coin.totalVolume?.formatedWithAbbreviations() ?? "")
        
        return  StatisticModel(
            title: "Volume",
            value: volume
        )
    }

    func createHighStat(coin: CoinModel) -> StatisticModel {
        let high = coin.high24H?.asCurrencyWith6Decimals() ?? "n/a"
        
        return StatisticModel(
            title: "24h High",
            value: high
        )
    }

    func createLowStat(coin: CoinModel) -> StatisticModel {
        let low = coin.low24H?.asCurrencyWith6Decimals() ?? "n/a"
        
        return StatisticModel(
            title: "24h Low",
            value: low
        )
    }

    func createPriceChangeStat(coin: CoinModel) -> StatisticModel {
        let priceChange = coin.priceChange24H?.asCurrencyWith6Decimals() ?? "n/a"
        let pricePercentChange = coin.priceChangePercentage24H
        
        return StatisticModel(
            title: "24h Price Change",
            value: priceChange,
            percentageChange: pricePercentChange
        )
    }

    func createMarketCapChangeStat(coin: CoinModel) -> StatisticModel {
        let marketCapChange = "$" + (coin.marketCapChange24H?.formatedWithAbbreviations() ?? "")
        let marketCapPercentChange = coin.marketCapChangePercentage24H
        
        return StatisticModel(
            title: "24h Market Capitalization Change",
            value: marketCapChange,
            percentageChange: marketCapPercentChange
        )
    }

    func createBlockTimeStat(coinDetails: CoinDetailModel?) -> StatisticModel {
        let blockTime = coinDetails?.blockTimeInMinutes ?? 0
        let blockTimeString = blockTime == 0 ? "n/a" : "\(blockTime)"
        
        return StatisticModel(
            title: "Block Time",
            value: blockTimeString
        )
    }

    func createHashingStat(coinDetail: CoinDetailModel?) -> StatisticModel {
        let hashing = coinDetail?.hashingAlgorithm ?? "n/a"
        
        return StatisticModel(
            title: "Hashing Algorithm",
            value: hashing
        )
    }
}


