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
            let model = try JSONDecoder().decode(MarketDatalModel.self, from: json)
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
            let model = try JSONDecoder().decode(MarketDatalModel.self, from: json)
            XCTAssertNil(model.marketCapChangePercentage24HUsd)
        } catch {
            XCTFail("Decoding failed \(error)")
        }
    }
}
