//
//  DataProvider.swift
//  Lesson2
//
//  Created by Артур Шитиков on 26.01.26.
//

import Foundation

public protocol DataProvider {
    associatedtype Model
    
    func fetch() async throws -> [Model]
}

