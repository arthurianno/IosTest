//
//  FavoriteService.swift
//  Lesson2
//
//  Created by Артур Шитиков on 26.01.26.
//

import Foundation
import CoreServices

// Протокол для сервиса избранного
protocol FavoriteServiceProtocol {
    func addToFavorites(_ entry: ApiEntry)
    func removeFromFavorites(_ entryId: Int)
    func isFavorite(_ entryId: Int) -> Bool
    func getFavorites() -> [ApiEntry]
    func clearFavorites()
}

// Реализация сервиса избранного
final class FavoriteService: FavoriteServiceProtocol {
    private var favorites: [ApiEntry] = []
    
    func addToFavorites(_ entry: ApiEntry) {
        // Проверяем, что элемент еще не в избранном
        guard !isFavorite(entry.id) else { return }
        favorites.append(entry)
    }
    
    func removeFromFavorites(_ entryId: Int) {
        favorites.removeAll { $0.id == entryId }
    }
    
    func isFavorite(_ entryId: Int) -> Bool {
        return favorites.contains { $0.id == entryId }
    }
    
    func getFavorites() -> [ApiEntry] {
        return favorites
    }
    
    func clearFavorites() {
        favorites.removeAll()
    }
}

// MARK: - Расширение DataStore для работы с избранным

extension DataStore {
    
    // Можно добавить в DataStore:
    /*
    private let favoriteService: FavoriteServiceProtocol
    @Published var favoriteItems: [ApiEntry] = []
    
    func addToFavorites(_ entry: ApiEntry) {
        favoriteService.addToFavorites(entry)
        favoriteItems = favoriteService.getFavorites()
    }
    
    func removeFromFavorites(_ entryId: Int) {
        favoriteService.removeFromFavorites(entryId)
        favoriteItems = favoriteService.getFavorites()
    }
    
    func isFavorite(_ entryId: Int) -> Bool {
        return favoriteService.isFavorite(entryId)
    }
    */
}
