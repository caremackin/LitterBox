//  Shop.swift
//  LitterBox
//
//  Created by Caroline Mackin on 4/20/24.
//
import SwiftUI
public class SharedViewModel: ObservableObject {
    @Published var purchasedItems: [String] = []
  /*  @State */public var purchasedBeanie: Bool = false
    public init() {} // Optional: If you have an initializer, make it public as well
}
struct ShopView: View {
//    @State public var purchasedBeanie: Bool = false
    var columns = [GridItem(.adaptive(minimum: 160), spacing: 20)]
    @State var points = 80 // Assuming this is your points variable
    @StateObject var viewModel = SharedViewModel()
    @State public var selectedImage: String?
    func buyProduct(_ product: Product) {
        viewModel.purchasedItems.append(product.name)
        selectedImage = product.image
        if product.name == "Red Beanie"{
            viewModel.purchasedBeanie = true
        }
        
    }
    var body: some View {
        NavigationView {
            VStack {
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(width: 300, height: 30)
                        .foregroundColor(Color.white) // Background color of the bar
                    
                    Rectangle()
                        .frame(width: 300 * CGFloat(points) / 100, height: 30) // Progress bar
                        .foregroundColor(.pink.opacity(0.3))
                }
                .cornerRadius(15)
                .padding()
                
                Text("Points: \(Int(points))")
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 15) {
                        ForEach(productList) { product in
                            FinalProductCard(product: product, points: $points, selectedImage: $selectedImage, buyAction: {
                                buyProduct(product)
                            })
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle(Text("Shop"))
        }
    }
}
struct FinalProductCard: View {
    var product: Product
    @Binding var points: Int
    @Binding var selectedImage: String?
    var buyAction: () -> Void // Action for buying the product
    var body: some View {
        VStack {
            Image(product.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
            Text(product.name)
            Button(action: {
                buyAction()
                // Deduct points when the product is bought
                if points >= product.price {
                    points -= product.price
                }
            }) {
                Text("Buy (\(product.name) for \(product.price) points)")
            }
            .padding()
        }
    }
}
struct ShopContentView_Previews: PreviewProvider {
    static var previews: some View {
        ShopView()
    }
}
           

