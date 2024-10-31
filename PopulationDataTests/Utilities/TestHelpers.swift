//
//  TestHelpers.swift
//  PopulationData
//
//  Created by Muhammad Umair on 28/04/1446 AH.
//

import Foundation

class TestHelper {
    
    static func loadMockData(_ fileName: String, bundle: Bundle = .main) -> Data? {
        guard let url = bundle.url(forResource: fileName, withExtension: "json") else {
            print("Error: \(fileName).json not found in bundle \(bundle.bundlePath).")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            print("Successfully loaded \(fileName).json")
            return data
        } catch {
            print("Error loading \(fileName).json from bundle: \(error)")
            return nil
        }
    }
}
