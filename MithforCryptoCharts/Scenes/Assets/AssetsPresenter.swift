//
//  AssetsPresenter.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 27.02.2023.
//

import Foundation

typealias AssetsPresenterInput = AssetsInteractorOutput
typealias AssetsPresenterOutput = AssetsViewControllerInput

final class AssetsPresenter: AssetsViewControllerOutput {
    func fetchAssets() {
        interactor?.fetchAssets()
    }
    
    func fetchImage(for asset: Asset, completion: @escaping (() -> Void)) {
        interactor?.fetchImage(for: asset, completion: {
            
        })
    }
    
    weak var viewController: AssetsPresenterOutput?
    var interactor: AssetsInteractorInput?
}

extension AssetsPresenter: AssetsPresenterInput {
    func fetched(assets: Assets, with assetModel: AssetModel) {
        viewController?.update(assets, with: assetModel)
    }
    
    func fetchFailure(with error: NetworkError) {
        viewController?.updateFailed(with: error)
    }
}
