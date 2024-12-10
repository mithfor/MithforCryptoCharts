//
//  DataService.swift
//  MithforCryptoCharts
//
//  Created by Dmitrii Voronin on 22.11.2024.
//

import Foundation

protocol DataService: AnyObject {
    
    func fetchData()
}

protocol NetworkDataService: DataService {
    
    var networkingManager: NetworkingManager { get }
}

protocol PersistanceDataService: DataService {
    
}
