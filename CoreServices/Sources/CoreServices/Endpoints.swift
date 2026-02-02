//
//  Endpoints.swift
//  CoreServices
//
//  Created by Артур Шитиков on 28.01.26.
//

import Foundation

public enum Endpoints {
    public static let baseURL = "https://dummyjson.com"
    
    public static func products(category: String, limit: Int, skip: Int) -> URL? {
        // Если категория "all", грузим всё, иначе фильтруем
        let path = category == "all" ? "/products" : "/products/category/\(category)"
        
        // Добавляем параметры пагинации
        return URL(string: "\(baseURL)\(path)?limit=\(limit)&skip=\(skip)")
    }
}
