//
//  AssetDetailPresenter.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 03.03.2023.
//

import Foundation

typealias  AssetDetailsPresenterInput = AssetDetailsInteractorOutput
typealias AssetDetailsPresenterOutput = AssetDetailsViewControllerInput

final class AssetDetailsPresenter {
    weak var viewController: AssetDetailsPresenterOutput?
}

extension AssetDetailsPresenter: AssetDetailsPresenterInput {
    func fetchFailure(error: NetworkError) {
        viewController?.updateFailed(with: error)
    }
    
    func historyFetched(assetHistory: [AssetHistory]) {
        viewController?.updateHistory(with: assetHistory)
    }
}
