//
//  DefaultRouter + ext.swift
//  MithforCryptoCharts
//
//  Created by Dmitrii Voronin on 26.09.2024.
//

import UIKit

//MARK: - Routable
extension DefaultRouter: Router {
    func route(to viewController: UIViewController, as transition: Transition) {
        guard let root = root else {
            return
        }
        transition.open(viewController, from: root)
    }
}

//MARK: - Closable
extension DefaultRouter: Closable {
    func close() {
        guard let root = root else {
            return
        }
        
        rootTransition.close(root)
    }
}

//MARK: - Dismissable
extension DefaultRouter: Dismissable {
    func dismiss() {
        root?.dismiss(animated: rootTransition.isAnimated)
    }
}
