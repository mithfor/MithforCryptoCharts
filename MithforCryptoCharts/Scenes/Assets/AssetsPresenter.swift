//
//  AssetsPresenter.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 27.02.2023.
//

import Foundation

typealias AssetsPresenterInput = AssetsInteractorOutput
typealias AssetsPresenterOutput = AssetsViewControllerInput

final class AssetsPresenter {
    weak var viewController: AssetsPresenterOutput?
}

extension AssetsPresenter: AssetsPresenterInput {
    func fetched(assets: Assets, with assetModel: AssetModel) {
        viewController?.update(assets, with: assetModel)
    }
    
    func failureDidFetch(_ error: NetworkError) {
        viewController?.updateFailed(with: error)
    }
}
