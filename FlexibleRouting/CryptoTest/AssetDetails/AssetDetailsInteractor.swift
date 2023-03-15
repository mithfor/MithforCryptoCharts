//
//  AssetDetailInteractor.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 03.03.2023.
//

import Foundation

typealias AssetDetailsInteractorInput =  AssetDetailsViewControllerOutput

protocol AssetDetailsInteractorOutput: AnyObject {
    func historyFetched(assetHistory : [AssetHistory])
    func fetchFailure(error: NetworkError)
}

final class AssetDetailsInteractor {
    
    private var assetHistory = [AssetHistory]()
    
    var presenter: AssetDetailsPresenterInput?
}

extension AssetDetailsInteractor: AssetDetailsInteractorInput {
    func fetchHistory(asset: Asset) {
        NetworkManager.shared.fetchAssetHistory(id: asset.id ?? "bitcoin") { [weak self] result in
            switch result {
            case .success(let response):
                self?.assetHistory = response.data
                self?.presenter?.historyFetched(assetHistory: self?.assetHistory ?? [AssetHistory]())
            case .failure(let error):
                self?.presenter?.fetchFailure(error: error)
            }
        }
    }
}
