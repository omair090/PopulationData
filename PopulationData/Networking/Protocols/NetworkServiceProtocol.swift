//
//  NetworkServiceProtocol.swift
//  PopulationData
//
//  Created by Muhammad Umair on 27/04/1446 AH.
//

import Foundation
import Combine

protocol NetworkServiceProtocol {
    func fetch<T: Decodable>(_ type: T.Type, from request: URLRequest) -> AnyPublisher<T, NetworkError>
}
