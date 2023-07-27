//
//  ImageDetailView.swift
//  DisplayImage
//
//  Created by Neil Francis Hipona on 7/27/23.
//

import SwiftUI

struct ImageDetailView: View {
    @ObservedObject var coordinator: ImageDetailViewCoordinator
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        GeometryReader  { proxy in
            NavigationView {
                VStack(spacing: 10) {
                    if let image = coordinator.imageData {
                        AsyncImage(url: URL(string: image.src.medium))
                            .aspectRatio(contentMode: .fit)
                            .background(Color.gray)
                            .frame(width: abs(proxy.size.width - 40),
                                   height: abs(proxy.size.width - 40),
                                   alignment: .center)
                            .clipped()
                        
                        showDetails(image: image)
                        
                        Spacer()
                        Button("Done") {
                            dismiss()
                        }
                        .padding(.bottom, 40)
                    }
                }
                .padding(.horizontal, 20)
                .navigationTitle("Image Detail")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
    
    func showDetails(image: ImageData) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Image ID: ") + Text("\(image.id)").bold()
            Text("Author: ") + Text(image.photographer).bold()
            Text("Alt: ") + Text(image.alt).bold()
            Text("Url: ") + Text(image.url).bold()
        }
    }
}

struct ImageDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ImageDetailView(coordinator: .init())
    }
}
