//
//  AllProduct.swift
//  1_FetchDataFromAPI
//
//  Created by Admin on 11/02/23.
//

import Foundation


// MARK: - Welcome1
struct AllProduct {
    let products: [Product]
    let total, skip, limit: Int
}

// MARK: - Product
struct Product {
    let id: Int
    let title, productDescription: String
    let price: Int
    let discountPercentage, rating: Double
    let stock: Int
    let brand, category: String
    let thumbnail: String
    let images: [String]
}
struct Productt{
    let id: Int
    let title:String
    let price: Int
    let rating: Double
    let brand, category: String
    let thumbnail: String
    let images: [String]
    let discountPercentage:Float
}
