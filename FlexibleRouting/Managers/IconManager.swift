//
//  IconManager.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 27.02.2023.
//

import UIKit

typealias  AssetIconResponseHandler = (Result<AssetIcon, NetworkError>) -> Void

protocol IconManagable {
    func fetchIconFor(_ asset: Asset, completed: @escaping AssetIconResponseHandler)
}

class IconManager: IconManagable {
    
    
    
    static let shared = IconManager()
    
    private static let baseURL: String = "https://coinicons-api.vercel.app/api/icon/"
    
    private init() {}
    
    func fetchIconFor(_ asset: Asset, completed: @escaping AssetIconResponseHandler)  {
        
        var assetIcon = AssetIcon()
        let urlString = "\(IconManager.baseURL)\(asset.symbol?.lowercased() ?? "usd")"
        
        guard let url = URL(string: urlString) else {
            completed(.failure(.endpoint))
            return
        }
            let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                if let _ = error {
                    completed(.failure(.unableToComplete))
                    return
                }

                guard let response = response as? HTTPURLResponse,
                      response.statusCode == 200 else {
                    completed(.failure(.invalidResponse))
                    return
                }
                
                if let data = try? Data(contentsOf: url) {
                    assetIcon = AssetIcon(image: (UIImage(data: data) ?? UIImage(systemName: "house")) ?? UIImage())
                    completed(.success(assetIcon))
                    return
                }
            }
            
            dataTask.resume()
        
        //        completed(AssetIcon(image: UIImage(systemName: "house") ?? UIImage()))
    }
}

//struct AssetIconResponse

struct AssetIcon {
    var image = UIImage()
}


