//
//  SavingsView.swift
//  LitterBox
//
//  Created by Caroline Mackin on 4/21/24.
//
import SwiftUI
struct SavingsView: View {
    @State private var account: SavingsAccount?
    @State private var isLoading = true
    @State private var error: Error?
    @State private var funds = 0
    @State private var money = ""
    @State var progressValue: Float = 0.0
    
    var body: some View {
        ZStack{
            Color(red: 0.97, green: 0.85, blue: 0.80)
                .ignoresSafeArea()
            Circle()
                .scale(1.25)
                .foregroundColor(.white.opacity(0.15))
            
            VStack {
                
                Text("Savings")
                    .font(.largeTitle)
                
                Spacer()
                
                Text("Set Saving Goals")
                Rectangle()
                    .frame(width: 220, height: 50, alignment:.center)
                    .foregroundColor(.white.opacity(0.5))   .cornerRadius(20)
                    .overlay(
                        TextField("Goal to save?", text: $money)
                    )
                
                Button("Enter"){
                    progress()
                }
                    .padding()
                Rectangle()
                
                    .frame(width: 220, height: 100, alignment:.center)
                    .foregroundColor(.white.opacity(0.5))   .cornerRadius(20)
                    .overlay(
                        Text("Savings: \(funds)")
                            .font(.title)
                    )
                    .padding()
                   
                ProgressBar(progress: self.$progressValue)
                    .frame(width: 160.0, height: 160.0)
                    .padding(20.0).onAppear(){
                        progressValue = 0.0
                    }
                
                Spacer(minLength: 95)
            }
        } .onAppear {
            fetchData()
        }
    }
    
    func progress(){
        if let intValue = Int(money) {
          progressValue = progressValue + (Float(funds)/Float(intValue))
        }
        if (progressValue > 1.0){
            progressValue -= 1.0
        }
    }
    
    
    func fetchData() {
        Task {
            do {
                account = try await getSavings()
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
    
    func getSavings() async throws -> SavingsAccount {
       let endpoint = "http://api.nessieisreal.com/accounts/6623cf869683f20dd5189a06?key=993e31e6fe8fc18ae7f500f89a7e2507"
       guard let url = URL(string: endpoint) else {
           throw GHError.invalidURL
       }
       
       do {
           let (data, _) = try await URLSession.shared.data(from: url)
           let decoder = JSONDecoder()
           decoder.keyDecodingStrategy = .convertFromSnakeCase
           return try decoder.decode(SavingsAccount.self, from: data)
       } catch {
           throw GHError.invalidData
       }
   }
    
}
struct SavingsAccount: Codable, Hashable {
    let nickname: String
    let balance: Int
}
#Preview {
    SavingsView()
}
