//
//  PopulationListCoordinator.swift
//  PopulationData
//
//  Created by Muhammad Umair on 27/04/1446 AH.
//

import Foundation
import UIKit
import Combine

class PopulationListCoordinator: PopulationListCoordinatorProtocol {

    let navigationController: UINavigationController
    private var cancellables = Set<AnyCancellable>()
    
    private let service: PopulationListServiceProtocol
    private lazy var viewModel: PopulationListViewModelProtocol = {
        PopulationListCoordinator.createViewModel(service: service, coordinator: self)
    }()

    init(navigationController: UINavigationController, service: PopulationListServiceProtocol) {
        self.navigationController = navigationController
        self.service = service
    }

    func start() {
        let tableViewHandler = createTableViewHandler(viewModel: viewModel)
        let populationListViewController = createPopulationListViewController(viewModel: viewModel, tableViewHandler: tableViewHandler)
        
        navigationController.viewControllers = [populationListViewController]
    }

    private static func createViewModel(service: PopulationListServiceProtocol, coordinator: PopulationListCoordinatorProtocol) -> PopulationListViewModelProtocol {
        return PopulationListViewModel(service: service)
    }

    private func createTableViewHandler(viewModel: PopulationListViewModelProtocol) -> PopulationTableViewHandler {
        return PopulationTableViewHandler(
            didSelectItem: { selectedItem in
                self.showPopup(for: selectedItem) 
            },
            viewModel: viewModel
        )
    }

    private func createPopulationListViewController(viewModel: PopulationListViewModelProtocol, tableViewHandler: PopulationTableViewHandler) -> PopulationListVC {
        return PopulationListVC(
            viewModel: viewModel,
            tableViewHandler: tableViewHandler
        )
    }
    
    
    // MARK: - Helper to Display Popup with Data
    private func showPopup(for item: Any) {
        let alertController = UIAlertController(title: "Details", message: "", preferredStyle: .alert)
        
        if let state = item as? StateModel {
            alertController.message = "State: \(state.stateName)\nYear: \(state.year)\nPopulation: \(state.population)"
        } else if let nation = item as? NationModel {
            alertController.message = "Nation: \(nation.nationName)\nYear: \(nation.year)\nPopulation: \(nation.population)"
        }
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        navigationController.present(alertController, animated: true, completion: nil)
    }
}
