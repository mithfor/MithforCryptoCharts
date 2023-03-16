//
//  AssetsInteractor.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 27.02.2023.
//

import Foundation

typealias Assets = [Asset]
typealias AssetsInteractorInput = AssetsViewControllerOutput

protocol AssetsInteractorOutput: AnyObject {
    func fetched(assets: Assets)
    func fetched(assetIcon: AssetIcon, for asset: Asset)
    func fetchFailure(error: NetworkError)
}

final class AssetsInteractor {
    private var assets = Assets()
    
    var presenter: AssetsPresenterInput?
}

extension AssetsInteractor: AssetsInteractorInput {
    
    func fetchImageFor(asset: Asset, completion: @escaping () -> ()){
        let queue = DispatchQueue(label: "IconQueue", qos: .default, attributes: .concurrent)
        queue.async {
            IconManager.shared.fetchIconFor(asset) { [weak self] (result) in
                
                switch result {
                case .success(let icon):
                    self?.presenter?.fetched(assetIcon: icon, for: asset)
                case .failure(let error):
                    self?.presenter?.fetchFailure(error: error)
                }
            }
        }
    }
    
    func fetchAssets() {
        DispatchQueue.global().async {
            
            NetworkManager.shared.fetchAssets(page: 1) { [weak self] result in
                switch result {
                case .success(let response):
                    self?.assets = response.data
                    self?.presenter?.fetched(assets: self?.assets ?? Assets())
                case .failure(let error):
                    self?.presenter?.fetchFailure(error: error)
                }
            }
        }
    }
}


