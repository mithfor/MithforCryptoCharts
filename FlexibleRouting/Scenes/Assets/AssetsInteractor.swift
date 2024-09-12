//
//  AssetsInteractor.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 27.02.2023.
//

import Foundation

typealias Assets = [Asset]
typealias AssetsInteractorInput = AssetsViewControllerOutput

protocol AssetsInteractorOutput: AnyObject, InteractingError {
    func fetched(assets: Assets, with assetModel: AssetModel)
//    func fetchFailure(with error: NetworkError)
}

final class AssetsInteractor {
    private var assets: Assets = []
    private var assetModel: AssetModel = [:]
    
    var presenter: AssetsPresenterInput?
    
    var networkService: DefaultNetworkService?
}

extension AssetsInteractor: AssetsInteractorInput {
    
    func fetchImage(for asset: Asset, completion: @escaping (() -> ())) {
        let queue = DispatchQueue(label: "IconQueue", qos: .default, attributes: .concurrent)
        queue.async {
            IconManager.shared.fetchIconFor(asset) { [weak self] (result) in
                
                switch result {
                case .success(let icon):
                    self?.assetModel[asset.id ?? ""] = icon.image
                    completion()
                case .failure(let error):
                    self?.assetModel[asset.id ?? ""] = AssetImage()
                    completion()
                    self?.presenter?.failureDidFetch(error)
                }
            }
        }
    }
    
    func fetchAssets() {
        DispatchQueue.global().async {
            
            let request = AssetsRequest()
            if let networkService = self.networkService {
                networkService.request(request, completion: { [weak self] (result) in
                    switch result {
                    case .success(let response):
                        self?.assets = response
                        self?.presenter?.fetched(assets: self?.assets ?? [],
                                                 with: self?.assetModel ?? [:])
//                        self?.fetchImagesFor(self?.assets ?? Assets())
                    case .failure(let error):
                        self?.presenter?.failureDidFetch(error)
                    }
                })
            }
        }
    }
    
    func fetchImagesFor(_ assets: Assets) {
        
        let queue = DispatchQueue(label: "FetchingImagesForAssetsQueue", qos: .default, attributes: .concurrent)
        queue.async {
            let group = DispatchGroup()
            assets.forEach({ asset in
                group.enter()
                
                self.fetchImage(for: asset) {
                    group.leave()
                }
            })
            
            group.notify(queue: .main) {
                self.presenter?.fetched(assets: assets, with: self.assetModel)
            }
        }
    }
}


