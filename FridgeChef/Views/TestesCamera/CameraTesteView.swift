////
////  CameraTesteView.swift
////  FridgeChef
////
////  Created by Maria Izabelle Holanda de Andrade on 05/08/26.
////
//
//import SwiftUI
//
//struct CameraTesteView: View {
//
//    @Environment(\.dismiss)
//    private var dismiss
//
//    @StateObject
//    private var viewModel = CameraViewModel2()
//
//
//    var body: some View {
//
//        ZStack {
//
//            CameraPreview(
//                session: viewModel.camera.session
//            )
//            .ignoresSafeArea()
//
//
//            VStack {
//
//                HStack {
//
//                    Spacer()
//
//                    Button {
//
//                        dismiss()
//
//                    } label: {
//
//                        Image(systemName: "xmark.circle.fill")
//                            .font(.largeTitle)
//                            .foregroundStyle(.white)
//
//                    }
//                    .padding()
//
//                }
//
//                Spacer()
//
//
//                Spacer()
//                
//                if viewModel.isLoading {
//
//                    ProgressView()
//                        .tint(.white)
//                        .scaleEffect(1.5)
//
//                }
//
//
//                if let result = viewModel.classificationResult,
//                   let name = result.name {
//
//                    VStack(spacing: 8) {
//
//                        Text(name)
//                            .font(.title)
//                            .bold()
//
//                        Text(
//                            "Confiança: \(Int(result.confidence * 100))%"
//                        )
//
//                    }
//                    .padding()
//                    .background(.ultraThinMaterial)
//                    .clipShape(
//                        RoundedRectangle(cornerRadius: 15)
//                    )
//
//                }
//
//
//                if let message = viewModel.feedbackMessage {
//
//                    Text(message)
//                        .multilineTextAlignment(.center)
//                        .padding()
//                        .background(.ultraThinMaterial)
//                        .clipShape(
//                            RoundedRectangle(cornerRadius: 15)
//                        )
//
//                }
//
//
//                Button {
//
//                    viewModel.capture()
//
//                } label: {
//
//                    Circle()
//                        .fill(.white)
//                        .frame(width: 80, height: 80)
//
//                }
//                .padding(.bottom,40)
//                
//                
//
//            }
//
//        }
//        .onAppear {
//
//            viewModel.startCamera()
//
//        }
//        .onDisappear {
//
//            viewModel.stopCamera()
//
//        }
//
//    }
//}
//
//
//#Preview {
//    CameraTesteView()
//}
