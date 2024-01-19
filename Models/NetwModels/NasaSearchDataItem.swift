//
//  SearchResultModel.swift
//  NasaAppTest
//
//  Created by Никита Попов on 18.12.23.
//

import Foundation


struct NasaSearchDataItem: Codable {
    let collection: Collection
}

struct Collection: Codable {
    let href: String
    let items: [Item]
}
struct Item: Codable {
    let href: String
    let data: [Datum]
    let links: [ItemLink]
}
struct Datum: Codable {
    let dateCreated: String
    let description: String?


    enum CodingKeys: String, CodingKey {
        case dateCreated = "date_created"
        case description
    }
}
struct ItemLink: Codable {
    let href: String
}
