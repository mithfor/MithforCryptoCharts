//
//  TodoDTO.swift
//  MithforCryptoCharts
//
//  Created by Dmitrii Voronin on 17.10.2024.
//

import Foundation
import MFNetwork

struct TodoDTO: Encodable, DecodableType{
    let id: Int?
    let userId: Int
    let title: String
    let completed: Bool
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        guard !container.allKeys.isEmpty else {
            throw DecodingError.dataCorrupted(
                DecodingError.Context(
                    codingPath: decoder.codingPath,
                    debugDescription: "Empty object \(container.allKeys)")
            )
        }
        
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.userId = try container.decode(Int.self, forKey: .userId)
        self.title = try container.decode(String.self, forKey: .title)
        self.completed = try container.decode(Bool.self, forKey: .completed)
    }
    
    init(id: Int?, userId: Int, title: String, completed: Bool) {
        self.id = id
        self.userId = userId
        self.title = title
        self.completed = completed
    }
}
