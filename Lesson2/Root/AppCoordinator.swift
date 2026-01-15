//
//  AppCoordinator.swift
//  Lesson2
//
//  Created by Артур Шитиков on 22.01.26.
//

import Foundation
internal import Combine

// AppCoordinator.swift
final class AppCoordinator: ObservableObject {
    @Published var stack: [AppScreen] = [.list]
    
    var current: AppScreen {
        stack.last ?? .list
    }
    
    func push(_ screen: AppScreen) {
        guard stack.count < 3 else { return }
        stack.append(screen)
    }

    func pop() {
        guard stack.count > 1 else { return }
        stack.removeLast()
    }
}

enum AppScreen: Equatable {
    case list
    case detail
    case info
    case cart
}

