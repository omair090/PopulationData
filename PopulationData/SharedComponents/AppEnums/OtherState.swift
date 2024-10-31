//
//  OtherState.swift
//  PopulationData
//
//  Created by Muhammad Umair on 27/04/1446 AH.
//

import Foundation
import UIKit

enum ImageDownloadError: Error {
    case networkError
    case invalidData
}

enum HTTPStatusCode {
    static let successRange = 200...299
}
