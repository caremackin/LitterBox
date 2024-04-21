//  Accounts.swift
//  LitterBox
//
//  Created by Caroline Mackin on 4/20/24.
//
import SwiftUI
struct Accounts: View {
    var body: some View {
        ZStack{
            Color(red: 0.97, green: 0.85, blue: 0.80)
                .ignoresSafeArea()
            Circle()
                .scale(1.25)
                .foregroundColor(.white.opacity(0.15))
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                    NavigationLink(destination: SavingsView()) {
                        Image("savings")
                            .resizable()
                            .frame(width: 150, height: 150)
                            .cornerRadius(10)
                    }
                    .foregroundColor(.black)
                    
                    
                    NavigationLink(destination: Checking()) {
                        Image("checking")
                            .resizable()
                            .frame(width: 150, height: 150)
                            .cornerRadius(10)
                    }
                    .foregroundColor(.black)
                    
                }
                .padding()
            }
        }
}
#Preview {
    Accounts()
}

