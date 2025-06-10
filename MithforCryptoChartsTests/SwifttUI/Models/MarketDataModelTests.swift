//
//  MarketDataModelTests.swift
//  MithforCryptoChartsTests
//
//  Created by Dmitrii Voronin on 10.06.2025.
//

import XCTest
@testable import MithforCryptoCharts

class MarketDataModelTests: XCTestCase {
    
    // MARK: - Decoding Tests
    
    func testDecodingFullData() {
        let json = """
        {
            "total_market_cap": {"usd": 123456789000},
            "total_volume": {"usd": 98765432000},
            "market_cap_percentage": {"btc": 0.4567},
            "market_cap_change_percentage_24h_usd": 2.34
        }
        """.data(using: .utf8)!
        
        do {
            let model = try JSONDecoder().decode(MarketDataModel.self, from: json)
            XCTAssertEqual(model.totalMarketCap["usd"], 123456789000)
            XCTAssertEqual(model.totalVolume["usd"], 98765432000)
            XCTAssertEqual(model.marketCapPercentage["btc"], 0.4567)
            XCTAssertEqual(model.marketCapChangePercentage24HUsd, 2.34)
        } catch {
            XCTFail("Decoding failed \(error)")
        }
    }
    
    func testDecodingMissingOptionalField() {
        let json = """
        {
            "total_market_cap": {"usd": 123456789000},
            "total_volume": {"usd": 98765432000},
            "market_cap_percentage": {"btc": 0.4567},
        }
        """.data(using: .utf8)!
        
        do {
            let model = try JSONDecoder().decode(MarketDataModel.self, from: json)
            XCTAssertNil(model.marketCapChangePercentage24HUsd)
        } catch {
            XCTFail("Decoding failed \(error)")
        }
    }
    
    // MARK: - Computed Properties Tests
    
    func testMarketCup() {
        let model = MarketDataModel(
            totalMarketCap: ["usd": 123456789000, "eur": 102345678900],
            totalVolume: [:],
            marketCapPercentage: [:],
            marketCapChangePercentage24HUsd: nil
        )
        
        XCTAssertEqual(model.marketCap, "$123.46Bn")
        
    }
    
    func testMarketCupMissingUSD() {
        let model = MarketDataModel(
            totalMarketCap: ["eur": 102345678900],
            totalVolume: [:],
            marketCapPercentage: [:],
            marketCapChangePercentage24HUsd: nil
        )
        
        XCTAssertEqual(model.marketCap, "")
    }
    
    func testVolume() {
        let model = MarketDataModel(
            totalMarketCap: [:],
            totalVolume: ["usd": 98765432000, "eur": 88765432000],
            marketCapPercentage: [:],
            marketCapChangePercentage24HUsd: nil
        )
        
        XCTAssertEqual(model.volume, "$98.77Bn")
    }
    
    func testVolumeMissingUSD() {
        let model = MarketDataModel(
            totalMarketCap: [:],
            totalVolume: ["eur": 88765432000],
            marketCapPercentage: [:],
            marketCapChangePercentage24HUsd: nil
        )
        
        XCTAssertEqual(model.volume, "")
    }
    
    func testBitcoinDominance() {
        let model = MarketDataModel(
            totalMarketCap: [:],
            totalVolume: [:],
            marketCapPercentage: ["btc": 0.4567, "eth": 0.2345],
            marketCapChangePercentage24HUsd: nil
        )
        
        XCTAssertEqual(model.bitcoinDominance, "0.46%")
    }
    
    func testBitcoinDominanceMissngBTC() {
        let model = MarketDataModel(
            totalMarketCap: [:],
            totalVolume: [:],
            marketCapPercentage: ["eth": 0.2345],
            marketCapChangePercentage24HUsd: nil
        )
        
        XCTAssertEqual(model.bitcoinDominance, "")
    }
}
