//
//  DTO.swift
//  CoreServices
//
//  Created by Артур Шитиков on 28.01.26.
//

import Foundation

public struct ApiResponse: Decodable {
    public let products: [ApiEntry]
    
    public init(products: [ApiEntry]) {
        self.products = products
    }
}

public struct ApiEntry: Decodable, Identifiable, Hashable, Sendable {
    public let id: Int
    public let title: String
    public let description: String
    public let category: String
    public let price: Double
    
    public init(id: Int, title: String, description: String, category: String, price: Double) {
        self.id = id
        self.title = title
        self.description = description
        self.category = category
        self.price = price
    }
}
