//
//  ImageViewCoordinator.swift
//  DisplayImage
//
//  Created by Neil Francis Hipona on 7/27/23.
//

import SwiftUI

@MainActor
class ImageViewCoordinator: ObservableObject {
    @Published var viewModel: ImageViewModel!
    @Published var imageList: [ImageData] = []
    
    init() {
        viewModel = ImageViewModel(coordinator: self)
    }
    
    func setImageList(imageList: [ImageData]) {
        self.imageList = imageList
    }
}
