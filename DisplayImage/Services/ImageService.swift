//
//  ImageService.swift
//  DisplayImage
//
//  Created by Neil Francis Hipona on 7/27/23.
//

import Foundation
import Combine

enum ImageService: APIProtocol {
    case getImages(perPage: Int)
    
    var method: ServiceAPI.Method {
        switch self {
        case .getImages:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getImages:
            return "/curated"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .getImages(let perPage):
            return [
                URLQueryItem(name: "per_page", value: "\(perPage)")
             ]
        }
    }
    
    var body: Data? {
        return nil
    }
    
    var headers: [ServiceAPI.Header]? {
        switch self {
        case .getImages:
            return [
                .init(name: "Authorization", value: Secret.imageServiceToken),
                .init(name: "accept", value: "application/json"),
                .init(name: "content-type", value: "application/json")
             ]
        }
    }
}

class ImageServiceAPI {
    let service: ServiceAPI
    
    init(service: ServiceAPI) {
        self.service = service
    }
    
    func getImages(req: ImageService) async throws -> ImageContent {
        return try await service.request(path: req.path, method: req.method, headers: req.headers, body: req.body, queryItems: req.queryItems)
    }
    
    func combineGetImages(req: ImageService) -> AnyPublisher<ImageContent, Error> {
        service.combineRequest(path: req.path, method: req.method, headers: req.headers, body: req.body, queryItems: req.queryItems)
    }
}
