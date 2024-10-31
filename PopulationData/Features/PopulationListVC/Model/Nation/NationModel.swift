//
//  NationModel.swift
//  PopulationData
//
//  Created by Muhammad Umair on 27/04/1446 AH.
//

import Foundation

struct NationModel: Equatable {
    let id: String
    let nationName: String
    let year: String
    let population: Int
    let slug: String

    // MARK: - Initializer

    init(from responseModel: NationDataModel) {
        self.id = responseModel.id
        self.nationName = responseModel.nation.isEmpty ? "Unknown Nation" : responseModel.nation
        self.year = "\(responseModel.year)"
        self.population = responseModel.population
        self.slug = responseModel.slugNation.isEmpty ? "unknown-nation" : responseModel.slugNation
    }
    
    // MARK: - Convenience Methods
    
    func toNationDataModel() -> NationDataModel {
        return NationDataModel(
            id: self.id,
            nation: self.nationName,
            year: Int(self.year) ?? 0,
            population: self.population,
            slugNation: self.slug
        )
    }
}
