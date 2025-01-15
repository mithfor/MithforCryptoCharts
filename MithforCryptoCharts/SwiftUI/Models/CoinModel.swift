//
//  CoinModel.swift
//  MithforCryptoCharts
//
//  Created by Dmitrii Voronin on 31.10.2024.
//

import Foundation

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

// MARK: - CoinModel
struct CoinModel: Identifiable, Codable {
    let id, symbol, name: String
    let image: String
    let currentPrice: Double?
    let marketCap, marketCapRank, fullyDilutedValuation, totalVolume: Double?
    let high24H, low24H: Double?
    let priceChange24H, priceChangePercentage24H: Double?
    let marketCapChange24H: Double?
    let marketCapChangePercentage24H: Double?
    let circulatingSupply, totalSupply, maxSupply, ath: Double?
    let athChangePercentage: Double?
    let athDate: String?
    let atl, atlChangePercentage: Double?
    let atlDate: String?
    let lastUpdated: String?
    let sparklineIn7D: SparklineIn7D?
    let priceChangePercentage24HInCurrency: Double?
    let currentHoldings: Double?
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case marketCapChange24H = "market_cap_change_24h"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case lastUpdated = "last_updated"
        case sparklineIn7D = "sparkline_in_7d"
        case priceChangePercentage24HInCurrency = "price_change_percentage_24h_in_currency"
        case currentHoldings
    }
    
    func updatedHoldings(amount: Double) -> CoinModel {
        .init(
            id: id,
            symbol: symbol,
            name: name,
            image: image,
            currentPrice: currentPrice,
            marketCap: marketCap,
            marketCapRank: marketCapRank,
            fullyDilutedValuation: fullyDilutedValuation,
            totalVolume: totalVolume,
            high24H: high24H,
            low24H: low24H,
            priceChange24H: priceChange24H,
            priceChangePercentage24H: priceChangePercentage24H,
            marketCapChange24H: marketCapChange24H,
            marketCapChangePercentage24H: marketCapChangePercentage24H,
            circulatingSupply: circulatingSupply,
            totalSupply: totalSupply,
            maxSupply: maxSupply,
            ath: ath,
            athChangePercentage: athChangePercentage,
            athDate: athDate,
            atl: atl,
            atlChangePercentage: atlChangePercentage,
            atlDate: atlDate,
            lastUpdated: lastUpdated,
            sparklineIn7D: sparklineIn7D,
            priceChangePercentage24HInCurrency: priceChangePercentage24HInCurrency,
            currentHoldings: amount
        )
    }
    
    var currentHoldingsValue: Double {
        return (currentHoldings ?? 0) * (currentPrice ?? 0)
    }
    
    var rank: Int {
        return Int(marketCapRank ?? Double(UInt8.max))
    }
}

// MARK: - SparklineIn7D
struct SparklineIn7D: Codable {
    let price: [Double]?
}

extension SparklineIn7D {
    
    var movingAveragePrice: [Double]? {
        return movingAverage(timeSeries: self.price ?? [], smoothingWindow: 6)
    }
    
    private func movingAverage(timeSeries: [Double], smoothingWindow: Int) -> [Double] {
        var result: [Double] = []
        
        var currentSum = 0.0
        for ind in 0..<smoothingWindow {
            currentSum += Double(timeSeries[ind])
        }
        result.append(Double(currentSum) / Double(smoothingWindow))
        
        for ind in 0..<timeSeries.count - smoothingWindow {
            currentSum -= Double(timeSeries[ind])
            currentSum += Double(timeSeries[ind + smoothingWindow])
            let currentAvg = currentSum / Double(smoothingWindow)
            result.append(Double(currentAvg))
        }
        
        return result
    }
}
