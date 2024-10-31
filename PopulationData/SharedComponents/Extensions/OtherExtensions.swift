//
//  OtherExtensions.swift
//  PopulationData
//
//  Created by Muhammad Umair on 27/04/1446 AH.
//


import Foundation
import UIKit
import Combine

extension Result {
    func map<T>(_ transform: (Success) -> T) -> Result<T, Failure> {
        switch self {
        case .success(let value):
            return .success(transform(value))
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func getOrElse(_ fallback: (Failure) -> Success) -> Success {
        switch self {
        case .success(let value):
            return value
        case .failure(let error):
            return fallback(error)
        }
    }
}


extension Publisher {
    func shareReplayLatest() -> AnyPublisher<Output, Failure> {
        let subject = CurrentValueSubject<Output?, Failure>(nil)
        
        return self
            .handleEvents(receiveOutput: { output in
                subject.send(output)
            })
            .compactMap { $0 }
            .eraseToAnyPublisher()
    }
}

extension Encodable {

    func toJSONData() -> Data? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted // To make the JSON output readable
        return try? encoder.encode(self)
    }

    func toDictionary() -> [String: Any]? {
        guard let data = self.toJSONData() else { return nil }
        
        return try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
    }

    func toJSONString() -> String? {
        guard let data = self.toJSONData() else { return nil }
        return String(data: data, encoding: .utf8)
    }
}


extension URLRequest {
    

    func decodeBodyToJSON() -> [String: Any]? {
        guard let httpBody = self.httpBody else { return nil }
        
        do {
            // Try to decode the HTTP body as JSON
            if let jsonObject = try JSONSerialization.jsonObject(with: httpBody, options: []) as? [String: Any] {
                return jsonObject
            }
        } catch {
            print("Error decoding JSON body: \(error.localizedDescription)")
        }
        return nil
    }

    func decodeURLQueryParameters() -> [String: String]? {
        guard let url = self.url else { return nil }
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
              let queryItems = components.queryItems else {
            return nil
        }
        
        var queryDict: [String: String] = [:]
        for item in queryItems {
            queryDict[item.name] = item.value
        }
        return queryDict
    }
    
    func prettyPrintRequest() {
        var requestDetails: [String: Any] = [:]
        
        requestDetails["Method"] = self.httpMethod ?? "Unknown"
        requestDetails["URL"] = self.url?.absoluteString ?? "No URL"
        requestDetails["Headers"] = self.allHTTPHeaderFields ?? [:]
        
        if let body = self.decodeBodyToJSON() {
            requestDetails["Body"] = body
        }
        
        if let queryParameters = self.decodeURLQueryParameters() {
            requestDetails["Query Parameters"] = queryParameters
        }
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: requestDetails, options: .prettyPrinted),
           let jsonString = String(data: jsonData, encoding: .utf8) {
            print(jsonString)
        } else {
            print("Failed to serialize request details")
        }
    }
}

// MARK: - Loading Indicator Extension
extension UIViewController {

    private struct LoadingIndicator {
        static var indicator: UIActivityIndicatorView?
    }

    func showLoadingIndicator() {
        if LoadingIndicator.indicator == nil {
            let indicator = UIActivityIndicatorView(style: .large)
            indicator.translatesAutoresizingMaskIntoConstraints = false
            indicator.color = .gray
            view.addSubview(indicator)
            
            NSLayoutConstraint.activate([
                indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
            
            LoadingIndicator.indicator = indicator
        }
        LoadingIndicator.indicator?.startAnimating()
    }

    func hideLoadingIndicator() {
        LoadingIndicator.indicator?.stopAnimating()
        LoadingIndicator.indicator?.removeFromSuperview()
        LoadingIndicator.indicator = nil
    }
}

// MARK: - Error Alert Extension
extension UIViewController {

    func showError(_ message: String, title: String = "Error") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension UIColor {
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 255, 255, 255)
        }
        self.init(
            red: CGFloat(r) / 255,
            green: CGFloat(g) / 255,
            blue: CGFloat(b) / 255,
            alpha: CGFloat(a) / 255
        )
    }
}
