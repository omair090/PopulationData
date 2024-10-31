//
//  MockPopulationService.swift
//  PopulationData
//
//  Created by Muhammad Umair on 28/04/1446 AH.
//
import Foundation
import Combine
@testable import PopulationData

class MockPopulationService: PopulationListServiceProtocol {
    var shouldReturnError = false
    var mockStateData: [StateDataModel] = []
    var mockNationData: [NationDataModel] = []

    init() {
        self.mockStateData = [
            StateDataModel(id: "1", state: "Mock State 1", year: 2023, population: 500000, slugState: "mock-state-1"),
            StateDataModel(id: "2", state: "Mock State 2", year: 2023, population: 1000000, slugState: "mock-state-2")
        ]
        
        self.mockNationData = [
            NationDataModel(id: "1", nation: "Mock Nation 1", year: 2023, population: 1000000, slugNation: "mock-nation-1"),
            NationDataModel(id: "2", nation: "Mock Nation 2", year: 2023, population: 2000000, slugNation: "mock-nation-2")
        ]
    }

    func fetchPopulationData(request: PopulationRequest) -> AnyPublisher<[Any], Error> {
        if shouldReturnError {
            return Fail(error: NetworkError.decodingFailed("Failed to load mock data"))
                .eraseToAnyPublisher()
        }

       
        if request.regionType == .state {
            return Just(mockStateData)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            return Just(mockNationData)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
}
