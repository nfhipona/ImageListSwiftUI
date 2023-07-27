//
//  ImageData.swift
//  DisplayImage
//
//  Created by Neil Francis Hipona on 7/27/23.
//

import Foundation

extension ImageData {
    struct Source: Decodable {
        let original: String
        let large: String
        let medium: String
        let small: String
        let portrait: String
        let landscape: String
        let tiny: String
        
        enum CodingKeys: String, CodingKey {
            case original
            case large
            case medium
            case small
            case portrait
            case landscape
            case tiny
        }
    }
}

struct ImageData: Decodable {
    let id: Int
    let width: Int
    let height: Int
    let url: String
    let photographer: String
    let photographerUrl: String
    let alt: String
    let src: Source
    
    enum CodingKeys: String, CodingKey {
        case id
        case width
        case height
        case url
        case photographer
        case photographer_url
        case alt
        case src
    }
    
    init(from decoder: Decoder) throws {
        let decoded = try decoder.container(keyedBy: CodingKeys.self)
        id = try decoded.decode(Int.self, forKey: .id)
        width = try decoded.decode(Int.self, forKey: .width)
        height = try decoded.decode(Int.self, forKey: .height)
        url = try decoded.decode(String.self, forKey: .url)
        photographer = try decoded.decode(String.self, forKey: .photographer)
        photographerUrl = try decoded.decode(String.self, forKey: .photographer_url)
        alt = try decoded.decode(String.self, forKey: .alt)
        src = try decoded.decode(Source.self, forKey: .src)
    }
}

struct ImageContent: Decodable {
    let page: Int
    let perPage: Int
    let photos: [ImageData]
    let nextPage: String
    
    enum CodingKeys: String, CodingKey {
        case page
        case per_page
        case photos
        case next_page
    }
    
    init(from decoder: Decoder) throws {
        let decoded = try decoder.container(keyedBy: CodingKeys.self)
        page = try decoded.decode(Int.self, forKey: .page)
        perPage = try decoded.decode(Int.self, forKey: .per_page)
        photos = try decoded.decode([ImageData].self, forKey: .photos)
        nextPage = try decoded.decode(String.self, forKey: .next_page)
    }
}
