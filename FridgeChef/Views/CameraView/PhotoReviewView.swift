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
        VStack {
            Text("Foto selecionada")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24)
                .padding(.top, 20)
                .foregroundColor(.secondary)
            
            if let image = viewModel.selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 400)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.horizontal, 24)
            }
            
            Button(action: {
                showActionSheet = true
            }) {
                Text("Trocar foto")
                    .font(.subheadline)
                    .foregroundColor(Color("systemPrimaryColor"))
                    .padding(.vertical, 8)
            }
            .padding(.top, 8)
            
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
                    .background(viewModel.selectedImage == nil ? Color.gray : Color("systemPrimaryColor"))
                    .cornerRadius(12)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 20)
            .disabled(viewModel.selectedImage == nil)
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
