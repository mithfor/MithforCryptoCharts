//
//  WatchList.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 06.03.2023.
//

import Foundation

protocol UserDefaultsProtocol {
    func set(_ value: Any?, forKey defaultName: String)
    func removeObject(forKey defaultName: String)
    func object(forKey defaultName: String) -> Any?
}

class WatchList {
    var assetsIds = Set<String>()
    var key = "WatchList"
    
    var userDefaults: UserDefaultsProtocol = UserDefaults.standard
    init() {
        //  load saved adata
        self.load()
    }
    
    func contains(_ asset: CryptoAsset) -> Bool {
        print(#function)
        return assetsIds.contains(asset.id ?? "bitcoin")
    }
    
    func add(_ asset: CryptoAsset) {

        assetsIds.insert(asset.id ?? "bitcoin")
        save()
    }
    
    func remove(_ asset: CryptoAsset) {
        assetsIds.remove(asset.id ?? "bitcoin")
        save()
    }
    
    func save() {
        userDefaults.removeObject(forKey: key)
        userDefaults.set(Array(assetsIds), forKey: key)
    }
    
    func load() {
        let array = userDefaults.object(forKey: key) as? [String]
        assetsIds = Set(array ?? [String]())
    }
}

extension UserDefaults: UserDefaultsProtocol {
    
}
