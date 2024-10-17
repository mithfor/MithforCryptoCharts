//
//  TodosAPISpec.swift
//  MithforCryptoCharts
//
//  Created by Dmitrii Voronin on 17.10.2024.
//

import Foundation
import MFNetwork

enum TodosAPISpec: APIClient.APISpec {
    
    case getTodos
    case getTodo(id: Int)
    case create(todo: TodoDTO)
    
    var endpoint: String {
        switch self {
        case .getTodos:
            return "/todos"
        case .getTodo(id: let id):
            return "/todos/\(id)"
        case .create(_):
            return "/todos"
        }
    }
    
    var method: MFNetwork.APIClient.HttpMethod {
        switch self {
        case .getTodos:
            return .get
        case .getTodo(id: _):
            return .get
        case .create(_):
            return .post
        }
    }
    
    var returnType: any MFNetwork.DecodableType.Type {
        switch self {
        case .getTodos:
            return [TodoDTO].self
        case .getTodo(id: _):
            return TodoDTO.self
        case .create(_):
            return TodoDTO.self
        }
    }
    
    var body: Data? {
        switch self {
        case .getTodos:
            return nil
        case .getTodo(id: _):
            return nil
        case .create(let todo):
            return try? JSONEncoder().encode(todo)
        }
    }
    
    
}


