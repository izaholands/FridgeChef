//import SwiftUI
//
//struct GeladeiraView: View {
//
//    @State private var showCamera = false
//
//    var body: some View {
//
//        NavigationStack {
//
//            VStack(spacing: 30) {
//
//                Text("Minha Geladeira")
//                    .font(.largeTitle)
//                    .bold()
//
//
//                Button {
//
//                    showCamera = true
//
//                } label: {
//
//                    HStack {
//
//                        Image(systemName: "camera.fill")
//
//                        Text("Analisar alimento")
//
//                    }
//                    .font(.headline)
//                    .padding()
//                    .frame(maxWidth: .infinity)
//                    .background(.blue)
//                    .foregroundStyle(.white)
//                    .clipShape(RoundedRectangle(cornerRadius: 15))
//
//                }
//                .padding()
//
//
//            }
//            .sheet(isPresented: $showCamera) {
//
//                CameraTesteView()
//
//            }
//
//        }
//
//    }
//}
//#Preview {
//    GeladeiraView()
//}
