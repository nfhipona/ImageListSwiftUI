//
//  ServiceLocalAPI.swift
//  DisplayImage
//
//  Created by Neil Francis Hipona on 7/27/23.
//

import Foundation
import Combine

class ServiceLocalAPI: ServiceAPI {
    let session: URLSession = {
        let configuration: URLSessionConfiguration = .default
        configuration.protocolClasses = [MockImageURLProtocol.self]
        let session = URLSession(configuration: configuration)
        return session
    }()
    
    override func request<T: Decodable>(path: String, method: Method = .get, headers: [Header]? = nil, body: Data? = nil, queryItems: [URLQueryItem]? = nil) async throws -> T {
        guard var components = URLComponents(string: baseURL.appending(path))
        else {
            throw APIError.invalidURL
        }
        components.queryItems = queryItems
        guard let url = components.url else { throw APIError.invalidURL }
        
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
    
    override func combineRequest<T: Decodable>(path: String, method: Method = .get, headers: [Header]? = nil, body: Data? = nil, queryItems: [URLQueryItem]? = nil) -> AnyPublisher<T, Error> {
        guard var components = URLComponents(string: baseURL.appending(path))
        else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }
        components.queryItems = queryItems
        guard let url = components.url
        else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 120)
        request.httpMethod = method.rawValue
        request.httpBody = body
        
        if let headers {
            for header in headers {
                request.setValue(header.value, forHTTPHeaderField: header.name)
            }
        }
        
        return session.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: T.self, decoder: decoder)
            .eraseToAnyPublisher()
    }

}
