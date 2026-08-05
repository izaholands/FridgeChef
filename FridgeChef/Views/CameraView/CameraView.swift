import SwiftUI
import PhotosUI

struct CameraView: View {
    @StateObject private var viewModel = CameraViewModel()
    @State private var showCamera = false
    @State private var showPhotosPicker = false
    @State private var selectedPhotosItems: [PhotosPickerItem] = []
    @State private var cameraImage: UIImage?
    
    var body: some View {
        NavigationStack(path: $viewModel.navigationPath) {
            VStack {
                HStack {
                    Text("FridgeChef")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding(.top, 40)
                .padding(.horizontal, 24)
                
                Spacer(minLength: 40)
                
                VStack(spacing: 24) {
                    VStack {
                        Image(systemName: "refrigerator")
                            .font(.system(size: 40))
                            .foregroundColor(Color("systemPrimaryColor"))
                    }
                    .frame(width: 100, height: 100)
                    .background(Color("secondColor"))
                    .cornerRadius(20)
                    
                    VStack(spacing: 12) {
                        Text("O que vamos cozinhar?")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text("Fotografe sua geladeira ou despensa\n(pode tirar mais de uma foto) e descubra\nreceitas feitas para você.")
                            .font(.body)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                }
                .padding(.horizontal, 24)
                
                Spacer(minLength: 40)
                
                VStack(spacing: 16) {
                    ActionCardButton(
                        title: "Tirar foto",
                        iconName: "camera",
                        backgroundColor: Color("systemPrimaryColor"),
                        foregroundColor: .white
                    ) {
                        showCamera = true
                    }
                    
                    ActionCardButton(
                        title: "Escolher da galeria",
                        iconName: "photo.on.rectangle",
                        backgroundColor: Color("secondColor"),
                        foregroundColor: Color.primary
                    ) {
                        showPhotosPicker = true
                    }
                }
                .padding(.bottom, 20)
                .padding(.horizontal, 24)
                
            }
            .navigationDestination(for: CameraNavigationRoute.self) { route in
                switch route {
                case .review:
                    PhotoReviewView()
                        .environmentObject(viewModel)
                case .analyzing:
                    AnalyzingView()
                        .environmentObject(viewModel)
                case .ingredients:
                    IngredientsView()
                        .environmentObject(viewModel)
                case .recipeResult:
                    YourReveneu()
                }
            }
            .sheet(isPresented: $showCamera) {
                CameraPickerView(selectedImage: $cameraImage)
            }
            .onChange(of: cameraImage) { _, newImage in
                if let img = newImage {
                    viewModel.addImage(img)
                    viewModel.navigationPath.append(CameraNavigationRoute.review)
                    cameraImage = nil
                }
            }
            .photosPicker(isPresented: $showPhotosPicker, selection: $selectedPhotosItems, maxSelectionCount: 0, matching: .images)
            .onChange(of: selectedPhotosItems) { _, newItems in
                guard !newItems.isEmpty else { return }
                Task {
                    var added = false
                    for item in newItems {
                        if let data = try? await item.loadTransferable(type: Data.self),
                           let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                viewModel.addImage(image)
                            }
                            added = true
                        }
                    }
                    selectedPhotosItems.removeAll()
                    if added {
                        DispatchQueue.main.async {
                            viewModel.navigationPath.append(CameraNavigationRoute.review)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    CameraView()
}
