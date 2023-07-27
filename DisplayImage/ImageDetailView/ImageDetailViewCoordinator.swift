//
//  ImageDetailViewCoordinator.swift
//  DisplayImage
//
//  Created by Neil Francis Hipona on 7/27/23.
//

import SwiftUI

class ImageDetailViewCoordinator: ObservableObject {
    @Published var viewModel: ImageDetailViewModel!
    @Published var imageData: ImageData?
    
    init(imageData: ImageData? = nil) {
        self.imageData = imageData
        self.viewModel = ImageDetailViewModel(coordinator: self)
    }
}
