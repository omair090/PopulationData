//
//  NetworkService.swift
//  PopulationData
//
//  Created by Muhammad Umair on 27/04/1446 AH.
//

import Foundation
import Combine
import Alamofire

class NetworkService: NetworkServiceProtocol {
    
    func fetch<T: Decodable>(_ type: T.Type, from request: URLRequest) -> AnyPublisher<T, NetworkError> {
        
        print(request.prettyPrintRequest())
        
        return Future<T, NetworkError> { promise in
            AF.request(request)
                .validate(statusCode: HTTPStatusCode.successRange)
                .responseData { response in
                    switch response.result {
                    case .success(let data):
                        
                        do {
                            let decodedData = try JSONDecoder().decode(T.self, from: data)
                            print("Decoding Successful: \(T.self)")
                            promise(.success(decodedData))
                        } catch let decodingError as DecodingError {
                            self.logDetailedDecodingError(data: data, error: decodingError, type: T.self)
                            promise(.failure(.decodingFailed("Failed to decode JSON: \(decodingError.localizedDescription)")))
                        } catch {
                            print("Unknown decoding error: \(error.localizedDescription)")
                            promise(.failure(.unknown("Unknown error during decoding: \(error.localizedDescription)")))
                        }

                    case .failure(let error):
                        self.logNetworkError(response: response)
                        promise(.failure(.networkError(error.localizedDescription)))
                    }
                }
        }
        .eraseToAnyPublisher()
    }

    private func logDetailedDecodingError<T: Decodable>(data: Data, error: DecodingError, type: T.Type) {
        if let responseString = String(data: data, encoding: .utf8) {
            print("Decoding Error in response: \(responseString)")
        }
        
        switch error {
        case .typeMismatch(let type, let context):
            print("Type Mismatch: \(type) \(context.debugDescription) at \(context.codingPath)")
        case .valueNotFound(let type, let context):
            print("Value Not Found: \(type) \(context.debugDescription) at \(context.codingPath)")
        case .keyNotFound(let key, let context):
            print("Key Not Found: \(key.stringValue) \(context.debugDescription) at \(context.codingPath)")
        case .dataCorrupted(let context):
            print("Data Corrupted: \(context.debugDescription) at \(context.codingPath)")
        @unknown default:
            print("Unknown Decoding Error: \(error.localizedDescription)")
        }
    }
    
    private func logNetworkError(response: AFDataResponse<Data>) {
        if let data = response.data, let responseString = String(data: data, encoding: .utf8) {
            print("Server responded with error data: \(responseString)")
        }
        
        if let error = response.error {
            print("Network error: \(error.localizedDescription)")
        }
    }
}
