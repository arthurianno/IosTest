//
//  DataStore.swift
//  Lesson2
//
//  Created by Артур Шитиков on 22.01.26.
//

import Foundation
import SwiftUI
internal import Combine
import CoreServices


@MainActor
final class DataStore: ObservableObject {
    
    @Published var entries: [ApiEntry] = []
    @Published var selectedEntry: ApiEntry?
    @Published var cartItem: [CartItem] = []
    
    private var searchTask: Task<Void, Never>?
    
    // Сервисы через протоколы
    @Inject private var apiService: APIServiceProtocol
    @Inject private var cartService: CartServiceProtocol
    @Inject private var categoryService: CategoryServiceProtocol
    @Inject private var productService: ProductServiceProtocol

    
    // Рубрики
    @Published var currentCategory: String = "all" {
        didSet {
            if oldValue != currentCategory {
                resetAndLoad()
            }
        }
    }
    
    // Пейджинг
    private var skip = 0
    private let limit = 10
    private var canLoadMore = true
    @Published var isLoading = false
    
    
  
    
    func resetAndLoad() {
        
        searchTask?.cancel()
        
        
        entries = []
        canLoadMore = true
        isLoading = true
        skip = 0
        
        
        searchTask = Task {
            do {
                
                try await Task.sleep(nanoseconds: 500_000_000)
                
                
                if Task.isCancelled { return }
                
                let newEntries = try await apiService.fetchEntries(category: currentCategory, limit: limit, skip: skip)
                
                if Task.isCancelled { return }
                
                if newEntries.count < limit {
                    canLoadMore = false
                }
                
              
                let uniqueEntries = newEntries.filter { newEntry in
                    !self.entries.contains(where: { $0.id == newEntry.id })
                }
                
                self.entries.append(contentsOf: uniqueEntries)
                self.skip += limit
                self.isLoading = false
                
            } catch {
              
                if error is CancellationError || (error as? URLError)?.code == .cancelled {
                    return
                }
                
                print("Ошибка загрузки: \(error)")
                self.isLoading = false
            }
        }
    }
    
    func fetchData() {
        
        guard !isLoading && canLoadMore else { return }
        
        isLoading = true
        
        searchTask = Task {
            do {
                if Task.isCancelled { return }
                
                let newEntries = try await apiService.fetchEntries(category: currentCategory, limit: limit, skip: skip)
                
                if Task.isCancelled { return }
                
                if newEntries.count < limit {
                    canLoadMore = false
                }
                
                let uniqueEntries = newEntries.filter { newEntry in
                    !self.entries.contains(where: { $0.id == newEntry.id })
                }
                
                self.entries.append(contentsOf: uniqueEntries)
                self.skip += limit
                self.isLoading = false
                
            } catch {
                if (error as? URLError)?.code == .cancelled { return }
                print("Ошибка: \(error)")
                self.isLoading = false
            }
        }
    }
    
    // MARK: - Cart Management через сервис
    
    func addToCart(_ entry: ApiEntry) {
        cartService.addToCart(entry)
        cartItem = cartService.getCartItems()
    }
    
    func removeFromCart(at index: Int) {
        cartService.removeFromCart(at: index)
        cartItem = cartService.getCartItems()
    }
    
    func clearCart() {
        cartService.clearCart()
        cartItem = []
    }
    
    func getCartTotal() -> Double {
        return cartService.getCartTotal()
    }
    
    // MARK: - Category Management через сервис
    
    func getAllCategories() -> [String] {
        return categoryService.getAllCategories()
    }
}

// Обертка для товара в корзине, чтобы ID всегда был уникальным
struct CartItem: Identifiable {
    let id = UUID()
    let product: ApiEntry
}

