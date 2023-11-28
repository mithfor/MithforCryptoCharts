//
//  WatchListInteractor.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 07.03.2023.
//

import Foundation
typealias WatchListInteractorInput = WatchListViewControllerOutput

protocol InteractableError {
    func failureDidFetch(_ error: NetworkError)
}

protocol WatchListInteractorOutput: AnyObject, InteractableError {
    
    func assetsDidFetch(_ assets: Assets)
}

final class WatchListInteractor {
    lazy var watchList = WatchList()
    
    private var assets = Assets()
    
    var presenter: WatchListPresenterInput?
}


//MARK: - WatchListInteractorInput
extension WatchListInteractor: WatchListInteractorInput {
    
    func fetchAssetDetails(by id: String,
                           completion: @escaping ((AssetResponse) -> ())) {
        
        NetworkManager.shared.fetchAsset(by: id) { [weak self] result in
            switch result {
            case .success(let response):
                completion(response)
            case .failure(let error):
                print(error)
                self?.presenter?.failureDidFetch(error)
            }
        }
    }
    
    func fetchFavoriteAssets(watchList: WatchList) {
        print(#function)
        
        watchList.load()
        
        let assetsIds = watchList.assetsIds
        
        DispatchQueue.global().async {
            let group = DispatchGroup()
            
            assetsIds.forEach { id in
                group.enter()
                
                self.fetchAssetDetails(by: id) { [weak self] result in
                    self?.assets.append(result.data)
                    group.leave()
                }
            }
            
            group.notify(queue: .main) {
                self.presenter?.assetsDidFetch(self.assets)
            }
        }
    }
}
