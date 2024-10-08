//
//  CryptoAssetCellViewModel.swift
//  MithforCryptoCharts
//
//  Created by Dmitrii Voronin on 08.10.2024.
//
import UIKit

protocol CryptoAssetViewModel {
    var asset: CryptoAsset { get }
    var image: UIImage { get }
}

struct CryptoAssetCellViewModel:  CryptoAssetViewModel{
    var asset: CryptoAsset
    var image: UIImage
    
    weak var delegate: CryptoAssetsTableViewCellDelegate?
}

final class CryptoAssetCellViewModelFactory {
    static func createViewModel(with asset: CryptoAsset, and delegate: CryptoAssetsTableViewCellDelegate?) -> CryptoAssetViewModel {
        let asset = asset
        let image = UIImage(named: asset.symbol?.lowercased()
                            ?? "generic")
        ?? UIImage(named: "generic")
        ?? UIImage()
        
        return CryptoAssetCellViewModel(
            asset: asset,
            image: image,
            delegate: delegate)
    }
}
