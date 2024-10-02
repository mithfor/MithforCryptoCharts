//
//  NetworkError.swift
//  MithforCryptoCharts
//
//  Created by Dmitrii Voronin on 02.10.2024.
//

import Foundation

enum NetworkError: String, Error {
    case title = "Network error"
    case endpoint = "Bad endpoint"
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again"
    case invalidData = "The data received from the server was invalid. Please try again"
    case unableToDecode = "Unable to decode an answer"
}
