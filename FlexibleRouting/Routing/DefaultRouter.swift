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

    let rootTransition: Transition
    
    init( rootTransition: Transition)  {
        self.rootTransition = rootTransition
    }
}

