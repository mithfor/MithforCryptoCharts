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
    
    func getTodo(with id: Int) async throws -> TodoModel? {
        let apiSpec: TodosAPISpec = .getTodo(id: id)
        
        do {
            let todo = try await apiClient?.sendRequest(apiSpec)
            return todo as? TodoModel
        } catch {
            print(error)
            return nil
        }
    }
    
    func getTodos() async throws -> [TodoModel] {
        let apiSpec: TodosAPISpec = .getTodos
        let todos = try await apiClient?.sendRequest(apiSpec)
        return todos as? [TodoModel] ?? []
    }
    
    // TODO: - to make test
    func create(userId: Int, title: String) async throws -> TodoModel {
        let apiSpec: TodosAPISpec = .create(
            todo: TodoModel(userId: userId,
                          title: title)
        )
        let todo = try await apiClient?.sendRequest(apiSpec)

        return todo as? TodoModel ?? TodoModel(userId: .zero,
                                           title: "")
    }
}
