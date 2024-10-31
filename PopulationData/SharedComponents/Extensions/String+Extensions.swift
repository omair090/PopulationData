//
//  String+Extensions.swift
//  PopulationData
//
//  Created by Muhammad Umair on 27/04/1446 AH.
//

import Foundation

extension String {
    
    func localized(defaultValue: String = "") -> String {
        let localizedString = NSLocalizedString(self, comment: "")
        return localizedString.isEmpty ? defaultValue : localizedString
    }
    
    func toURL() -> URL? {
        return URL(string: self)
    }


    
}
