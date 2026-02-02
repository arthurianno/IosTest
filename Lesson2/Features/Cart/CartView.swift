//
//  CartView.swift
//  Lesson2
//
//  Created by Артур Шитиков on 15.01.26.
//

import SwiftUI
import CoreServices
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
            
            if dataStore.cartItem.isEmpty {
                Spacer()
                Text("В корзине пусто 🛒")
                    .foregroundColor(.gray)
                Spacer()
            } else {
                List {
                    ForEach(Array(dataStore.cartItem.enumerated()), id: \.element.id) { index, item in
                        HStack {
                            Text(item.product.title)
                            Spacer()
                            Text("\(Int(item.product.price)) $")
                        }
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { index in
                            dataStore.removeFromCart(at: index)
                        }
                    }
                    
                    // Итоговая сумма
                    HStack {
                        Text("Итого:")
                            .font(.headline)
                        Spacer()
                        Text("\(Int(dataStore.getCartTotal())) $")
                            .font(.headline)
                            .foregroundColor(.green)
                    }
                    .padding(.vertical, 8)
                }
            
            }
            
            Button("Назад") {
                coordinator.pop()
            }
            .padding()
        }
    }
}
