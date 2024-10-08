//
//  IconManager.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 27.02.2023.
//

import UIKit

typealias  AssetIconResponseHandler = (Result<IconAsset, NetworkError>) -> Void

protocol IconManagable {
    func fetchIconFor(_ asset: CryptoAsset, completed: @escaping AssetIconResponseHandler)
}

class IconManager: IconManagable {
    
    static let shared = IconManager()
    
    private static let baseURL: String = "https://coinicons-api.vercel.app/api/icon/"
    
    private init() {}
    
    func fetchIconFor(_ asset: CryptoAsset, completed: @escaping AssetIconResponseHandler) {
        
        var assetIcon = IconAsset()
        let urlString = "\(IconManager.baseURL)\(String(describing: asset.symbol?.lowercased()))"
        
        guard let url = URL(string: urlString) else {
            completed(.failure(.endpoint))
            return
        }
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard error == nil else {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completed(.failure(.invalidResponse))
                return
            }
            
            if response.statusCode == 404 {
                completed(.failure(.endpoint))
                return
            }
            
            if let data = try? Data(contentsOf: url) {
                assetIcon = IconAsset(image: (UIImage(data: data) ?? UIImage(systemName: "house")) ?? UIImage())
                completed(.success(assetIcon))
                return
            }
        }
        
        dataTask.resume()
    }
}

struct IconAsset {
    var image = UIImage()
}
