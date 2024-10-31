//
//  imgPlaceHolder.swift
//  PopulationData
//
//  Created by Muhammad Umair on 27/04/1446 AH.
//

import Foundation
import UIKit
enum PlaceholderImage {
    case `default`
    case custom(UIImage)
    
    var image: UIImage {
        switch self {
        case .default:
            return UIImage(named: AppConstants.Placeholders.placeholderImage) ?? UIImage()
        case .custom(let image):
            return image
        }
    }
}
