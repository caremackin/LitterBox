//  Homepage.swift
//  LitterBox
//
//  Created by Caroline Mackin on 4/20/24.
//
import SwiftUI
struct Homepage: View {
    var body: some View {
        ZStack{
            Color(red: 0.97, green: 0.85, blue: 0.80)
                .ignoresSafeArea()
            Circle()
                .scale(1.25)
                .foregroundColor(.white.opacity(0.15))
            VStack{
                Image("litterbox").resizable().frame(width: 300, height: 250)
                Spacer()
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                    
                    
                    NavigationLink(destination: Budget()) {
                        Image("budget")
                            .resizable()
                            .frame(width: 150, height: 150)
                            .cornerRadius(10)
                    }
                    .foregroundColor(.black)
                    
                    NavigationLink(destination: Transfers()) {
                        Image("transfers")
                            .resizable()
                            .frame(width: 150, height: 150)
                            .cornerRadius(10)
                    }
                    .foregroundColor(.black)
                    
                    NavigationLink(destination: Accounts()) {
                        Image("accounts")
                            .resizable()
                            .frame(width: 150, height: 150)
                            .cornerRadius(10)
                    }
                    .foregroundColor(.black)
                    
                    NavigationLink(destination: ShopView()) {
                        Image("shop")
                            .resizable()
                            .frame(width: 150, height: 150)
                            .cornerRadius(10)
                    }
                    .foregroundColor(.black)
                    
                }
                NavigationLink(destination: Room()) {
                    Image("room")
                        .resizable()
                        .frame(width: 300, height: 150)
                        .cornerRadius(10)
                }
                .foregroundColor(.black)
                
                Spacer()
                .padding()
            }
        }
        }
    }
#Preview {
    Homepage()
}

