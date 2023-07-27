//
//  ServiceAPI.swift
//  DisplayImage
//
//  Created by Neil Francis Hipona on 7/27/23.
//

import Foundation

protocol APIProtocol {
    var method: ServiceAPI.Method { get }
    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
    var body: Data? { get }
    var headers: [ServiceAPI.Header]? { get }
}

extension ServiceAPI {
    enum APIError: Error {
        case unableToComplete
        case invalidURL
    }

    enum Method: String {
      case post = "POST"
      case get = "GET"
      case put = "PUT"
    }
    
    struct Header {
        let name: String
        let value: String
    }
}

class ServiceAPI {
    let baseURL: String
    let decoder: JSONDecoder
    
    init(baseURL: String) {
        self.baseURL = baseURL
        self.decoder = JSONDecoder()
    }
    
    func request<T: Decodable>(path: String, method: Method = .get, headers: [Header]? = nil, body: Data? = nil, queryItems: [URLQueryItem]? = nil) async throws -> T {
        guard var url = URL(string: baseURL.appending(path))
        else {
            throw APIError.invalidURL
        }
        
        if let queryItems {
            url.append(queryItems: queryItems)
        }
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 120)
        request.httpMethod = method.rawValue
        request.httpBody = body
        
        if let headers {
            for header in headers {
                request.setValue(header.value, forHTTPHeaderField: header.name)
            }
        }
        
        do {
            let result: (data: Data, response: URLResponse) = try await URLSession.shared.data(for: request)
            return try decoder.decode(T.self, from: result.data)
        } catch {
            throw APIError.unableToComplete
        }
    }
}
