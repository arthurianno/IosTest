//
//  Endpoints.swift
//  Lesson2
//
//  Created by Артур Шитиков on 22.01.26.
//

import Foundation

enum Endpoints {
    static let baseURL = "https://dummyjson.com"
    
    
    static func products(category: String, limit: Int, skip: Int) -> URL? {
        // Если категория "all", грузим всё, иначе фильтруем
        let path = category == "all" ? "/products" : "/products/category/\(category)"
        
        // Добавляем параметры пагинации
        return URL(string: "\(baseURL)\(path)?limit=\(limit)&skip=\(skip)")
    }
}
