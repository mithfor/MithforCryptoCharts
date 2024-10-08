//
//  FoundedIcon.swift
//  MithforCryptoCharts
//
//  Created by Dmitrii Voronin on 08.10.2024.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let foundedIcon = try? JSONDecoder().decode(FoundedIcon.self, from: jsonData)

import Foundation

// MARK: - FoundedIcon
struct FoundedIcon: Codable {
    let publicID: String
    let filesize: Int
    let contentType: String
    let bitmap, vector, exported, cleaned: Int
    let size, width, height: Int
    let url: String

    enum CodingKeys: String, CodingKey {
        case publicID
        case filesize, contentType, bitmap, vector, exported, cleaned, size, width, height, url
    }
}
