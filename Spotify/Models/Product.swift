//
//  Product.swift
//  Spotify
//
//  Created by chris on 2024/12/18.
//

import Foundation

struct ProductArray: Codable {
    let products: [Product]
    let total, skip, limit: Int
}

struct Product: Codable, Identifiable {
    let id: Int
    let title, description: String
    let price: Double // Double not Int
    let discountPercentage, rating: Double
    let stock: Int
    let brand: String? // <- Optional
    let category: String
    let thumbnail: String
    let images: [String]
    
    var firstImage: String {
        images.first ?? Constants.randomImage
    }
    
    var _brand: String {
        brand ?? ""
    }
    
    static var mock: Product {
        Product(
            id: 123,
            title: "Product Title From Mock",
            description: "Product Description From Mock",
            price: 100,
            discountPercentage: 0.0,
            rating: 4.5,
            stock: 0,
            brand: "Apple",
            category: "Phone",
            thumbnail: Constants.randomImage,
            images: [
                Constants.randomImage,
                Constants.randomImage,
                Constants.randomImage,
                Constants.randomImage
            ]
        )
    }
    
}

struct ProductRow: Identifiable {
    
    let id: String = UUID().uuidString
    let title: String
    let products: [Product]
    
}
