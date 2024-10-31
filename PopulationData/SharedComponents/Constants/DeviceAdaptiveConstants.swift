//
//  DeviceAdaptiveConstants.swift
//  PopulationData
//
//  Created by Muhammad Umair on 27/04/1446 AH.
//

import UIKit

class DeviceAdaptiveConstants {
    
    // MARK: - Adaptive Font Size
    static func fontSize(for fontSize: CGFloat, traitCollection: UITraitCollection) -> CGFloat {
        switch traitCollection.horizontalSizeClass {
        case .regular:
            return fontSize * 1.3
        default:
            return fontSize
        }
    }
    
    // MARK: - Adaptive Margin
    static func margin(for margin: CGFloat, traitCollection: UITraitCollection) -> CGFloat {
        switch traitCollection.horizontalSizeClass {
        case .regular:
            return margin * 1.2
        default:
            return margin
        }
    }
}
