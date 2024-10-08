//
//  CryptoAssetsRequest.swift
//  MithforCryptoCharts
//
//  Created by Dmitrii Voronin on 17.03.2023.
//

import Foundation

struct CryptoAssetsRequest: DataRequest {
        
//    private let apiKey: String = "some api"
    
    var url: String {
        let baseURL: String = AppConstants.API.assetsBaseUrl
        let path: String = AppConstants.API.assetsPath
        return "\(baseURL)\(path)"
    }
    
//    var queryItems: [String : String] {
//        ["api_key" : apiKey]
//    }
    
    var method: HTTPMethod {
        .get
    }
    
    func decode(_ data: Data) throws -> CryptoAssets {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-mm-dd"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        let response = try decoder.decode( CryptoAssetListResponse.self, from: data)
        return response.data
    }
}
