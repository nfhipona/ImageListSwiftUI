//
//  ImageView.swift
//  DisplayImage
//
//  Created by Neil Francis Hipona on 7/27/23.
//

import SwiftUI

struct ImageView: View {
    @ObservedObject var coordinator: ImageViewCoordinator
    
    var body: some View {
        GeometryReader  { proxy in
            NavigationView {
                ScrollView {
                    LazyVStack(spacing: 10) {
                        ForEach(coordinator.imageList, id: \.id) { image in
                            Button {
                                coordinator.navigate(with: image)
                            } label: {
                                AsyncImage(url: URL(string: image.src.medium))
                                    .aspectRatio(contentMode: .fit)
                                    .background(Color.gray)
                                    .frame(width: proxy.size.width - 40,
                                           height: proxy.size.width - 40,
                                           alignment: .center)
                                    .clipped()
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                .navigationTitle("Image Lists")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(coordinator: .init())
    }
}
