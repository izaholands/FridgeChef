
import UIKit
import Vision
import CoreML

final class VisionService {

    func classify(image: UIImage) async throws -> ClassificationResult {

        guard let cgImage = image.cgImage else {
            return ClassificationResult(
                name: nil,
                confidence: 0,
                message: "Imagem inválida"
                
            )
        }

        let configuration = MLModelConfiguration()

        let model = try VNCoreMLModel(
            for: FoodClassifier2(configuration: configuration).model
        )

        return try await withCheckedThrowingContinuation { continuation in

            let request = VNCoreMLRequest(model: model) { request, error in

                if let error {
                    continuation.resume(throwing: error)
                    return
                }

                guard let result = (request.results as? [VNClassificationObservation])?
                    .first else {

                    continuation.resume(returning: ClassificationResult(
                        name: nil,
                        confidence: 0,
                        message: "Não foi possível analisar a imagem"
                    ))
                    return
                }
                let confidence = result.confidence

                // confiança alta
                if confidence >= 0.70 {
                    continuation.resume(
                        returning: ClassificationResult(
                            name: result.identifier,
                            confidence: confidence,
                            message: nil
                        )
                    )

                } else {
                    continuation.resume(
                        returning: ClassificationResult(
                            name: nil,
                            confidence: confidence,
                            message:
                            """
                            Não conseguimos identificar esse alimento.

                            Tente aproximar a câmera,
                            melhorar a iluminação ou
                            deixar o alimento mais visível.
                            """
                        )
                    )
                }

               // continuation.resume(returning: first.identifier)
            }

            let handler = VNImageRequestHandler(cgImage: cgImage)

            do {
                try handler.perform([request])
            } catch {
                continuation.resume(throwing: error)
            }

        }

    }

}
