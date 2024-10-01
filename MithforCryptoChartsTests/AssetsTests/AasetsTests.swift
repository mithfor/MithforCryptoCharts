//
//  AasetsTests.swift
//  MithforCryptoChartsTests
//
//  Created by Dmitrii Voronin on 30.09.2024.
//

import XCTest
@testable import MithforCryptoCharts

class AssetsTests: XCTestCase {
    
    func test_GetAssets_NotNil() {
        let resource = "Assets"
        
        let assets = try? getAssets(for: resource, with: "json")
        
        XCTAssertNotNil(assets)
    }
    
    func test_GetAssetListResponse_CorrectFirstAsset() throws {
        
        let resource = "Assets"
        
        do {
            let assets = try getAssets(for: resource, with: "json")

            XCTAssertEqual(assets.data[0].id, "bitcoin")

        } catch is NetworkError {
            XCTFail("\(NetworkError.endpoint) Missing file \(resource)).json")
            return
        }
     
    }
    
    func test_GetAssetListResponse_SetsNilToOptionalField() throws {
        
        let resource = "Assets"
        
        
        do {
            let assets = try getAssets(for: resource, with: "json")
                        
            XCTAssertNil(assets.data[1].maxSupply)
        } catch is NetworkError {
            XCTFail("\(NetworkError.endpoint): Missing file \(resource).json")
            return
        }
    }
    
    func test_ThrowsAssertsModelWithInvalidJson() throws {
        let resource = "AssetsInvalid"
    
        XCTAssertThrowsError(try getAssets(for: resource, with: "json"))
    }
}

extension AssetsTests {
    
    func getAssets(for resource: String, with ext: String) throws -> AssetListResponse {
        
        let bundle = Bundle(for: type(of: self))
        
        guard let url = bundle.url(forResource: resource, withExtension: ext) else {
            throw NetworkError.endpoint
        }
        
        var response = AssetListResponse(data: [])
        
        do {
            let json = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            response = try decoder.decode(AssetListResponse.self, from: json)
        } catch let error as NetworkError {
            throw error
        } catch let error as NSError {
            throw error
        }
        
        return response
    }
}
