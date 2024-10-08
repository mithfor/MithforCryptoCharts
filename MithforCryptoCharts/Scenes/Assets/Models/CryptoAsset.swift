//
//  CryptoAsset.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 26.02.2023.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let asset = try? JSONDecoder().decode(Asset.self, from: jsonData)

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

import Foundation

struct CryptoAssetListResponse: Codable {
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    let data: [CryptoAsset]
}

struct CryptoAssetResponse: Codable {
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    let data: CryptoAsset
}

struct CryptoAsset: Codable, Hashable, Equatable {

    var id: String?
    var rank: String?
    var symbol: String?
    var name: String?
    var supply: String?
    var maxSupply: String?
    var marketCapUsd: String?
    var volumeUsd24Hr: String?
    var priceUsd: String?
    var changePercent24Hr: String?
    var vwap24Hr: String?
    var explorer: String?
}
