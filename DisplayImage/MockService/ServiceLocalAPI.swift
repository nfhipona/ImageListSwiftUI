//
//  ServiceLocalAPI.swift
//  DisplayImage
//
//  Created by Neil Francis Hipona on 7/27/23.
//

import Foundation

class ServiceLocalAPI: ServiceAPI {
    let session: URLSession = {
        let configuration: URLSessionConfiguration = .default
        configuration.protocolClasses = [MockImageURLProtocol.self]
        let session = URLSession(configuration: configuration)
        return session
    }()
    
    override func request<T: Decodable>(path: String, method: Method = .get, headers: [Header]? = nil, body: Data? = nil, queryItems: [URLQueryItem]? = nil) async throws -> T {
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
            let result: (data: Data, response: URLResponse) = try await session.data(for: request)
            return try decoder.decode(T.self, from: result.data)
        } catch {
            throw APIError.unableToComplete
        }
    }
}