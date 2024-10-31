//
//  PopulationListViewControllerProtocol.swift
//  PopulationData
//
//  Created by Muhammad Umair on 27/04/1446 AH.
//

import Foundation
import UIKit

protocol PopulationListViewControllerProtocol: BaseViewControllerProtocol {

    func displayStatePopulation(_ states: [StateModel])

    func displayNationPopulation(_ nations: [NationModel])

    func showError(_ message: String)
}
