//
//  ContentViewCoordinator.swift
//  DisplayImage
//
//  Created by Neil Francis Hipona on 7/27/23.
//

import SwiftUI

@MainActor
class ContentViewCoordinator: ObservableObject {
    @Published var imageViewCoordinator: ImageViewCoordinator!
    @Published var imageData: ImageData?
    
    init() {
        imageViewCoordinator = ImageViewCoordinator(mainCoordinator: self)
    }
    
    func navigate(with imageData: ImageData) {
        self.imageData = imageData
    }
}
