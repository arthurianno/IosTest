//
//  ServiceLocator.swift
//  Lesson2
//
//  Created by Артур Шитиков on 28.01.26.
//

import Foundation

final class ServiceLocator {
    static let shared = ServiceLocator()
    private var services: [String: Any] = [:]
    
    func register <T>(_ service: T) {
        let key = String(describing: T.self)
        services[key] = service
    }
    
    func get <T> () -> T {
        let key = String(describing: T.self)
        guard let service = services[key] as? T else {
            fatalError("Service of type \(T.self) not registered.")
        }
        return service
    }
}

@propertyWrapper
struct Inject<T> {
    private var service: T
    
    init() {
        self.service = ServiceLocator.shared.get()
    }
    
    var wrappedValue: T {
        get {
            service
        }
        mutating set {
            service = newValue
        }
    }
}

