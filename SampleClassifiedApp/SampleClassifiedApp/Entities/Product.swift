//
//  Product.swift
//  SampleClassifiedApp
//
//  Created by irfan on 04/12/2020.
//

import Foundation

struct ProductResponse: Codable {
    let list: [Product]
    
    enum CodingKeys: String, CodingKey {
        case list = "results"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        list = try container.decodeIfPresent([Product].self, forKey: CodingKeys.list) ?? []
    }
}

class Product: NSObject, Codable {
    @objc let name: String
    @objc let price: String // should be double in real world and view model could append AED/USD with the price
    @objc let dateCreated: String
    @objc let imageUrl: [String]
    @objc let thumbnailUrls: [String]
    
    enum CodingKeys: String, CodingKey {
        case name, price
        case dateCreated = "created_at"
        case imageUrl = "image_urls"
        case thumbnailUrls = "image_urls_thumbnails"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decodeIfPresent(String.self, forKey: CodingKeys.name) ?? ""
        price = try container.decodeIfPresent(String.self, forKey: CodingKeys.price) ?? ""
        dateCreated = try (container.decodeIfPresent(String.self, forKey: CodingKeys.dateCreated) ?? "").components(separatedBy: " ").first ?? ""
        imageUrl = try container.decodeIfPresent([String].self, forKey: CodingKeys.imageUrl) ?? []
        thumbnailUrls = try container.decodeIfPresent([String].self, forKey: CodingKeys.thumbnailUrls) ?? []
    }
    
    init(name: String, price: String, dateCreated: String, imageUrls: [String], thumnailUrls: [String]) {
        self.name = name
        self.price = price
        self.dateCreated = dateCreated
        self.imageUrl = imageUrls
        self.thumbnailUrls = thumnailUrls
    }
    
    static var date: Date {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "dd-MMM-yy hh.mm.ss.nnnnnnnnn a"
        
        if let date = dateFormatterGet.date(from: "22-Mar-99 05.06.07.000000888 AM") {
            return date
        } else {
           return Date()
        }
    }
}
