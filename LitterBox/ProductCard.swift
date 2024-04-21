//
//  ProductCard.swift
//  LitterBox
//
//  Created by Caroline Mackin on 4/20/24.
//
import SwiftUI
struct ProductCard: View {
    var product:Product
    
    var body: some View {
        ZStack(alignment: .topTrailing){
            ZStack(alignment: .bottom){
                Image(product.image)
                    .resizable()
                    .cornerRadius(20)
                    .frame(width:150, height: 150, alignment:.topLeading)
                    .scaledToFit()
                
                Button {
                    //will chnage to actual action later
                    print("you have this item")
                }label:{
                    Image(systemName: "plus")
                        .padding(10)
                        .foregroundColor(.white)
                        .background(.black)
                        .cornerRadius(50)
                        .padding()
                }
            }
        }
    }
    struct ProductCard_Previews: PreviewProvider {
        static var previews: some View {
            ProductCard(product: productList[0])
        }
    }
    
}

