//
//  Student.swift
//  1_FetchDataFromAPI
//
//  Created by Admin on 11/02/23.
//

import Foundation


// MARK: - Welcome5
struct Student{
    let page, perPage, total, totalPages: Int
    let data: [Datum]
    let support: Support
}

// MARK: - Datum
struct Datum{
    let id: Int
    let email, first_Name, last_Name: String
    let avatar: String
}

// MARK: - Support
struct Support{
    let url: String
    let text: String
}
