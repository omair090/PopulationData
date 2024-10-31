//
//  MockPopulationListCoordinator.swift
//  PopulationData
//
//  Created by Muhammad Umair on 28/04/1446 AH.
//

import Foundation
@testable import PopulationData

class MockPopulationListCoordinator: PopulationListCoordinatorProtocol {
    var navigationCalled = false
    var selectedItem: Any?

    func start() {
        
    }
    
    func didSelect(item: Any) {
        navigationCalled = true
        selectedItem = item
    }
}
