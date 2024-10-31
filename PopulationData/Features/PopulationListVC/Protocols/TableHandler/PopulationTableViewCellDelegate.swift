//
//  PopulationTableViewCellDelegate.swift
//  PopulationData
//
//  Created by Muhammad Umair on 27/04/1446 AH.
//

import Foundation
import UIKit

protocol PopulationTableViewCellDelegate: AnyObject {
    func didTapDetailButton(for region: Any)  
}
