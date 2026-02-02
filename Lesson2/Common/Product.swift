//
//  Product.swift
//  Lesson2
//
//  Created by Артур Шитиков on 26.01.26.
//

import Foundation

struct Product: Identifiable, Hashable {
    let id: Int
    let title: String
    let description: String
    let category: String
    let price: Double
}
