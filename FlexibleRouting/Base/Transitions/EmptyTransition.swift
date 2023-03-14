//
//  EmptyTransition.swift
//  FlexibleRouting
//
//  Created by Dmitrii Voronin on 14.03.2023.
//

import UIKit

final class EmptyTransition {
    var isAnimated: Bool = true
}

// MARK: - Transition
extension EmptyTransition: Transition {
    func open(_ viewConroller: UIViewController, from: UIViewController) {}
    
    func close(_ viewController: UIViewController) {}
    
    
}
