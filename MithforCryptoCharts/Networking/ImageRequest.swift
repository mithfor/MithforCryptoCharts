//
//  ImageRequest.swift
//  MithforCryptoCharts
//
//  Created by Dmitrii Voronin on 17.03.2023.
//

import UIKit

struct ImageRequest: DataRequest {
    
    let url: String
    
    var method: HTTPMethod {
        .get
    }
    
    func decode(_ data: Data) throws -> UIImage {
        guard let image = UIImage(data: data) else {
            throw NSError(domain: NetworkError.invalidResponse.rawValue,
                          code: 13,
                          userInfo: nil
            )
        }
        
        return image
    }
    
}
