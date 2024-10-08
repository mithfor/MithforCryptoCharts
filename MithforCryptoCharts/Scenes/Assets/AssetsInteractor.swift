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
    
    func fetchImage(for asset: CryptoAsset, completion: @escaping (() -> Void)) {
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
                    self?.presenter?.fetchFailure(with: error)
                }
            }
        }
    }
    
    func createRapidAPIRequest() -> URLRequest  {
        let headers = [
            "x-rapidapi-key": "da9fd01c7fmsh9f07e9d134e499ep1a2039jsn96450aead57f",
            "x-rapidapi-host": "open-source-icons-search.p.rapidapi.com"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://open-source-icons-search.p.rapidapi.com/vectors/search?query=bitcoin")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        print(request.description)
        
        return request as URLRequest
    }
    
    func fetchCryptoAssets() {
        DispatchQueue.global().async {
            
            let request = CryptoAssetsRequest()
            if let networkService = self.networkService {
                networkService.request(request, completion: { [weak self] (result) in
                    switch result {
                    case .success(let response):
                        self?.assets = response
                        self?.presenter?.fetched(assets: self?.assets ?? [])
                        //                        self?.fetchImagesFor(self?.assets ?? CryptoAssets())
                    case .failure(let error):
                        self?.presenter?.fetchFailure(with: error)
                    }
                })
            }
        }
        
//        let session = URLSession.shared
//        let dataTask = session.dataTask(with: createRapidAPIRequest() as URLRequest, completionHandler: { (data, response, error) -> Void in
//            if (error != nil) {
//                print(error as Any)
//            } else {
//                let httpResponse = response as? HTTPURLResponse
//                print(httpResponse)
//                
//            }
//            
//            if let jsonData = data {
//                
//                do {
//                    let foundedIcon = try JSONDecoder().decode(FoundedIcon.self, from: jsonData)
//                } catch let error as NSError {
//                    print(error.description)
//                }
//                
//            }
//        })
//
//        dataTask.resume()
    }
    
    func fetchCryptoAssetsAsync() async throws {
        let request = CryptoAssetsRequest()
        let result = try await networkService?.request(request,
                                                       completion: { [weak self] (result) in
            switch result {
            case .success(let response):
                self?.assets = response
                self?.presenter?.fetched(assets: self?.assets ?? [])
//                try? fetchImagesFor(self?.assets ?? CryptoAssets())
            case .failure(let error):
                self?.presenter?.fetchFailure(with: error)
            }
        })
    }

    func fetchImagesFor(_ assets: CryptoAssets) {
        
        let queue = DispatchQueue(label: "FetchingImagesForCryptoAssetsQueue",
                                  qos: .default, 
                                  attributes: .concurrent)
        queue.async {
            let group = DispatchGroup()
            assets.forEach({ asset in
                group.enter()
                
                self.fetchImage(for: asset) {
                    group.leave()
                }
            })
            
            group.notify(queue: .main) {
                self.presenter?.fetched(assets: assets)
            }
        }
    }
}
