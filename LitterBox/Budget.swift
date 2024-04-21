//
//  Budget.swift
//  LitterBox
//
//  Created by Unnathi Konduru on 4/21/24.
//
import SwiftUI
import Charts
struct Budget: View {
    @State private var transaction: Transaction?
    @State private var transactions: [Transaction] = []
    @State private var isLoading = true
    @State private var error: Error?
    @State private var diningOutAmount: Int = 0
    @State private var groceriesAmount = 0
    @State private var schoolAmount = 0
    @State private var entertainmentAmount: Int = 0
    @State private var transportationAmount = 0
    @State private var billsAmount = 0
    
    var body: some View {
            ZStack {
                //makes background pink
                Color(red: 0.97, green: 0.85, blue: 0.80)
                    .ignoresSafeArea()
                
                //if it is loading then do the progress view
                if isLoading {
                    ProgressView()
                //if transactions is not empty
                } else if !transactions.isEmpty {
                    VStack(alignment: .center, spacing: 10){
                        Text("Budget").font(.largeTitle)
                        Spacer()
                    Chart {
                        ForEach(MockData.spendingStream) { stream in
                            SectorMark(angle: .value("Stream", stream.amount), angularInset: 2)
                        .foregroundStyle(by: .value("category", stream.category))
                        }
                    }.frame(maxWidth: 200, maxHeight: 200)
                        Spacer()
                        Text("Dining Out Spending: $\(diningOutAmount)")
                        Text("Grocery: $\(groceriesAmount)")
                        Text("Entertainment: $\(entertainmentAmount)")
                        Text("Education Amount: \(schoolAmount)")
                        Text("Transportation: $\(transportationAmount)")
                        Text("Bills & Recurring Payments: $\(billsAmount)")
                        Spacer(minLength: 150)
                    }
                } else if let error = error {
                    Text("Error: \(error.localizedDescription)")
                }
            }
            .onAppear {
                fetchData()
            }
        }
        
        func fetchData() {
            Task {
                do {
                    transactions = try await getTransactions()
                    for transaction in transactions {
                        if transaction.description == "coffee" {
                            diningOutAmount += transaction.amount
                        }
                        if transaction.description == "groceries" {
                            groceriesAmount += transaction.amount
                        }
                        if transaction.description == "school" {
                            schoolAmount += transaction.amount
                        }
                        if transaction.description == "entertainment" {
                            entertainmentAmount += transaction.amount
                        }
                        if transaction.description == "gas" {
                            entertainmentAmount += transaction.amount
                        }
                        if transaction.description == "bills" {
                            billsAmount += transaction.amount
                        }
                    }
                } catch {
                    self.error = error
                }
                isLoading = false
            }
        }
    
    func getTransactions() async throws -> [Transaction] {
        let endpoint = "http://api.nessieisreal.com/accounts/6623d4469683f20dd5189a09/purchases?key=993e31e6fe8fc18ae7f500f89a7e2507"
        guard let url = URL(string: endpoint) else {
            throw GHError.invalidURL
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode([Transaction].self, from: data)
        } catch {
            throw GHError.invalidData
        }
    }
    
    struct MockData {
        
        static var spendingStream: [SpendingStream] = [
            .init(category: "Dining Out", amount: 10 ),
            .init(category: "Groceries", amount: 108),
            .init(category: "Entertainment", amount: 92),
            .init(category: "Education", amount: 75),
            .init(category: "Transportation", amount: 0),
            .init(category: "Bills", amount: 300)
        ]
    }
    }
    struct Merchant: Codable {
        let _id: String
        let category: String
    }
        
    
    struct Budget_Previews: PreviewProvider {
        static var previews: some View {
            Budget()
        }
    }
    
    struct Transaction: Codable {
        let _id: String
        let amount: Int
        let merchantId: String
        let payeeId: String
        let description: String
    }
    
    enum GHError: Error {
        case invalidURL
        case invalidResponse
        case invalidData
    }
struct SpendingStream: Identifiable {
    let id = UUID()
    let category: String
    let amount: Double
}
//struct BudgetView_Previews: PreviewProvider {
//    static var previews: some View {
//        BudgetView()
//    }
//}
