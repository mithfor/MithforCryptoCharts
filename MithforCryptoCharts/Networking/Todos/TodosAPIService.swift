//
//  TodosAPIService.swift
//  MithforCryptoCharts
//
//  Created by Dmitrii Voronin on 17.10.2024.
//

import Foundation
import MFNetwork

enum TodosAPIServiceError {
    case noUserIdFound
}

class TodosAPIService: APIService {
    func getTodo(with id: Int) async throws -> TodoDTO? {
        TodoDTO(userId: 1, id: 1, title: "Title", completed: false)
    }
}
