//
//  APIService.swift
//  Lesson2
//
//  Created by Артур Шитиков on 22.01.26.
//

import Foundation


public protocol APIServiceProtocol {
    func fetchEntries(category: String, limit: Int, skip: Int) async throws -> [ApiEntry]
}


public enum APIError: Error {
    case invalidURL
    case invalidResponse
    case decodingError(Error)
}

final class APIService: APIServiceProtocol {
    
    static let shared = APIService()
    
    private init() {}
    
    func fetchEntries(category: String, limit: Int, skip: Int) async throws -> [ApiEntry] {
        
        // Формируем URL с параметрами
        guard let url = Endpoints.products(category: category, limit: limit, skip: skip) else {
            throw APIError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw APIError.invalidResponse
        }
        
        do {
            let result = try JSONDecoder().decode(ApiResponse.self, from: data)
            return result.products
        } catch {
            print("Ошибка парсинга: \(error)")
            throw APIError.decodingError(error)
        }
    }
}

