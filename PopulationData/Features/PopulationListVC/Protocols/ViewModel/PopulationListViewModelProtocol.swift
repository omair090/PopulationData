//
//  PopulationListViewModelProtocol.swift
//  PopulationData
//
//  Created by Muhammad Umair on 27/04/1446 AH.
//

import Foundation
import Combine

protocol PopulationListViewModelProtocol {
    
    var stateData: AnyPublisher<[StateModel], Never> { get }
    var nationData: AnyPublisher<[NationModel], Never> { get }
    
    var isFetching: Bool { get }
    
    func fetchInitialStateData()
    func fetchInitialNationData()
    func fetchMoreStateData() -> AnyPublisher<Void, Error>
    func fetchMoreNationData() -> AnyPublisher<Void, Error>
}
