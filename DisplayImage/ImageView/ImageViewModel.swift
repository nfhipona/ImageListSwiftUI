//
//  ImageViewModel.swift
//  DisplayImage
//
//  Created by Neil Francis Hipona on 7/27/23.
//

import SwiftUI
import Combine

class ImageViewModel: ObservableObject {
    private unowned let coordinator: ImageViewCoordinator
    private let imageAPI: ImageServiceAPI
    private var store = Set<AnyCancellable>()
    
    init(coordinator: ImageViewCoordinator) {
        self.coordinator = coordinator
        self.imageAPI = ImageServiceAPI(service: ServiceAPI(baseURL: Secret.baseURL))
        
        // self.getLists()
        self.getListsCombine()
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
    
    func getListsCombine() {
        imageAPI.combineGetImages(req: .getImages(perPage: 10))
            .map(\.photos)
            .sink(receiveCompletion: { error in
                print("error", error)
            }, receiveValue: { [weak self] images in
                guard let self else { return }
                Task {
                    await self.coordinator.setImageList(imageList: images)
                }
            })
            .store(in: &store)
    }
}
