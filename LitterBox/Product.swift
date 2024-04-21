//
//  Product.swift
//  LitterBox
//
//  Created by Unnathi Konduru on 4/21/24.
//

import Foundation
struct Product: Identifiable{
    var id = UUID()
    var name : String
    var image : String
    var price : Int
    }
var productList = [Product(name: "Red Beanie", image: "redbeanie", price: 20),
                   Product(name: "Cowboy Hat", image: "cowboyhat", price: 20),
                   Product(name: "Chef Hat", image: "chefhat", price: 20),
                   Product(name: "Bucket Hat", image: "buckethat", price: 20)]
