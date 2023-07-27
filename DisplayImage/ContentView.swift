//
//  ContentView.swift
//  DisplayImage
//
//  Created by Neil Francis Hipona on 7/27/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var coordinator: ContentViewCoordinator
    
    var body: some View {
        ImageView(coordinator: coordinator.imageViewCoordinator)
            .fullScreenCover(item: $coordinator.imageData, onDismiss: {
                coordinator.imageData = nil
            }, content: { item in
                ImageDetailView(coordinator: .init(imageData: item))
                    .navigationTitle("Image Detail")
            })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(coordinator: .init())
    }
}
