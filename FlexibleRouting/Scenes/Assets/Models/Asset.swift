//
//  Asset.swift
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

struct AssetListResponse: Codable {
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    
    let data: [Asset]
}

struct AssetResponse: Codable {
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    
    let data: Asset
}


// MARK: - Asset
struct Asset: Codable, Hashable, Equatable {

  var id                : String? = nil
  var rank              : String? = nil
  var symbol            : String? = nil
  var name              : String? = nil
  var supply            : String? = nil
  var maxSupply         : String? = nil
  var marketCapUsd      : String? = nil
  var volumeUsd24Hr     : String? = nil
  var priceUsd          : String? = nil
  var changePercent24Hr : String? = nil
  var vwap24Hr          : String? = nil
  var explorer          : String? = nil
    
//  var isInWatchList: Bool

  enum CodingKeys: String, CodingKey {

    case id                = "id"
    case rank              = "rank"
    case symbol            = "symbol"
    case name              = "name"
    case supply            = "supply"
    case maxSupply         = "maxSupply"
    case marketCapUsd      = "marketCapUsd"
    case volumeUsd24Hr     = "volumeUsd24Hr"
    case priceUsd          = "priceUsd"
    case changePercent24Hr = "changePercent24Hr"
    case vwap24Hr          = "vwap24Hr"
    case explorer          = "explorer"
  
  }
    
    

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    id                = try values.decodeIfPresent(String.self , forKey: .id                )
    rank              = try values.decodeIfPresent(String.self , forKey: .rank              )
    symbol            = try values.decodeIfPresent(String.self , forKey: .symbol            )
    name              = try values.decodeIfPresent(String.self , forKey: .name              )
    supply            = try values.decodeIfPresent(String.self , forKey: .supply            )
    maxSupply         = try values.decodeIfPresent(String.self , forKey: .maxSupply         )
    marketCapUsd      = try values.decodeIfPresent(String.self , forKey: .marketCapUsd      )
    volumeUsd24Hr     = try values.decodeIfPresent(String.self , forKey: .volumeUsd24Hr     )
    priceUsd          = try values.decodeIfPresent(String.self , forKey: .priceUsd          )
    changePercent24Hr = try values.decodeIfPresent(String.self , forKey: .changePercent24Hr )
    vwap24Hr          = try values.decodeIfPresent(String.self , forKey: .vwap24Hr          )
    explorer          = try values.decodeIfPresent(String.self , forKey: .explorer          )
  }
}


