//
//  AasetsTests.swift
//  MithforCryptoChartsTests
//
//  Created by Dmitrii Voronin on 30.09.2024.
//

import XCTest
@testable import MithforCryptoCharts

class CryptoAssetsTests: XCTestCase {
    
    func test_GetCryptoAssets_NotNil() {
        let resource = "CryptoAssets"
        
        let assets = try? getCryptoAssets(for: resource, with: "json")
        
        XCTAssertNotNil(assets)
    }
    
    func test_GetAssetListResponse_CorrectFirstAsset() throws {
        
        let resource = "CryptoAssets"
        
        do {
            let assets = try getCryptoAssets(for: resource, with: "json")

            XCTAssertEqual(assets.data[0].id, "bitcoin")

        } catch is NetworkError {
            XCTFail("\(NetworkError.endpoint) Missing file \(resource)).json")
            return
        }
     
    }
    
    func test_GetAssetListResponse_SetsNilToOptionalField() throws {
        
        let resource = "CryptoAssets"
        
        
        do {
            let assets = try getCryptoAssets(for: resource, with: "json")
                        
            XCTAssertNil(assets.data[1].maxSupply)
        } catch is NetworkError {
            XCTFail("\(NetworkError.endpoint): Missing file \(resource).json")
            return
        }
    }
    
    func test_ThrowsAssertsModelWithInvalidJson() throws {
        let resource = "CryptoAssetsInvalid"
    
        XCTAssertThrowsError(try getCryptoAssets(for: resource, with: "json"))
    }
}

extension CryptoAssetsTests {
    
    func getCryptoAssets(for resource: String, with ext: String) throws -> CryptoAssetListResponse {
        
        let bundle = Bundle(for: type(of: self))
        
        guard let url = bundle.url(forResource: resource, withExtension: ext) else {
            throw NetworkError.endpoint
        }
        
        var response = CryptoAssetListResponse(data: [])
        
        do {
            let json = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            response = try decoder.decode(CryptoAssetListResponse.self, from: json)
        } catch let error as NetworkError {
            throw error
        } catch let error as NSError {
            throw error
        }
        
        return response
    }
}
