import UIKit
import Vision
import CoreML

final class VisionService {
    
    // Instancia o modelo uma única vez para reaproveitá-lo na memória
    private let model: VNCoreMLModel = {
        let configuration = MLModelConfiguration()
        guard let mlModel = try? MyObjectDetector1(configuration: configuration).model,
              let visionModel = try? VNCoreMLModel(for: mlModel) else {
            fatalError("Falha ao carregar o modelo CoreML MyObjectDetector1")
        }
        return visionModel
    }()
    
    func detectObjects(in image: UIImage) async throws -> [String] {
        
        guard let cgImage = image.cgImage else {
            throw NSError(
                domain: "VisionService",
                code: 400,
                userInfo: [NSLocalizedDescriptionKey: "Imagem inválida"]
            )
        }
        
        return try await withCheckedThrowingContinuation { continuation in
            let request = VNCoreMLRequest(model: model) { request, error in
                if let error {
                    continuation.resume(throwing: error)
                    return
                }
                
                guard let results = request.results as? [VNRecognizedObjectObservation] else {
                    continuation.resume(returning: [])
                    return
                }
                
                var detectedLabels: [String] = []
                
                // Itera sobre cada alimento encontrado na foto
                for observation in results {
                    // Pega a classe com maior confiança do objeto
                    if let topCandidate = observation.labels.first {
                        // Filtra pelo limite de confiança (60%)
                        if topCandidate.confidence >= 0.20 {
                            detectedLabels.append(topCandidate.identifier)
                        }
                        for label in observation.labels {
                            print("🔍 IA enxergou: '\(label.identifier)' | Confiança: \(label.confidence * 100)%")
                        }
                    }
                }
                
                continuation.resume(returning: detectedLabels)
            }
            
            // Garante que o recorte mantenha a proporção ideal para detecção
            request.imageCropAndScaleOption = .scaleFit
            
            let handler = VNImageRequestHandler(cgImage: cgImage)
            
            do {
                try handler.perform([request])
            } catch {
                continuation.resume(throwing: error)
            }
        }
    }
}
