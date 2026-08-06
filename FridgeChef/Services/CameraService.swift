//
//import AVFoundation
//import UIKit
//
//final class CameraService: NSObject {
//
//    let session = AVCaptureSession()
//
//    private let output = AVCapturePhotoOutput()
//
//    private var completion: ((UIImage?) -> Void)?
//
//    override init() {
//        super.init()
//
//        configureSession()
//    }
//
//    private func configureSession() {
//
//        session.beginConfiguration()
//
//        guard let camera = AVCaptureDevice.default(
//            .builtInWideAngleCamera,
//            for: .video,
//            position: .back
//        ) else {
//            return
//        }
//
//        guard let input = try? AVCaptureDeviceInput(device: camera)
//        else {
//            return
//        }
//
//        if session.canAddInput(input) {
//            session.addInput(input)
//        }
//
//        if session.canAddOutput(output) {
//            session.addOutput(output)
//        }
//
//        session.commitConfiguration()
//    }
//
//    func start() {
//
//        DispatchQueue.global(qos: .userInitiated).async {
//
//            self.session.startRunning()
//
//        }
//
//    }
//
//    func stop() {
//
//        session.stopRunning()
//
//    }
//
//    func capturePhoto(
//        completion: @escaping (UIImage?) -> Void
//    ) {
//
//        self.completion = completion
//
//        let settings = AVCapturePhotoSettings()
//
//        output.capturePhoto(
//            with: settings,
//            delegate: self
//        )
//
//    }
//
//}
//
//extension CameraService: AVCapturePhotoCaptureDelegate {
//
//    func photoOutput(
//        _ output: AVCapturePhotoOutput,
//        didFinishProcessingPhoto photo: AVCapturePhoto,
//        error: Error?
//    ) {
//
//        guard
//            let data = photo.fileDataRepresentation(),
//            let image = UIImage(data: data)
//        else {
//
//            completion?(nil)
//
//            return
//        }
//
//        completion?(image)
//
//    }
//
//}
