//
//  NetworkingManager.swift
//  MithforCryptoCharts
//
//  Created by Dmitrii Voronin on 14.11.2024.
//

import Foundation
import Combine

class NetworkingManager {
    
    static func download(url: URL) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap { output in
                
                guard let response = output.response as? HTTPURLResponse,
                      isSuccessfull(statusCode: response.statusCode) == true
                else {
                    throw URLError(.badServerResponse)
                }
                
                return output.data
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        
        func isSuccessfull(statusCode: Int) -> Bool {
            return (statusCode >= 200 && statusCode < 300) ? true : false
        }
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print("\(#function) : \(error.localizedDescription)")
        }
    }
    
}
