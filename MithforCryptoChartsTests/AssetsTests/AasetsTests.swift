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
        
        let assets = try decoder.decode(AssetListResponse.self, from: json)
        
        XCTAssertNotNil(assets)
        XCTAssertEqual(assets.data[0].id, "bitcoin")        
    }
    
    func test_AssetsModelWithOneNillValue() throws {
        let bundle = Bundle(for: type(of: self))
        
        guard let url = bundle.url(forResource: "Assets", withExtension: "json") else {
            XCTFail("Missing file Assets.json")
            return
        }
        
        let json = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        
        let assets = try decoder.decode(AssetListResponse.self, from: json)
        
        XCTAssertNotNil(assets)
        XCTAssertEqual(assets.data[1].symbol, "ETH")
        
        XCTAssertNil(assets.data[1].maxSupply)
    }
}
