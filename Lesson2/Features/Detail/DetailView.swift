//
//  DetailView.swift
//  Lesson2
//
//  Created by Артур Шитиков on 15.01.26.
//

import SwiftUI
import CoreServices
import SwiftUI

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var coordinator: AppCoordinator
    @EnvironmentObject var dataStore: DataStore

    var body: some View {
        VStack(spacing: 20) {
            
            if let entry = dataStore.selectedEntry {
                Text(entry.title)
                    .font(.largeTitle)

                Text(entry.description)

                Text("Цена: \(entry.price) $") 
                    .font(.title2)
                    .padding()
                
                Button("Инфо (JSON Data)") {
                    coordinator.push(.info)
                }
                .buttonStyle(.borderedProminent)
            } else {
                Text("Ничего не выбрано")
            }
            
            Spacer()
            
            Button("Назад") {
                coordinator.pop()
            }
            .padding(.bottom)
        }
    }
}
