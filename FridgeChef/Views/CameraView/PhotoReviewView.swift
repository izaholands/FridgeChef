import SwiftUI
import PhotosUI

struct PhotoReviewView: View {
    @EnvironmentObject var viewModel: CameraViewModel
    
    // Para abrir os seletores a partir do botão +
    @State private var showActionSheet = false
    @State private var showCamera = false
    @State private var showPhotosPicker = false
    @State private var selectedPhotosItems: [PhotosPickerItem] = []
    @State private var cameraImage: UIImage?
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        let count = viewModel.selectedImages.count
        
        VStack {
            Text(count == 1 ? "1 foto selecionada" : "\(count) fotos selecionadas")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24)
                .padding(.top, 20)
                .foregroundColor(.secondary)
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(viewModel.selectedImages.indices, id: \.self) { index in
                        ZStack(alignment: .topTrailing) {
                            Image(uiImage: viewModel.selectedImages[index])
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            
                            Button(action: {
                                viewModel.removeImage(at: index)
                                if viewModel.selectedImages.isEmpty {
                                    viewModel.navigationPath.removeLast()
                                }
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.white)
                                    .background(Circle().fill(Color.black.opacity(0.5)))
                            }
                            .padding(4)
                        }
                    }
                    
                    // Botão de adicionar mais fotos
                    Button(action: {
                        showActionSheet = true
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .strokeBorder(Color("systemPrimaryColor"), style: StrokeStyle(lineWidth: 2, dash: [5]))
                                .background(Color("secondColor").cornerRadius(12))
                                .frame(width: 100, height: 100)
                            
                            Image(systemName: "plus")
                                .font(.title)
                                .foregroundColor(Color("systemPrimaryColor"))
                        }
                    }
                }
                .padding(.horizontal, 24)
            }
            
            Spacer()
            
            Button(action: {
                Task {
                    await viewModel.analyzeImages()
                    viewModel.navigationPath.append(CameraNavigationRoute.ingredients)
                }
            }) {
                Text("Continuar")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(viewModel.selectedImages.isEmpty ? Color.gray : Color("systemPrimaryColor"))
                    .cornerRadius(12)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 20)
            .disabled(viewModel.selectedImages.isEmpty)
        }
        .navigationTitle("Revisar fotos")
        .navigationBarTitleDisplayMode(.inline)
        .confirmationDialog("Adicionar mais fotos", isPresented: $showActionSheet, titleVisibility: .visible) {
            Button("Tirar Foto") {
                showCamera = true
            }
            Button("Escolher da Galeria") {
                showPhotosPicker = true
            }
            Button("Cancelar", role: .cancel) { }
        }
        .sheet(isPresented: $showCamera) {
            CameraPickerView(selectedImage: $cameraImage)
        }
        .onChange(of: cameraImage) { _, newImage in
            if let img = newImage {
                viewModel.addImage(img)
            }
        }
        .photosPicker(isPresented: $showPhotosPicker, selection: $selectedPhotosItems, maxSelectionCount: 0, matching: .images)
        .onChange(of: selectedPhotosItems) { _, newItems in
            Task {
                for item in newItems {
                    if let data = try? await item.loadTransferable(type: Data.self),
                       let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            viewModel.addImage(image)
                        }
                    }
                }
                selectedPhotosItems.removeAll()
            }
        }
    }
}
