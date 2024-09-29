//
//  Transition.swift
//  MithforCryptoCharts
//
//  Created by Dmitrii Voronin on 13.03.2023.
//

import UIKit

protocol Transition: AnyObject {
    var isAnimated: Bool { get set }
    
    func open(_ viewConroller: UIViewController, from: UIViewController)
    func close(_ viewController: UIViewController)
}

protocol AnimatedTransition: UIViewControllerAnimatedTransitioning {
    var isPresenting: Bool { get set }
}
