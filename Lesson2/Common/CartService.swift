//
//  CartService.swift
//  Lesson2
//
//  Created by Артур Шитиков on 26.01.26.
//

import Foundation
import CoreServices

// Протокол для сервиса корзины
protocol CartServiceProtocol {
    func addToCart(_ entry: ApiEntry)
    func removeFromCart(at index: Int)
    func clearCart()
    func getCartItems() -> [CartItem]
    func getCartTotal() -> Double
}

// Реализация сервиса корзины
final class CartService: CartServiceProtocol {
    private var cartItems: [CartItem] = []
    
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
