//
//  ImagePage.swift
//  Camera
//
//  Created by Auto on 21/2/24.
//

import SwiftUI

struct ImagePage: View {
    private let gridItems: [GridItem] = [
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1)
    ]
    private let imageDimention = (UIScreen.main.bounds.width / 3) - 1
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridItems, spacing: 2) {
                ForEach(1 ... 33, id: \.self) { image in
                    Image(systemName: "person.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: imageDimention, height: imageDimention)
                        .clipped()
                        .padding()
                }
            }
        }
        .navigationBarTitle("Images")
    }
}

#Preview {
    ImagePage()
}
