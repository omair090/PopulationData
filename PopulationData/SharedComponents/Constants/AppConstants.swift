//
//  AppConstants.swift
//  PopulationData
//
//  Created by Muhammad Umair on 27/04/1446 AH.
//

import Foundation


struct AppConstants {
    
    // MARK: - Date Formats
    
    struct DateFormats {
        static let displayDateFormat = "dd MMM yyyy"
        static let dateFormat = "yyyy-MM-dd"
        static let displayTimeFormat = "HH:mm:ss"
    }
    
    // MARK: - Error Messages
    
    struct ErrorMessages {
        static let unknownError = "An unknown error occurred"
        static let invalidURL = "Invalid URL"
        static let networkError = "Network error occurred"
        static let noData = "No data received"
        static let decodingError = "Failed to decode data"
        static let saveError = "Failed to save context"
        static let clearDataFailed = "Failed to clear existing data"
        static let fetchDataFailed = "Failed to fetch data"
        static let requestFailed = "Request failed"
        static let invalidData = "Invalid data received"
        static let decodingFailed = "Failed to decode data"
        static let loadError = "Failed to load persistent stores"
        static let fetchDataError = "Failed to fetch data."
        static let okTitle = "OK"
        static let databaseOperationFailed = "Database operation failed"
    }
    
    // MARK: - Navigation
    
    struct Navigation {
        static let title = "USA Popluation"
        static let filterIconAccessibilityLabel = "Filter"
    }
    

    // MARK: - Table View
    
    struct TableView {
        static let noDataFound =  "No data available"
        static let identifier = "populationTableView"
    }
    
    
    struct Placeholders {
        static let placeholderImage = "placeholderImage"
 
    }

}
