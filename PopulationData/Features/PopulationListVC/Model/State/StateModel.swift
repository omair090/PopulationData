//
//  stateModel.swift
//  PopulationData
//
//  Created by Muhammad Umair on 27/04/1446 AH.
//

import Foundation

struct StateModel: Equatable{
    let id: String
    let stateName: String
    let year: String
    let population: Int
    let slug: String
    
    init(from responseModel: StateDataModel) {
        
        self.id = responseModel.id
        self.stateName = responseModel.state.isEmpty ? "Unknown State" : responseModel.state
        self.year = String(responseModel.year)
        self.population = responseModel.population
        self.slug = responseModel.slugState.isEmpty ? "unknown State" : responseModel.slugState
    }

    
    func toPopulationDataModel() -> StateDataModel {
        return StateDataModel(
            id: self.id,
            state: self.stateName,
            year: Int(self.year) ?? 0,
            population: self.population,
            slugState: self.slug
        )
    }
}
