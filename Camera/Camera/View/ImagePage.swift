//
//  ImagePage.swift
//  Camera
//
//  Created by Auto on 21/2/24.
//

import SwiftUI

struct ImagePage: View {
    @State private var selectedImage: ImageItem?
    
    private let gridItems: [GridItem] = [
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1)
    ]
    private let imageDimension = (UIScreen.main.bounds.width / 3) - 1
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: gridItems, spacing: 2) {
                    ForEach(1 ... 33, id: \.self) { index in
                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: imageDimension, height: imageDimension)
                            .clipped()
                            .padding()
                            .onTapGesture {
                                selectedImage = ImageItem(imageName: "person.fill")
                            }
                    }
                }
            }
            .navigationBarTitle("Images")
            .fullScreenCover(item: $selectedImage) { imageItem in
                FullScreenImageView(imageName: imageItem.imageName)
            }
        }
    }
}

#Preview {
    ImagePage()
}
