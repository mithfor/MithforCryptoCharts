//
//  FakeUserDefaults.swift
//  MithforCryptoChartsTests
//
//  Created by Dmitrii Voronin on 10.10.2024.
//

import Foundation
@testable import MithforCryptoCharts

class FakeUserDefaults: UserDefaultsProtocol {
    
    var assets: [String: Set<String>] = [:]
    
    func set(_ value: Any?, forKey defaultName: String) {
        assets[defaultName] = value as? Set<String>
    }
    
    func removeObject(forKey defaultName: String) {
        assets.removeValue(forKey: defaultName)
    }
    
    func object(forKey defaultName: String) -> Any? {
        return assets[defaultName]
    }
    
    
}
