//
//  CategoryService.swift
//  Lesson2
//
//  Created by Артур Шитиков on 26.01.26.
//

import Foundation
import CoreServices

// Протокол для сервиса категорий
protocol CategoryServiceProtocol {
    func getAllCategories() -> [String]
    func filterByCategory(_ entries: [ApiEntry], category: String) -> [ApiEntry]
}

// Реализация сервиса категорий
final class CategoryService: CategoryServiceProtocol {
    
    private let defaultCategories = [
        "all",
        "beauty",
        "fragrances",
        "furniture",
        "groceries"
    ]
    
    func getAllCategories() -> [String] {
        return defaultCategories
    }
    
    func filterByCategory(_ entries: [ApiEntry], category: String) -> [ApiEntry] {
        guard category != "all" else { return entries }
        return entries.filter { $0.category == category }
    }
}
