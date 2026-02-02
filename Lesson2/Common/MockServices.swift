//
//  MockServices.swift
//  Lesson2
//
//  Created by Артур Шитиков on 26.01.26.
//

import Foundation
import CoreServices

// MARK: - Mock API Service для тестирования

final class MockAPIService: APIServiceProtocol {
    var shouldFail = false
    var mockData: [ApiEntry] = []
    
    func fetchEntries(category: String, limit: Int, skip: Int) async throws -> [ApiEntry] {
        if shouldFail {
            throw APIError.invalidResponse
        }
        
        // Возвращаем mock данные
        return mockData
    }
}

// MARK: - Mock Product Service

final class MockProductService: ProductServiceProtocol {
    var mockProducts: [Product] = []
    
    func fetchProducts(category: String, limit: Int, skip: Int) async throws -> [Product] {
        return mockProducts
    }
    
    func fetchAllProducts() async throws -> [Product] {
        return mockProducts
    }
}

// MARK: - Mock Cart Service

final class MockCartService: CartServiceProtocol {
    var cartItems: [CartItem] = []
    
    func addToCart(_ entry: ApiEntry) {
        let item = CartItem(product: entry)
        cartItems.append(item)
    }
    
    func removeFromCart(at index: Int) {
        guard index >= 0 && index < cartItems.count else { return }
        cartItems.remove(at: index)
    }
    
    func clearCart() {
        cartItems.removeAll()
    }
    
    func getCartItems() -> [CartItem] {
        return cartItems
    }
    
    func getCartTotal() -> Double {
        return cartItems.reduce(0) { $0 + $1.product.price }
    }
}

// MARK: - Mock Category Service

final class MockCategoryService: CategoryServiceProtocol {
    var mockCategories: [String] = ["all", "test1", "test2"]
    
    func getAllCategories() -> [String] {
        return mockCategories
    }
    
    func filterByCategory(_ entries: [ApiEntry], category: String) -> [ApiEntry] {
        guard category != "all" else { return entries }
        return entries.filter { $0.category == category }
    }
}

// MARK: - Примеры использования

/*
 
 ПРИМЕРЫ ИСПОЛЬЗОВАНИЯ MOCK-СЕРВИСОВ В ТЕСТАХ:
 
 func testDataStoreWithMockServices() {
     // Создаем mock-сервисы
     let mockAPI = MockAPIService()
     mockAPI.mockData = [
         ApiEntry(id: 1, title: "Test Product", description: "Test", category: "test", price: 99.99)
     ]
     
     let mockCart = MockCartService()
     let mockProduct = MockProductService()
     let mockCategory = MockCategoryService()
     
     // Инициализируем DataStore с mock-сервисами
     let dataStore = DataStore(
         apiService: mockAPI,
         productService: mockProduct,
         cartService: mockCart,
         categoryService: mockCategory
     )
     
     // Тестируем функционал
     dataStore.addToCart(mockAPI.mockData[0])
     assert(mockCart.cartItems.count == 1)
 }
 
 func testAPIServiceFailure() {
     let mockAPI = MockAPIService()
     mockAPI.shouldFail = true
     
     // Проверяем, что сервис правильно обрабатывает ошибки
     Task {
         do {
             _ = try await mockAPI.fetchEntries(category: "all", limit: 10, skip: 0)
             assert(false, "Should throw error")
         } catch {
             assert(true, "Error handled correctly")
         }
     }
 }
 
 */
