//
//  AssetHistory.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 02.03.2023.
//

import Foundation

struct AssetListHistoryResponse: Codable {
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    let data: [AssetHistory]
}

struct AssetHistory: Codable {

  var priceUsd: String?
  var time: Int?
  var date: String?

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    priceUsd = try values.decodeIfPresent(String.self, forKey: .priceUsd)
    time = try values.decodeIfPresent(Int.self, forKey: .time)
    date = try values.decodeIfPresent(String.self, forKey: .date)
  }
}
