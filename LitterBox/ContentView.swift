//
//  ContentView.swift
//  LitterBox
//
//  Created by Caroline Mackin on 4/20/24.
//
import SwiftUI
struct ContentView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var showingLoginScreen = false
    var body: some View {
        NavigationView{
            ZStack {
                Color(red: 0.97, green: 0.85, blue: 0.80)
                    .ignoresSafeArea()
                Circle()
                    .scale(1.25)
                    .foregroundColor(.white.opacity(0.15))
            VStack (spacing:20) {
                Image("litterbox").resizable().frame(width:175, height: 150)
                    .font(.headline)
                    .bold()
                    .padding()
                TextField("Username", text: $username)
                    .padding()
                    .frame(width: 200, height:50)
                    .background(Color.pink.opacity(0.05))
                    .cornerRadius(5)
                    .border(.red, width:
                                CGFloat(wrongUsername))
                SecureField("Password", text: $password)
                    .padding()
                    .frame(width: 200, height:50)
                    .background(Color.pink.opacity(0.05))
                    .cornerRadius(5)
                    .border(.red, width:CGFloat (wrongPassword))
                VStack{
                        if (showingLoginScreen){
                            NavigationLink(destination:Homepage()){
                                Text("Login")
                            }
                        } else{
                            Button("Login"){
                                authenticateUser(username: username, password: password)
                                }
                        }
                }
//                Button("Login"){
//                    authenticateUser(username: username, password: password)
//                    }
                .foregroundColor(.white.opacity(1))
                .frame(width:100, height: 30)
                .cornerRadius(5)
                    }
                }
            }
            
        }
    func authenticateUser(username: String, password: String){
            if username.lowercased() == "turnipmackin"{
                wrongUsername = 0
                if password.lowercased() == "litterbox"{
                    wrongPassword = 0
                    showingLoginScreen = true
                } else {
                    wrongPassword = 1
                }
            } else {
                    wrongUsername = 1
                }
            }
    }
#Preview {
    ContentView()

