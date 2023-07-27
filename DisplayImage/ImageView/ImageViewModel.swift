//
//  ImageViewModel.swift
//  DisplayImage
//
//  Created by Neil Francis Hipona on 7/27/23.
//

import SwiftUI

class ImageViewModel: ObservableObject {
    private unowned let coordinator: ImageViewCoordinator
    private let imageAPI: ImageServiceAPI
    
    init(coordinator: ImageViewCoordinator) {
        self.coordinator = coordinator
        self.imageAPI = ImageServiceAPI(service: ServiceAPI(baseURL: Secret.baseURL))
        
        self.getLists()
    }
    
    func getLists() {
        Task {
            do {
                let contents = try await imageAPI.getImages(req: .getImages(perPage: 10))
                await coordinator.setImageList(imageList: contents.photos)
            } catch {
                print("error", error)
            }
        }
    }
}
