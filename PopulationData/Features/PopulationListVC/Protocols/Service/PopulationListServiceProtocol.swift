//
//  PopulationListServiceProtocol.swift
//  PopulationData
//
//  Created by Muhammad Umair on 27/04/1446 AH.
//

import Foundation
import Combine

protocol PopulationListServiceProtocol {
    
    func fetchPopulationData(request: PopulationRequest) -> AnyPublisher<[Any], Error>
}
