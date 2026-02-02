//
//  ListView.swift
//  Lesson2
//
//  Created by Артур Шитиков on 15.01.26.
//

import SwiftUI
import CoreServices
import SwiftUI

struct ListView: View {
    @EnvironmentObject var coordinator: AppCoordinator
    @EnvironmentObject var dataStore: DataStore
    
    // Передаем координаты и товар для анимации
    var onAddToCart: ((CGPoint, ApiEntry) -> Void)?
    
    let categories = ["all": "Все", "smartphones": "Телефоны", "laptops": "Ноутбуки", "fragrances": "Духи"]
    var categoryKeys: [String] { ["all", "smartphones", "laptops", "fragrances"] }

    var body: some View {
        VStack {
            // Пикер
            Picker("Категория", selection: $dataStore.currentCategory) {
                ForEach(categoryKeys, id: \.self) { key in
                    Text(categories[key] ?? key).tag(key)
                }
            }
            .pickerStyle(.segmented)
            .padding()

            // Проверка на пустоту (чтобы не было просто белого экрана)
            if dataStore.entries.isEmpty && dataStore.isLoading {
                Spacer()
                ProgressView("Загрузка товаров...")
                Spacer()
            } else {
                List {
                    ForEach(dataStore.entries) { entry in
                        HStack {
                           
                            VStack(alignment: .leading) {
                                Text(entry.title).font(.headline)
                                Text("\(Int(entry.price)) $").foregroundColor(.green)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                dataStore.selectedEntry = entry
                                coordinator.push(.detail)
                            }
                            
                            // 2. ПРАВАЯ ЧАСТЬ - КНОПКА "В КОРЗИНУ"
                            Image(systemName: "plus.circle.fill")
                                .font(.title2)
                                .foregroundColor(.blue)
                                .padding(10) // Увеличиваем область нажатия пальцем
                                .overlay(
                                    GeometryReader { geo in
                                        Color.clear
                                            .contentShape(Rectangle()) // Обязательно, чтобы ловить нажатия на прозрачном
                                            .onTapGesture {
                                                let frame = geo.frame(in: .global)
                                                let center = CGPoint(x: frame.midX, y: frame.midY)
                                                
                                                // Запускаем анимацию
                                                onAddToCart?(center, entry)
                                            }
                                    }
                                )
                        }
                        .padding(.vertical, 4)
                        .buttonStyle(PlainButtonStyle()) // Убирает стандартное выделение ячейки
                        .onAppear {
                            // Пейджинг
                            if entry == dataStore.entries.last {
                                dataStore.fetchData()
                            }
                        }
                    }
                }
                .listStyle(.plain)
            }
        }
        
        .onAppear {
            if dataStore.entries.isEmpty {
                dataStore.fetchData()
            }
        }
    }
}
