//
//  Cart.swift
//  Lesson2
//
//  Created by Артур Шитиков on 22.01.26.
//

import Foundation
import SwiftUI

struct CartView: View {
    @EnvironmentObject var coordinator: AppCoordinator
    @EnvironmentObject var dataStore: DataStore

    var body: some View {
        VStack {
            Text("Корзина")
                .font(.largeTitle)
                .bold()
                .padding()
            
            if dataStore.cartItems.isEmpty {
                Spacer()
                Text("В корзине пусто 🛒")
                    .foregroundColor(.gray)
                Spacer()
            } else {
                List() {
                    ForEach(dataStore.cartItems) { item in
                        HStack {
                            Text(item.product.title)
                            Spacer()
                            Text("\(Int(item.product.price)) $")
                        }
                    }
                    .onDelete{dataStore.cartItems.remove(atOffsets: $0)}
                }
            
            }
            
            Button("Назад") {
                coordinator.pop()
            }
            .padding()
        }
    }
}
