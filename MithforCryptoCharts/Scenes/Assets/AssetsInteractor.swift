//
//  CryptoAssetsInteractor.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 27.02.2023.
//

import Foundation

typealias CryptoAssets = [CryptoAsset]
typealias CryptoAssetsInteractorInput = CryptoAssetsViewControllerOutput

protocol CryptoAssetsInteractorOutput: AnyObject, InteractingError {
    func fetched(assets: CryptoAssets)
    func fetchFailure(with error: NetworkError)
}

final class CryptoAssetsInteractor {
    private var assets: CryptoAssets = []
    private var assetModel: AssetModel = [:]
    
    var presenter: CryptoAssetsPresenterInput?
    
    var networkService: AssetNetworkService?
}

class AssetNetworkService: DefaultNetworkService {}

extension CryptoAssetsInteractor: CryptoAssetsViewControllerOutput {
    
    func fetchCryptoAssets() {
        
        DispatchQueue.global().async {
            
            let request = CryptoAssetsRequest()
            if let networkService = self.networkService {
                networkService.request(request, completion: { [weak self] (result) in
                    switch result {
                    case .success(let response):
                        self?.assets = response
                        self?.presenter?.fetched(assets: self?.assets ?? [])
                    case .failure(let error):
                        self?.presenter?.fetchFailure(with: error)
                    }
                })
            }
        }
    }
    
    func fetchCryptoAssets() async {
        let request = CryptoAssetsRequest()
        networkService?.request(
            request,
            completion: { [weak self] result in
            switch result {
            case .success(let response):
                self?.assets = response
                self?.presenter?.fetched(assets: self?.assets ?? [])
            case .failure(let error):
                self?.presenter?.fetchFailure(with: error)
                
            }
        })
    }
}
