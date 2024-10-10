//
//  CryptoAssetsPresenter.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 27.02.2023.
//

import Foundation

typealias CryptoAssetsPresenterInput = CryptoAssetsInteractorOutput
typealias CryptoAssetsPresenterOutput = CryptoAssetsViewControllerInput

final class CryptoAssetsPresenter {
    weak var viewController: CryptoAssetsPresenterOutput?
    var interactor: CryptoAssetsInteractorInput?
}

extension CryptoAssetsPresenter: CryptoAssetsPresenterInput {
    func fetched(assets: CryptoAssets) {
        viewController?.update(assets)
    }
    
    func fetchFailure(with error: NetworkError) {
        viewController?.updateFailed(with: error)
        
    }
}
