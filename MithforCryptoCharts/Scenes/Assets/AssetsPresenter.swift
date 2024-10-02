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
    var interactor: AssetsInteractorInput?
}

extension AssetsPresenter: AssetsPresenterInput {
    func fetched(assets: Assets) {
        viewController?.update(assets)
    }
    
    func fetchFailure(with error: NetworkError) {
        viewController?.updateFailed(with: error)
        
    }
}
