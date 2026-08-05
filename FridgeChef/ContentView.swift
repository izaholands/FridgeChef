import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        TabView {
            CameraView()
                .tabItem {
                    Label("Câmera", systemImage: "camera.fill")
                }
            
            RevenueView()
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
