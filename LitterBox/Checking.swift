//  Checking.swift
//  LitterBox
//
//  Created by Caroline Mackin on 4/21/24.
//
import SwiftUI
struct Checking: View {
    @State private var account: CheckingAccount?
    @State private var isLoading = true
    @State private var error: Error?
    @State private var funds = 0
    var body: some View {
        ZStack{
            Color(red: 0.97, green: 0.85, blue: 0.80)
                .ignoresSafeArea()
            Circle()
                .scale(1.25)
                .foregroundColor(.white.opacity(0.15))
            
            VStack {
                Text("Checking")
                    .font(.largeTitle)
                
                Spacer()
                Rectangle()
                    .frame(width: 220, height: 100, alignment:.center)
                    .foregroundColor(.white.opacity(0.5))   .cornerRadius(20)
                    .overlay(
                        Text("Checking: $\(funds)")
                            .font(.title)
                    )
                    .padding()
                
                Spacer(minLength: 270)
            }
        } .onAppear {
            fetchData()
        }
    }
    func fetchData() {
        Task {
            do {
                account = try await getChecking()
                if let balance = account?.balance {
                    funds = balance
                } else {
                    funds = 0
                }
            } catch {
                self.error = error
            }
            isLoading = false
        }
    }
    
    func getChecking() async throws -> CheckingAccount {
       let endpoint = "http://api.nessieisreal.com/accounts/6623d4469683f20dd5189a09?key=993e31e6fe8fc18ae7f500f89a7e2507"
       guard let url = URL(string: endpoint) else {
           throw GHError.invalidURL
       }
       
       do {
           let (data, _) = try await URLSession.shared.data(from: url)
           let decoder = JSONDecoder()
           decoder.keyDecodingStrategy = .convertFromSnakeCase
           return try decoder.decode(CheckingAccount.self, from: data)
       } catch {
           throw GHError.invalidData
       }
   }
    
}
struct CheckingAccount: Codable, Hashable {
    let nickname: String
    let balance: Int
}
#Preview {
    Checking()
}

