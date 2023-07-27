//
//  Secrets.swift
//  DisplayImage
//
//  Created by Neil Francis Hipona on 7/27/23.
//

import Foundation

struct Secret {
    static let baseURL: String = {
        let info = Bundle.main.infoDictionary
        guard let info,
              let baseURL = info["BASE_URL"] as? String
        else { return "" }
        return baseURL
    }()
    
    static let imageServiceToken: String = {
        let info = Bundle.main.infoDictionary
        guard let info,
              let token = info["API_TOKEN"] as? String
        else { return "" }
        return token
    }()
}

