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
    
    override init(apiClient: APIClient?) {
        super.init(apiClient: apiClient)
    }
    
    func getTodo(with id: Int) async throws -> TodoDTO? {
        let apiSpec: TodosAPISpec = .getTodo(id: id)
        
        do {
            let todo = try await apiClient?.sendRequest(apiSpec)
            return todo as? TodoDTO
        } catch {
            print(error)
            return nil
        }
    }
    
    func getTodos() async throws -> [TodoDTO] {
        let apiSpec: TodosAPISpec = .getTodos
        let todos = try await apiClient?.sendRequest(apiSpec)
        return todos as? [TodoDTO] ?? []
    }
    
    // TODO: - to make test
    func create(userId: Int, title: String) async throws -> TodoDTO {
        let apiSpec: TodosAPISpec = .create(
            todo: TodoDTO(userId: userId,
                          title: title)
        )
        let todo = try await apiClient?.sendRequest(apiSpec)

        return todo as? TodoDTO ?? TodoDTO(userId: .zero,
                                           title: "")
    }
}
