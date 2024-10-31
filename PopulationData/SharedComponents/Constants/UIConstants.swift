//
//  UIConstants.swift
//  PopulationData
//
//  Created by Muhammad Umair on 27/04/1446 AH.
//

import Foundation
import UIKit

struct UIConstants {
    
    // MARK: - PopulationTableViewCell Constants

    struct PopulationTableViewCell {
        static let identifier = "PopulationTableViewCell"
        
        // Background and Shadow
        static let cardCornerRadius: CGFloat = 12.0
        static let shadowOpacity: Float = 0.1
        static let shadowRadius: CGFloat = 3
        static let shadowOffset = CGSize(width: 0, height: 2)
        static let cardBackgroundColor = UIColor.white
        static let stateBackgroundColor = UIColor.white
        static let nationBackgroundColor = UIColor.white

        // ImageView
        static let regionImageWidth: CGFloat = 30
        static let regionImageHeight: CGFloat = 30

        // Font Sizes
        static let titleFontSize: CGFloat = 20
        static let subtitleFontSize: CGFloat = 16
        
        // Button
        static let detailButtonCornerRadius: CGFloat = 10
        static let detailButtonTitle = "Details"
        static let detailButtonBackgroundColor = UIColor(hex: "#016396")
        static let detailButtonTitleColor = UIColor.white
        static let detailButtonHeight: CGFloat = 44
    }

    // MARK: - Corner Radius
    
    struct CornerRadius {
        static let small = 15.0
        static let none = 0.0
    }
    

    
    // MARK: - Error Messages
    
    struct Error {
        static let title = "Error"
        static let okButtonTitle = "OK"
    }

    // MARK: - Fonts
    
    struct Fonts {
        static let regularFont = "Karla-Regular"
        static let boldFont = "Karla-Bold"
        static let mediumFont = "Karla-Medium"
    }
    
    // MARK: - Colors
    
    struct Colors {
        static let buttonBackground = UIColor.black
        static let primary = UIColor(hex: "#016396")
        static let theme = UIColor(hex: "#FFFFFF")
        static let appBackground = UIColor(hex: "#F5F5F5")
    }
    
    // MARK: - Spacing
    
    struct Spacing {
        static let small: CGFloat = 8
        static let medium: CGFloat = 16
        static let large: CGFloat = 24
    }
    
    // MARK: - Font Sizes
    
    struct FontSize {
        static let imageSize: CGFloat = 50
        static let imageCornerRadius: CGFloat = 8
        static let titleFontSize: CGFloat = 14
        static let missionFontSize: CGFloat = 16
        static let detailFontSize: CGFloat = 14
        static let headerFontSize: CGFloat = 18
        static let bodyFontSize: CGFloat = 14
    }
    
    // MARK: - Margins
    
    struct Margins {
        static let topMargin: CGFloat = 16
        static let sideMargin: CGFloat = 16
        static let bottomMargin: CGFloat = 16
        static let verticalSpacing: CGFloat = 8
        static let large: CGFloat = 24
    }
    
    struct SegmentedControl {
          static let items = ["States", "Nations"]
          static let identifier = "populationSegmentedControl"
      }
}
