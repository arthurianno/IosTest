//
//  DTO.swift
//  Lesson2
//
//  Created by Артур Шитиков on 22.01.26.
//

import Foundation

struct ApiResponse: Decodable {
    let products: [ApiEntry] 
}

struct ApiEntry: Decodable, Identifiable, Hashable {
    let id: Int
    let title: String
    let description: String
    let category: String
    let price: Double
}
