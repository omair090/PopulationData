//
//  PopulationRequest.swift
//  PopulationData
//
//  Created by Muhammad Umair on 27/04/1446 AH.
//

import Foundation

struct PopulationRequest {
    // MARK: - Properties
    
    let regionType: RegionType
    let page: Int?

    // MARK: - URL Construction
    
    var url: URL? {
        let endpoint: String
        switch regionType {
        case .state:
            endpoint = APIConstants.Endpoints.statePopulation
        case .nation:
            endpoint = APIConstants.Endpoints.nationPopulation
        }
        return APIConstants.getURL(for: endpoint, page: page)
    }

    // MARK: - URLRequest
    
    func asURLRequest() -> URLRequest? {
        guard let url = url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = APIConstants.HTTPMethods.get
        request.setValue(APIConstants.Headers.contentTypeJSON, forHTTPHeaderField: APIConstants.Headers.contentType)
        
        return request
    }
}
