//  Room.swift
//  LitterBox
//
//  Created by Caroline Mackin on 4/21/24.
//
import SwiftUI
struct Room: View {
    @State private var selectedImage: String = "TurnipsRoom" // Initial image
    @State private var vStackImage: String = "TurnipsRoom" // Initial image for VStack
    
    var body: some View {
        
        VStack {
            Spacer()
            
            Image(vStackImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: .infinity, height: .infinity) // Reduced size for the VStack image
            
            HStack {
                
                    Image("redbeanie")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50) // Reduced size for the button image
                        .padding()
                        .cornerRadius(15)
                        .onTapGesture {
                            self.vStackImage = "beanieturnip" // Change VStack image
                        }
                        .frame(width: 50, height: 50) // Increased size for the button
                
                Image("cowboyhat")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50) // Reduced size for the button image
                    .padding()
                    .cornerRadius(15)
                    .onTapGesture {
                        self.vStackImage = "cowboyturnip" // Change VStack image
                    }
                    .frame(width: 50, height: 50) // Increased size for the button
                
                Image("chefhat")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50) // Reduced size for the button image
                    .padding()
                    .cornerRadius(15)
                    .onTapGesture {
                        self.vStackImage = "chefturnip" // Change VStack image
                    }
                    .frame(width: 50, height: 50) // Increased size for the button
                
                Image("buckethat")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50) // Reduced size for the button image
                    .padding()
                    .cornerRadius(15)
                    .onTapGesture {
                        self.vStackImage = "buckethatturnip" // Change VStack image
                    }
                    .frame(width: 50, height: 50) // Increased size for the button
            }
            
            Spacer()
                .frame(maxHeight: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .onAppear {
//            NSApp.mainWindow?.title = "Room"
        }
    }
}
struct Room_Previews: PreviewProvider {
    static var previews: some View {
        Room()
    }
}

