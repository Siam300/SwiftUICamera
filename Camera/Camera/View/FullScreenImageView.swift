//
//  FullScreenImageView.swift
//  Camera
//
//  Created by Auto on 21/2/24.
//

import SwiftUI

struct FullScreenImageView: View {
    let imageName: String
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .edgesIgnoringSafeArea(.all)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                                .imageScale(.large)
                                .frame(width: 32, height: 32)
                        }
                    }
                }
        }
    }
}
