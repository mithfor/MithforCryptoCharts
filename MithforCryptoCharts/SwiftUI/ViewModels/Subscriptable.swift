//
//  Subscriptable.swift
//  MithforCryptoCharts
//
//  Created by Dmitriy Voronin on 04.12.2024.
//

import Foundation
import Combine

protocol Subscriptable: AnyObject {

    func addSubscribers()
}
