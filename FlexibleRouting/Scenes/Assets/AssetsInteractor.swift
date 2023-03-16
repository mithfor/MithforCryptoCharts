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
    func fetched(assets: Assets, with assetModel: AssetModel)
    func fetchFailure(error: NetworkError)
}

final class AssetsInteractor {
    private var assets: Assets = []
    private var assetModel: AssetModel = [:]
    
    var presenter: AssetsPresenterInput?
}

extension AssetsInteractor: AssetsInteractorInput {
    
    func fetchImageFor(asset: Asset, completion: @escaping (() -> ())) {
        let queue = DispatchQueue(label: "IconQueue", qos: .default, attributes: .concurrent)
        queue.async {
            IconManager.shared.fetchIconFor(asset) { [weak self] (result) in
                
                switch result {
                case .success(let icon):
                    self?.assetModel[asset.id ?? ""] = icon.image
                    completion()
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
                    self?.fetchImagesFor(self?.assets ?? Assets())
                    //self?.presenter?.fetched(assets: self?.assets ?? Assets())
                case .failure(let error):
                    self?.presenter?.fetchFailure(error: error)
                }
            }
        }
    }
    
    func fetchImagesFor(_ assets: Assets) {
        
        let queue = DispatchQueue(label: "FetchingImagesForAssetsQueue", qos: .default, attributes: .concurrent)
        queue.async {
            let group = DispatchGroup()
            assets.forEach({ asset in
                group.enter()
                
                self.fetchImageFor(asset: asset) {
                    group.leave()
                }
            })
            
            group.notify(queue: .main) {
                self.presenter?.fetched(assets: assets, with: self.assetModel)
            }
        }
    }
}


