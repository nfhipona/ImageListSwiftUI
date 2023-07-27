//
//  ImageViewCoordinator.swift
//  DisplayImage
//
//  Created by Neil Francis Hipona on 7/27/23.
//

import SwiftUI

@MainActor
class ImageViewCoordinator: ObservableObject {
    unowned let mainCoordinator: ContentViewCoordinator?
    @Published var viewModel: ImageViewModel!
    @Published var imageList: [ImageData] = []
    
    init(mainCoordinator: ContentViewCoordinator? = nil) {
        self.mainCoordinator = mainCoordinator
        self.viewModel = ImageViewModel(coordinator: self)
    }
    
    func setImageList(imageList: [ImageData]) {
        self.imageList = imageList
    }

    func navigate(with imageData: ImageData) {
        mainCoordinator?.navigate(with: imageData)
    }
}
