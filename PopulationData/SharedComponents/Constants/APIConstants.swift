//
//  APIConstants.swift
//  PopulationData
//
//  Created by Muhammad Umair on 27/04/1446 AH.
//

import Foundation

struct APIConstants {
    struct BaseURL {
        static let production = "https://datausa.io/api"
    }
    
    struct Endpoints {
        static let statePopulation = "/data?drilldowns=State&measures=Population&year=latest"
        static let nationPopulation = "/data?drilldowns=Nation&measures=Population"
    }
    
    struct HTTPMethods {
        static let get = "GET"
        static let post = "POST"
    }
    
    struct Headers {
        static let contentType = "Content-Type"
        static let contentTypeJSON = "application/json"
    }
    
    static func getURL(for endpoint: String, page: Int?) -> URL? {
        var urlComponents = URLComponents(string: "\(BaseURL.production)\(endpoint)")
        
        if let page = page {
            urlComponents?.queryItems?.append(URLQueryItem(name: "page", value: "\(page)"))
        }
        
        return urlComponents?.url
    }
}
