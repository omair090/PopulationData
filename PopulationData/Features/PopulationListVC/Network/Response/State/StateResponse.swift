//
//  StateResponse.swift
//  PopulationData
//
//  Created by Muhammad Umair on 27/04/1446 AH.
//

import Foundation

public struct StateResponse: Decodable {
    public let data: [StateDataModel]
}

public struct StateDataModel: Decodable, Identifiable {
    public let id: String
    public let state: String
    public let year: Int
    public let population: Int
    public let slugState: String
    
    // MARK: - CodingKeys for JSON Mapping
    enum CodingKeys: String, CodingKey {
        case id = "ID State"
        case state = "State"
        case year = "ID Year"
        case population = "Population"
        case slugState = "Slug State"
    }
}

