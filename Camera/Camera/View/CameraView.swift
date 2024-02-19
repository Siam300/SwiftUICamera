//
//  CameraView.swift
//  Camera
//
//  Created by Auto on 19/2/24.
//

import SwiftUI

struct CameraView: View {
    @StateObject var model = CameraViewModel()
    @State var currentZoomFactor: CGFloat = 1.0
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                GeometryReader { geometry in
                    ZStack {
                        
                        Rectangle()
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .foregroundColor(.blue)
                        
                        VStack {
                            Button(action: {
                                print("DEBUG: Camera Flash Button tapped....")
                            }, label: {
                                Image(systemName: "bolt.fill")
                                    .font(.system(size: 20, weight: .medium, design: .default))
                            })
                            .accentColor(.white)
                            Spacer()
                            
                            HStack {
                                capturedPhotoThumbnail
                                
                                Spacer()
                                
                                captureButton
                                
                                Spacer()
                                
                                flipCameraButton
                            }
                            .padding(.horizontal, 20)
                        }
                    }
                }
            }

        }
    }
    
    var captureButton: some View {
        Button(action: {
            print("DEBUG: Camera shutter button tapped...")
        }, label: {
            Circle()
                .foregroundColor(.white)
                .frame(width: 80, height: 80, alignment: .center)
                .overlay(
                    Circle()
                        .stroke(Color.black.opacity(0.8), lineWidth: 2)
                        .frame(width: 65, height: 65, alignment: .center)
                )
        })
    }
    
    var capturedPhotoThumbnail: some View {
        Group {
            Image(systemName: "person.fill")
                .resizable()
                .foregroundColor(.white)
                .aspectRatio(contentMode: .fit)
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                .animation(.spring())
        }
    }
    
    var flipCameraButton: some View {
        Button(action: {
            print("DEBUG: Flip Camera Button tapped....")
        }, label: {
            Circle()
                .foregroundColor(Color.gray.opacity(0.2))
                .frame(width: 45, height: 45, alignment: .center)
                .overlay(
                    Image(systemName: "camera.rotate.fill")
                        .foregroundColor(.white))
        })
    }
}

#Preview {
    CameraView()
}
