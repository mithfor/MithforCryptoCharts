//
//  Routable.swift
//  MithforCryptoCharts
//
//  Created by Dmitrii Voronin on 13.03.2023.
//

import UIKit

protocol Routable: AnyObject {
    func route(to viewController: UIViewController, as transition: Transition)
}

protocol Closable: AnyObject {
    func close()
}

protocol Dismissable: AnyObject {
    func dismiss()
}
