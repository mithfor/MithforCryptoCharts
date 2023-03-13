//
//  AssetsRoute.swift
//  FlexibleRouting
//
//  Created by Dmitrii Voronin on 13.03.2023.
//

import UIKit

protocol AssetsRoute {
    func openAssets()
}

extension AssetsRoute where Self: Router {
    func openAssets() {
        let modal = ModalTransition()
        let router = DefaultRouter(rootTransition: modal)
        let viewModel = AssetsViewModel(router: router)
        let viewController = AssetsViewController(viewModel: viewModel)
        let navigationControler = UINavigationController(rootViewController: viewController)
        router.root = viewController
        
        route(to: navigationControler, as: modal)
    }
}

final class AssetsViewModel {
    typealias  Routes = AssetsRoute
    private let router: Routes
    
    init(router: Routes) {
        self.router = router
    }
    
    func assetsRouteCreated() {
        router.openAssets()
    }
}

extension DefaultRouter: AssetsRoute {}
