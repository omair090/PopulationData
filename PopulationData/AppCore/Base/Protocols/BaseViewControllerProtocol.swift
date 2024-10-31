//
//  BaseViewControllerProtocol.swift
//  PopulationData
//
//  Created by Muhammad Umair on 27/04/1446 AH.
//

import Foundation
import UIKit

protocol BaseViewControllerProtocol: AnyObject {
    
    // MARK: - Setup Methods
    
    func setupUI()
    func setupBindings()

}
