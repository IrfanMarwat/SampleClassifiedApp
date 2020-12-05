//
//  Constants.swift
//  SampleClassifiedApp
//
//  Created by irfan on 04/12/2020.
//

import Foundation

enum Environment {
    case staging, production
    
    var baseURL: String {
        switch self {
        case .staging: return "https://ey3f2y0nre.execute-api.us-east-1.amazonaws.com/"
        case .production: return "https://ey3f2y0nre.execute-api.us-east-1.amazonaws.com/"
        }
    }
}

struct Constants {
    
    static let environment = Environment.staging

    struct API_KEYS {
        static let Name = "name"
        static let Price = "price"
        static let CreationDate = "created_at"
        static let ImageUrls = "image_urls"
        static let ThumnailUrls = "image_urls_thumbnails"
    }

    struct API_ENDPOINTS {
        static let ProductListAPI = "default/dynamodb-writer"
    }
}

