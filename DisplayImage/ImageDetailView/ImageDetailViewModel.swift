//
//  ImageDetailViewModel.swift
//  DisplayImage
//
//  Created by Neil Francis Hipona on 7/27/23.
//

import SwiftUI

class ImageDetailViewModel: ObservableObject {
    private unowned let coordinator: ImageDetailViewCoordinator
    
    init(coordinator: ImageDetailViewCoordinator) {
        self.coordinator = coordinator
    }
}
