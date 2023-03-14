//
//  DefaultRouter.swift
//  FlexibleRouting
//
//  Created by Dmitrii Voronin on 13.03.2023.
//

import UIKit

protocol Router: Routable {
    var root: UIViewController? { get set }
}


// MARK: - DefaultRouter
class DefaultRouter: NSObject {
    
    var root: UIViewController?

    private let rootTransition: Transition
    
    init( rootTransition: Transition)  {
        self.rootTransition = rootTransition
    }
}

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
