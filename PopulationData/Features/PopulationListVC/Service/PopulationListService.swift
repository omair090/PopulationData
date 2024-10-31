//
//  PopulationService.swift
//  PopulationData
//
//  Created by Muhammad Umair on 27/04/1446 AH.
//


import Foundation
import Combine

class PopulationListService: PopulationListServiceProtocol {
    
    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }

    func fetchPopulationData(request: PopulationRequest) -> AnyPublisher<[Any], Error> {
        guard let urlRequest = request.asURLRequest() else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        switch request.regionType {
        case .state:
            return networkService.fetch(StateResponse.self, from: urlRequest)
                .map { $0.data as [Any] }
                .mapError { $0 as Error }
                .eraseToAnyPublisher()
            
        case .nation:
            return networkService.fetch(NationResponse.self, from: urlRequest)
                .map { $0.data as [Any] }
                .mapError { $0 as Error }
                .eraseToAnyPublisher()
        }
    }
}
