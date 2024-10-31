//
//  NetworkError..swift
//  PopulationData
//
//  Created by Muhammad Umair on 27/04/1446 AH.
//

import Foundation

enum NetworkError: Error, CustomStringConvertible, Equatable {
    case requestFailed(String)
    case invalidData(String)
    case decodingFailed(String)
    case networkError(String)
    case unknown(String)
    case databaseOperationFailed(String)

    var description: String {
        switch self {
        case .requestFailed(let message):
            return "Request Failed: \(message)"
        case .invalidData(let message):
            return "Invalid Data: \(message)"
        case .decodingFailed(let message):
            return "Decoding Error: \(message)"
        case .networkError(let message):
            return "Network Error: \(message)"
        case .unknown(let message):
            return "Unknown Error: \(message)"
        case .databaseOperationFailed(let message):
            return "Database Operation Failed: \(message)"
        }
    }

    // MARK: - Equatable Conformance
    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        return lhs.description == rhs.description
    }
}
