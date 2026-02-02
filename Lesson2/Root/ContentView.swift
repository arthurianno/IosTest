//
//  ContentView.swift
//  Lesson2
//
//  Created by Артур Шитиков on 15.01.26.
//

import SwiftUI
import CoreServices

struct ContentView: View {
    @StateObject private var coordinator = AppCoordinator()
    @StateObject private var dataStore = DataStore()
    
    // Переменные анимации
    @State private var flyingIconPosition: CGPoint = .zero // Где летит
    @State private var cartPosition: CGPoint = .zero       // Где кнопка корзины (КУДА лететь)
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
         
            ZStack {
                switch coordinator.current {
                case .list:
                    ListView { startPoint, entry in
                        runAnimation(from: startPoint, item: entry)
                    }
                case .detail:
                    DetailView()
                case .info:
                    InfoView()
                case .cart:
                    CartView()
                }
            }
            
           
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    // Сама кнопка
                    Button {
                        coordinator.push(.cart)
                    } label: {
                        ZStack {
                            Circle()
                                .fill(Color.black)
                                .frame(width: 60, height: 60)
                            
                            Image(systemName: "cart.fill")
                                .foregroundColor(.white)
                                .font(.title2)
                            
                            // Счетчик товаров
                            if !dataStore.cartItem.isEmpty {
                                Text("\(dataStore.cartItem.count)")
                                    .font(.caption2)
                                    .bold()
                                    .foregroundColor(.white)
                                    .padding(5)
                                    .background(Color.red)
                                    .clipShape(Circle())
                                    .offset(x: 15, y: -15)
                            }
                        }
                    }
                    .padding()
                    .background(
                        GeometryReader { geo in
                            Color.clear.onAppear {
                                let frame = geo.frame(in: .global)
                                self.cartPosition = CGPoint(x: frame.midX, y: frame.midY)
                            }
                        }
                    )
                }
            }
            
           
            if isAnimating {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 30, height: 30)
                    .position(flyingIconPosition)
                    .ignoresSafeArea()
            }
        }
        .environmentObject(coordinator)
        .environmentObject(dataStore)
    }

        func runAnimation(from startPoint: CGPoint, item: ApiEntry) {
            flyingIconPosition = startPoint
            isAnimating = true
            
            withAnimation(.easeInOut(duration: 0.8)) {
                flyingIconPosition = cartPosition
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                isAnimating = false
                
                // Используем метод сервиса для добавления в корзину
                dataStore.addToCart(item)
                
            }
        }
    }

