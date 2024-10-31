//
//  NationResponse.swift
//  PopulationData
//
//  Created by Muhammad Umair on 27/04/1446 AH.
//

import Foundation

public struct NationResponse: Decodable {
    public let data: [NationDataModel]
}

public struct NationDataModel: Decodable, Identifiable {
    public let id: String
    public let nation: String
    public let year: Int
    public let population: Int
    public let slugNation: String
    
    // MARK: - CodingKeys for JSON Mapping
    enum CodingKeys: String, CodingKey {
        case id = "ID Nation"
        case nation = "Nation"
        case year = "ID Year"
        case population = "Population"
        case slugNation = "Slug Nation"
    }
}


