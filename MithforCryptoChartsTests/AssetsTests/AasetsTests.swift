//
//  AasetsTests.swift
//  MithforCryptoChartsTests
//
//  Created by Dmitrii Voronin on 30.09.2024.
//

import XCTest
@testable import MithforCryptoCharts

class AssetsTests: XCTestCase {
    func test_AssetsModel() throws {
        let bundle = Bundle(for: type(of: self))
        
        guard let url = bundle.url(forResource: "Assets", withExtension: "json") else {
            XCTFail("Missing file Assets.json")
            return
        }
        
        let json = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        
        let asset = try decoder.decode(Asset.self, from: json)
        
        XCTAssertNotNil(asset)
        XCTAssertEqual(asset.symbol, "BTC")
        
    }
    
    func test_AssetsModelWithOneNillValue() throws {
        let bundle = Bundle(for: type(of: self))
        
        guard let url = bundle.url(forResource: "AssetsWithNil", withExtension: "json") else {
            XCTFail("Missing file AssetsWithNil.json")
            return
        }
        
        let json = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        
        let asset = try decoder.decode(Asset.self, from: json)
        
        XCTAssertNotNil(asset)
        XCTAssertEqual(asset.symbol, "ETH")
        
        XCTAssertNil(asset.maxSupply)
        
    }
}
