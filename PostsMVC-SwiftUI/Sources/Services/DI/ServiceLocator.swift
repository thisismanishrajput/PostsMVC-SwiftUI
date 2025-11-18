//
//  ServiceLocator.swift
//  PostsMVC-SwiftUI
//
//  Created by Manish Singh on 18/11/25.
//

import Foundation

/// Simple service locator for quick DI in demo apps.
/// For production, prefer constructor injection & protocol-based wiring in a composition root.
final class ServiceLocator {
    static let shared = ServiceLocator()
    private var services: [String: Any] = [:]
    private init() {}

    func register<T>(service: T) {
        let key = "\(T.self)"
        services[key] = service
    }

    func resolve<T>() -> T? {
        let key = "\(T.self)"
        return services[key] as? T
    }
}

