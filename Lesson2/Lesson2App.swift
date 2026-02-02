//
//  Lesson2App.swift
//  Lesson2
//
//  Created by Артур Шитиков on 15.01.26.
//

import SwiftUI
import CoreServices

@main
struct Lesson2App: App {
    
    init() {
        registerServices()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    func registerServices() {
        // Регистрация сервисов и провайдеров данных
        let container = ServiceLocator.shared
        container.register(CartService() as CartServiceProtocol)
        container.register(CategoryService() as CategoryServiceProtocol)
        container.register(ProductService() as ProductServiceProtocol)
        container.register(FavoriteService() as FavoriteServiceProtocol)
        container.register(APIService.shared as APIServiceProtocol)
        
    }
}
