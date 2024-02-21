//
//  CameraView.swift
//  Camera
//
//  Created by Auto on 19/2/24.
//

import SwiftUI

struct CameraView: View {
    @StateObject var viewModel = CameraViewModel()
    
    @State var currentZoomFactor: CGFloat = 1.0
    
    var body: some View {
        GeometryReader { reader in
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                VStack {
                    Button(action: {
                        viewModel.switchFlash()
                    }, label: {
                        Image(systemName: viewModel.isFlashOn ? "bolt.fill" : "bolt.slash.fill")
                            .font(.system(size: 20, weight: .medium, design: .default))
                    })
                    .accentColor(viewModel.isFlashOn ? .yellow : .white)
                    
                    CameraPreview(session: viewModel.session)
                        .gesture(
                            DragGesture().onChanged({ (val) in
                                //  Only accept vertical drag
                                if abs(val.translation.height) > abs(val.translation.width) {
                                    //  Get the percentage of vertical screen space covered by drag
                                    let percentage: CGFloat = -(val.translation.height / reader.size.height)
                                    //  Calculate new zoom factor
                                    let calc = currentZoomFactor + percentage
                                    //  Limit zoom factor to a maximum of 5x and a minimum of 1x
                                    let zoomFactor: CGFloat = min(max(calc, 1), 5)
                                    //  Store the newly calculated zoom factor
                                    currentZoomFactor = zoomFactor
                                    //  Sets the zoom factor to the capture device session
                                    viewModel.zoom(with: zoomFactor)
                                }
                            })
                        )
                        .onAppear {
                            viewModel.configure()
                        }
                        .alert(isPresented: $viewModel.showAlertError, content: {
                            Alert(title: Text(viewModel.alertError.title), message: Text(viewModel.alertError.message), dismissButton: .default(Text(viewModel.alertError.primaryButtonTitle), action: {
                                viewModel.alertError.primaryAction?()
                            }))
                        })
                        .overlay(
                            Group {
                                if viewModel.willCapturePhoto {
                                    Color.black
                                }
                            }
                        )
                        .animation(.easeInOut)
                    
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
    
    var captureButton: some View {
        Button(action: {
            viewModel.capturePhoto()
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
            if viewModel.photo != nil {
                Image(uiImage: viewModel.photo.image!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .animation(.spring())
                
            } else {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 60, height: 60, alignment: .center)
                    .foregroundColor(.black)
            }
        }
    }
    
    var flipCameraButton: some View {
        Button(action: {
            viewModel.flipCamera()
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
