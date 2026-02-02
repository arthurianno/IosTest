//
//  ProductService.swift
//  Lesson2
//
//  Created by Артур Шитиков on 26.01.26.
//

import Foundation
import CoreServices

// Протокол для сервиса продуктов
protocol ProductServiceProtocol {
    func fetchProducts(category: String, limit: Int, skip: Int) async throws -> [Product]
    func fetchAllProducts() async throws -> [Product]
}

// Реализация сервиса продуктов
final class ProductService: ProductServiceProtocol {
    private let apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol = APIService.shared) {
        self.apiService = apiService
    }
    
    func fetchProducts(category: String, limit: Int, skip: Int) async throws -> [Product] {
        let apiEntries = try await apiService.fetchEntries(category: category, limit: limit, skip: skip)
        return apiEntries.map { mapToProduct($0) }
    }
    
    func fetchAllProducts() async throws -> [Product] {
        let apiEntries = try await apiService.fetchEntries(category: "all", limit: 100, skip: 0)
        return apiEntries.map { mapToProduct($0) }
    }
    
    // Маппинг из ApiEntry в Product
    private func mapToProduct(_ entry: ApiEntry) -> Product {
        Product(
            id: entry.id,
            title: entry.title,
            description: entry.description,
            category: entry.category,
            price: entry.price
        )
    }
}
