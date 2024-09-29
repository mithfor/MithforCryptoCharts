//
//  DatabaseManager.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 06.03.2023.
//

import Foundation

// TODO: - needs to imlement
final class DatabaseManager {
    private let watchlistKey = "watchlist_key"
    
    func save(assets: Set<Asset>) {
        
        if let encoded = try? JSONEncoder().encode(assets) {
            UserDefaults.standard.set(encoded, forKey: watchlistKey)
        }
    }
    
    func load() -> Set<Asset> {
        
        let array = UserDefaults.standard.array(forKey: watchlistKey) as? [Asset] ?? [Asset]()
        
        return Set(array)
    }
    
    func updateWatchList(asset: Asset) {
        var assets = load()
        
        assets.insert(asset)
        save(assets: assets)
    }
}
