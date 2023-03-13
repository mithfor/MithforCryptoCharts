//
//  Routable.swift
//  FlexibleRouting
//
//  Created by Dmitrii Voronin on 13.03.2023.
//

import UIKit

protocol Closable: AnyObject {
    func close()
}

protocol Dismissable: AnyObject {
    func dismiss()
}

protocol Routable: AnyObject {
    func route(to viewController: UIViewController, as transition: Transition)
}
