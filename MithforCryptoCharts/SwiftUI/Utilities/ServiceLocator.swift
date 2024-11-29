//
//  ServiceLocator.swift
//  MithforCryptoCharts
//
//  Created by Dmitriy Voronin on 29.11.2024.
//

import Foundation

protocol ServiceLocating {
    func resolve<T>() -> T?
}

final class ServiceLocator: ServiceLocating {

    static let shared = ServiceLocator()

    private lazy var services = [String: Any]()

    //MARK: - Init

    private init() {}

    // MARK: - Private funcs

    private func typeName(_ some: Any) -> String {
        return (some is Any.Type)
        ? ("\(some)")
        : "\(type(of: some))"
    }

    // MARK: - Internal funcs

    func register<T>(service: T) {
        let key  = typeName(T.self)
        services[key] = service
    }

    func resolve<T>() -> T? {
        let key = typeName(T.self)
        return services[key] as? T
    }
}
