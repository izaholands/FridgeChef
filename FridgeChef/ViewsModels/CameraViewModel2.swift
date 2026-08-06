////
////  CameraViewModel.swift
////  FridgeChef
////
////  Created by Maria Izabelle Holanda de Andrade on 05/08/26.
////
//
//import Foundation
//import UIKit
//import Combine
//
//@MainActor
//final class CameraViewModel2: ObservableObject {
//    @Published var feedbackMessage: String?
//    @Published var classificationResult: ClassificationResult?
//    @Published var isLoading = false
//    
//    @Published var ingredients: [Ingredient] = []
//
//    @Published var capturedImage: UIImage?
//
//    let camera = CameraService()
//
//    let vision = VisionService()
//
//    func startCamera() {
//
//        camera.start()
//
//    }
//
//    func stopCamera() {
//
//        camera.stop()
//
//    }
//
//    func capture() {
//
//        camera.capturePhoto { [weak self] image in
//
//            guard let self else {
//
//                return
//
//            }
//
//            guard let image else {
//
//                return
//
//            }
//
//            Task { @MainActor in
//                self.isLoading = true
//                defer {
//                    self.isLoading = false
//                }
//                self.classificationResult = nil
//                self.feedbackMessage = nil
//
//                self.capturedImage = image
//
//
//                do {
//
////                    let ingredient = try await self.vision.classify(
////                        image: image
////                    )
////
////                    self.ingredients.append(
////                        Ingredient(name: ingredient)
////                    )
//                    let result = try await self.vision.classify(image: image)
//                    
//                    self.classificationResult = result
//                    
//                    if let name = result.name {
//                        
//                        //self.ingredients.append(Ingredient(name: name))
//                        self.ingredients = [
//                            Ingredient(name: name)
//                        ]
//                        
//                        self.feedbackMessage = nil
//                        
//                    } else{
//                        self.ingredients.removeAll()
//                        self.feedbackMessage = result.message
//
//                    }
//
//                } catch {
//                    self.feedbackMessage = "Erro ao analisar imagem"
//
//
//                    print(error)
//
//                }
//
//            }
//
//        }
//
//    }
//
//}
