//
//  MockImageURLProtocol.swift
//  DisplayImage
//
//  Created by Neil Francis Hipona on 7/27/23.
//

import Foundation

class MockImageURLProtocol: URLProtocol {
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        guard let client, let url = request.url
        else {
            client?.urlProtocol(self, didFailWithError: ServiceAPI.APIError.unableToComplete)
            return
        }

        if url.absoluteString.split(separator: "?").first == "https://api.pexels.com/v1/curated" {
            let bundleURL = Bundle.main.url(forResource: "image_list", withExtension: ".json")
            if let bundleURL, let data = try? Data(contentsOf: bundleURL) {
                client.urlProtocol(self, didLoad: data)
            }
        }

        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        client.urlProtocol(self, didReceive: response!, cacheStoragePolicy: .notAllowed)
        client.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {
        
    }
}
