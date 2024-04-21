//
//  Transfers.swift
//  LitterBox
//
//  Created by Caroline Mackin on 4/21/24.
//
import SwiftUI
enum TransferFromType {
    case Checking
    case Savings
}
enum TransferToType {
    case Savings
    case Checking
}
struct Transfers: View {
    @State private var transferfrom: TransferFromType = .Checking
    @State private var transferto: TransferToType = .Savings
    @State private var amount: Float = 0.0
    var body: some View {
        Spacer()
        VStack {
            Color(red: 0.97, green: 0.85, blue: 0.80)
                .ignoresSafeArea()
            
            Text("Transfers").font(.largeTitle)
            Spacer()
            Form {
                Picker("Transfer From:", selection: $transferfrom) {
                    Text("Checking").tag(TransferFromType.Checking)
                    Text("Savings").tag(TransferFromType.Savings)
                }
                TextField("Amount", value: $amount, formatter: NumberFormatter())
                
                Picker("Transfer To:", selection: $transferto) {
                    Text("Savings").tag(TransferToType.Savings)
                    Text("Checking").tag(TransferToType.Checking)
                }
                
                Button("Transfer") {
                    if transferfrom == .Checking {
                        if transferto == .Savings{
                            transferToSavings(amountToTransfer: Int(amount))
                        }
                    }
                    
                    if transferfrom == .Savings {
                        if transferto == .Checking {
                            transferToChecking(amountToTransfer: Int(amount))
                        }
                    }
                }
            }.frame(width: 300, height: 270)
            
            .padding()
            .background(Color(red: 0.97, green: 0.85, blue: 0.80))
            .cornerRadius(50)
            .padding()
            Spacer(minLength: 250)
        }
        .background(Color(red: 0.97, green: 0.85, blue: 0.80))
        .edgesIgnoringSafeArea(.all)
    }
    
    func transferToSavings(amountToTransfer: Int) {
        guard let url = URL(string:"http://api.nessieisreal.com/accounts/6623d4469683f20dd5189a09/transfers?key=993e31e6fe8fc18ae7f500f89a7e2507" ) else {
            return
        }
        
        var request = URLRequest(url: url)
        // Method, body, headers
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: AnyHashable] = [
            "medium": "balance",
            "payee_id": "6623cf869683f20dd5189a06",
            "transaction_date": "2024-04-21",
            "amount": amount,
            "status": "pending",
            "description": "string"
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        // Make request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                if let error = error {
                    print("Error: \(error)")
                }
                return
            }
            
            do {
                let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print(response)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    
    func transferToChecking(amountToTransfer: Int) {
        guard let url = URL(string:"http://api.nessieisreal.com/accounts/6623cf869683f20dd5189a06/transfers?key=993e31e6fe8fc18ae7f500f89a7e2507" ) else {
            return
        }
        
        var request = URLRequest(url: url)
        // Method, body, headers
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: AnyHashable] = [
            "medium": "balance",
            "payee_id": "6623d4469683f20dd5189a09",
            "transaction_date": "2024-04-21",
            "amount": amount,
            "status": "pending",
            "description": "string"
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        // Make request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                if let error = error {
                    print("Error: \(error)")
                }
                return
            }
            
            do {
                let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print(response)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
    
    struct Transfers_Previews: PreviewProvider {
        static var previews: some View {
            Transfers()
        }
}

