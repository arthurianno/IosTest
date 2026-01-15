//
//  InfoView.swift
//  Lesson2
//
//  Created by Артур Шитиков on 22.01.26.
//

// InfoView.swift
import SwiftUI

struct InfoView: View {
    @EnvironmentObject var coordinator: AppCoordinator
    @EnvironmentObject var dataStore: DataStore

    var body: some View {
        VStack(spacing: 16) {
            
            
            if let item = dataStore.selectedEntry {
                
                Text("Информация")
                    .font(.title2)
                    .bold()

                VStack(alignment: .leading, spacing: 8) {
                    
                    
                    Text(item.title)
                        .font(.headline)

                    Text(item.description)

                    Text("Категория: \(item.category)")
                }
                .padding()
                
            } else {
                Text("Ошибка: Данные не найдены")
            }

            Spacer()

            Button("Назад") {
                coordinator.pop()
            }
            .padding(.bottom)
        }
        .padding()
        .background(Color(.systemBackground))
    }
}
