//
//  WatchList.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 06.03.2023.
//

import Foundation

class WatchList {
    var assetsIds = Set<String>()
    var key = "WatchList"
    
    init() {
        
        //load saved adata
        self.load()
    }
    
    func contains(_ asset: Asset) -> Bool {
        print(#function)
        return assetsIds.contains(asset.id ?? "bitcoin")
    }
    
    func add(_ asset: Asset) {

        assetsIds.insert(asset.id ?? "bitcoin")
        save()
    }
    
    func remove(_ asset: Asset) {
        assetsIds.remove(asset.id ?? "bitcoin")
        save()
    }
    
    func save() {
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.set(Array(assetsIds), forKey: key)
    }
    
    func load(){
        let array = UserDefaults.standard.object(forKey: key) as? [String]
        assetsIds = Set(array ?? [String]())
    }
}
