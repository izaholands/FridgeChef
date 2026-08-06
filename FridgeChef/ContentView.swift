import SwiftUI
import SwiftData

struct ContentView: View {
    @StateObject private var cameraViewModel = CameraViewModel()
    var body: some View {
        TabView {
            CameraView()
                .environmentObject(cameraViewModel)
                .tabItem {
                    Label("Câmera", systemImage: "camera.fill")
                }
            
            RevenueView()
                .environmentObject(cameraViewModel)
                .tabItem {
                    Label("Receitas", systemImage: "fork.knife")
                }
        }
        .tint(Color("systemPrimaryColor"))
    }
}

#Preview {
    ContentView()
}
