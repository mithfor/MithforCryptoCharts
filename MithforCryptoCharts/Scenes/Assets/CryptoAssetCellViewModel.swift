//
//  CryptoAssetCellViewModel.swift
//  MithforCryptoCharts
//
//  Created by Dmitrii Voronin on 08.10.2024.
//
import UIKit

struct CryptoAssetCellViewModel {
    let asset: CryptoAsset
    let image: UIImage
    
    weak var delegate: CryptoAssetsTableViewCellDelegate?
}
