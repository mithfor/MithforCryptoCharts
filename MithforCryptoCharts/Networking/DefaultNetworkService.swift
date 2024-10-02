//
//  DefaultNetworkService.swift
//  MithforCryptoCharts
//
//  Created by Dmitrii Voronin on 17.03.2023.
//

import Foundation

enum NetworkError: String, Error {
    case endpoint = "Bad endpoint"
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again"
    case invalidData = "The data received from the server was invalid. Please try again"
    case unableToDecode = "Unable to decode an answer"
}

protocol InteractingError {
    func fetchFailure(with error: NetworkError)
}

protocol NetworkService {
    func request<Request: DataRequest>(_ request: Request,
                                       completion: @escaping (Result<Request.Response, NetworkError>) -> Void)
}

class DefaultNetworkService: NetworkService {
    func request<Request>(_ request: Request,
                          completion: @escaping (Result<Request.Response, NetworkError>) -> Void) where Request: DataRequest {
        
        guard var urlComponent = URLComponents(string: request.url) else {
            return completion(.failure(NetworkError.endpoint))
        }
        
        let queryItems: [URLQueryItem] = []
        
        request.queryItems.forEach {
            _ = URLQueryItem(name: $0.key, value: $0.value)
        }
        
        urlComponent.queryItems = queryItems
        
        guard let url = urlComponent.url else {
            return completion(.failure(NetworkError.endpoint))
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                return completion(.failure(error as? NetworkError ?? NetworkError.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
                return completion(.failure(NetworkError.invalidResponse))
            }
            
            guard let data = data else {
                return completion(.failure(NetworkError.invalidData))
            }
            
            do {
                try completion(.success(request.decode(data)))
            } catch let error as NetworkError {
                completion(.failure(error))
            } catch {
                completion(.failure(NetworkError.unableToDecode))
            }
            
        }
        .resume()
    }
}
