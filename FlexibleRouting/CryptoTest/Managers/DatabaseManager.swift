//
//  DatabaseManager.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 06.03.2023.
//

import Foundation


// TODO: - needs to imlement
final class DatabaseManager {
    private let WATCHLIST_KEY = "watchlist_key"
    
    func save(assets: Set<Asset>) {
        
        if let encoded = try? JSONEncoder().encode(assets) {
            UserDefaults.standard.set(encoded, forKey: WATCHLIST_KEY)
        }
    }
    
    func load() -> Set<Asset> {
        
        let array = UserDefaults.standard.array(forKey: WATCHLIST_KEY) as? [Asset] ?? [Asset]()
        
        return Set(array)
    }
    
    func updateWatchList(asset: Asset) {
        var assets = load()
        
        
        assets.insert(asset)
        save(assets: assets)
    }
}
