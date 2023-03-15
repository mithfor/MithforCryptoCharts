//
//  AssetHistory.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 02.03.2023.
//

import Foundation

struct AssetListHistoryResponse: Codable {
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    
    let data: [AssetHistory]
}

struct AssetHistory: Codable {

  var priceUsd : String? = nil
  var time     : Int?    = nil
  var date     : String? = nil

  enum CodingKeys: String, CodingKey {

    case priceUsd = "priceUsd"
    case time     = "time"
    case date     = "date"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    priceUsd = try values.decodeIfPresent(String.self , forKey: .priceUsd )
    time     = try values.decodeIfPresent(Int.self    , forKey: .time     )
    date     = try values.decodeIfPresent(String.self , forKey: .date     )
  }
}
