//
//  IconManager.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 27.02.2023.
//

import UIKit

protocol IconManagable {
    func fetchIconFor(asset: Asset) -> AssetIcon
}

class IconManager: IconManagable {
    func fetchIconFor(asset: Asset) -> AssetIcon {
        AssetIcon(image: (UIImage(named: asset.symbol?.lowercased() ?? "usd") ?? UIImage(named: "usd")) ?? UIImage())
    }
    
    static let shared = IconManager()
    
    private init() {}
}

struct AssetIcon {
    var image = UIImage()
}


