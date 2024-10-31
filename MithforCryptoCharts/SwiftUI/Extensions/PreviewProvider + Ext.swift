//
//  PreviewProvider + Ext.swift
//  MithforCryptoCharts
//
//  Created by Dmitrii Voronin on 31.10.2024.
//

import Foundation
import SwiftUI

extension PreviewProvider {
    static var dev: DeveloperPreview {
        return DeveloperPreview.instance
    }
}

class DeveloperPreview {
    static let instance = DeveloperPreview()
    
    private init() {}
    
    let coin = CoinModel(id: "bitcoin",
                         symbol: "btc",
                         name: "Bitcoin",
                         image: "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
                         currentPrice: 72315.44505942067,
                         marketCap: 1431583223259,
                         marketCapRank: 1,
                         fullyDilutedValuation: 1520213248235,
                         totalVolume: 42403684838,
                         high24H: 72860,
                         low24H: 71430,
                         priceChange24H: -43.829214780940674,
                         priceChangePercentage24H: -0.06057,
                         marketCapChange24H: 3082543127,
                         marketCapChangePercentage24H: 0.21579,
                         circulatingSupply: 19775678,
                         totalSupply: 21000000,
                         maxSupply: 21000000,
                         ath: 73738,
                         athChangePercentage: -1.79384,
                         athDate: "2024-03-14T07:10:36.635Z",
                         atl: 67.81,
                         atlChangePercentage: 106692.89313,
                         atlDate: "2013-07-06T00:00:00.000Z",
                         lastUpdated: "2024-10-31T08:05:50.737Z",
                         sparklineIn7D: SparklineIn7D(price: [
                            67389.42187998109,
                            67131.71363671799
                         ]),
                         priceChangePercentage24HInCurrency: -0.060571661643332955,
                         currentHoldings: 1.5)
}

/*
 URL = https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=bitcoin&order=market_cap_asc&per_page=20&page=1&sparkline=true&price_change_percentage=24h&locale=en&precision=full'
 
 JSON:
 
 [
   {
     "id": "bitcoin",
     "symbol": "btc",
     "name": "Bitcoin",
     "image": "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
     "current_price": 72315.44505942067,
     "market_cap": 1431583223259,
     "market_cap_rank": 1,
     "fully_diluted_valuation": 1520213248235,
     "total_volume": 42403684838,
     "high_24h": 72860,
     "low_24h": 71430,
     "price_change_24h": -43.829214780940674,
     "price_change_percentage_24h": -0.06057,
     "market_cap_change_24h": 3082543127,
     "market_cap_change_percentage_24h": 0.21579,
     "circulating_supply": 19775678,
     "total_supply": 21000000,
     "max_supply": 21000000,
     "ath": 73738,
     "ath_change_percentage": -1.79384,
     "ath_date": "2024-03-14T07:10:36.635Z",
     "atl": 67.81,
     "atl_change_percentage": 106692.89313,
     "atl_date": "2013-07-06T00:00:00.000Z",
     "roi": null,
     "last_updated": "2024-10-31T08:05:50.737Z",
     "sparkline_in_7d": {
       "price": [
         67389.42187998109,
         67131.71363671799,

       ]
     },
     "price_change_percentage_24h_in_currency": -0.060571661643332955
   }
 ]
 */
